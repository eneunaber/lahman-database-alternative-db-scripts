#!/usr/bin/env bash
set -euo pipefail

DB_HOST="${DB_HOST:-localhost}"
DB_PORT="${DB_PORT:-3306}"
DB_USER="${DB_USER:-testuser}"
DB_NAME="${DB_NAME:-lahman}"
SCRIPT_DIR="$(cd -- "$(dirname -- "${BASH_SOURCE[0]}")" && pwd)"
REPO_ROOT="$(cd -- "$SCRIPT_DIR/../.." && pwd)"
DATA_DIR="$REPO_ROOT/data"
WORK_DIR="/tmp/lahman_mysql_compare"

mkdir -p "$WORK_DIR"

read -rsp "MySQL password for ${DB_USER}: " DB_PASSWORD
echo

if ! command -v python3 >/dev/null 2>&1; then
  echo "python3 is required for CSV normalization but was not found."
  exit 2
fi

overall_status=0

for src in "$DATA_DIR"/*.csv; do
  base="${src##*/}"
  stem="${base%.csv}"
  table="${stem}"
  db_tsv="$WORK_DIR/${stem}_db.tsv"

  table_exists=$(mysql -h "$DB_HOST" -P "$DB_PORT" -u "$DB_USER" -p"$DB_PASSWORD" -N -s "$DB_NAME" -e \
    "SELECT COUNT(*) FROM INFORMATION_SCHEMA.TABLES WHERE TABLE_SCHEMA = DATABASE() AND TABLE_NAME = '$table';")

  if [[ "$table_exists" -eq 0 ]]; then
    echo "$base: table '$table' not found"
    overall_status=1
    continue
  fi

  # Build a safe select list in Bash to normalize NULL to empty string.
  select_list=""
  while IFS= read -r col; do
    [[ -z "$col" ]] && continue
    printf -v expr "IFNULL(CAST(\`%s\` AS CHAR), '') AS \`%s\`" "$col" "$col"
    if [[ -z "$select_list" ]]; then
      select_list="$expr"
    else
      select_list="$select_list, $expr"
    fi
  done < <(
    mysql -h "$DB_HOST" -P "$DB_PORT" -u "$DB_USER" -p"$DB_PASSWORD" -N -s "$DB_NAME" -e \
      "SELECT COLUMN_NAME
       FROM INFORMATION_SCHEMA.COLUMNS
       WHERE TABLE_SCHEMA = DATABASE() AND TABLE_NAME = '$table'
       ORDER BY ORDINAL_POSITION;"
  )

  if [[ -z "$select_list" ]]; then
    echo "$base: no columns found for table '$table'"
    overall_status=1
    continue
  fi

  # Export table rows to a local TSV file from the client side (WSL).
  mysql -h "$DB_HOST" -P "$DB_PORT" -u "$DB_USER" -p"$DB_PASSWORD" \
    --batch --raw --skip-column-names "$DB_NAME" \
    -e "SELECT $select_list FROM \`$table\`;" > "$db_tsv"

  src_norm="$WORK_DIR/${stem}_src.norm"
  exp_norm="$WORK_DIR/${stem}_exp.norm"

  # Normalize source CSV rows to TSV so quoting/commas are handled correctly.
  python3 - "$src" "$src_norm" <<'PY'
import csv
import sys

src, out = sys.argv[1], sys.argv[2]
with open(src, newline='', encoding='utf-8') as f, open(out, 'w', encoding='utf-8', newline='') as o:
    r = csv.reader(f)
    next(r, None)  # header
    for row in r:
        o.write('\t'.join(row))
        o.write('\n')
PY

  sort "$src_norm" -o "$src_norm"
  sed 's/\r$//' "$db_tsv" | sort > "$exp_norm"

  if diff -q "$src_norm" "$exp_norm" >/dev/null; then
    echo "$base: same"
  else
    echo "$base: different"
    overall_status=1
    diff -u "$src_norm" "$exp_norm" | head -n 80 || true
  fi
done

if [[ "$overall_status" -eq 0 ]]; then
  echo "All CSV data matches after MySQL export/normalize/sort comparison."
else
  echo "One or more CSV files differ."
fi

exit "$overall_status"
