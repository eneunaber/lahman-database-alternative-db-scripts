#!/usr/bin/env bash
set -euo pipefail

DB_PATH="${DB_PATH:-lahman.sqlite}"
SCRIPT_DIR="$(cd -- "$(dirname -- "${BASH_SOURCE[0]}")" && pwd)"
REPO_ROOT="$(cd -- "$SCRIPT_DIR/../.." && pwd)"
DATA_DIR="$REPO_ROOT/data"
WORK_DIR="/tmp/lahman_sqlite_compare"

mkdir -p "$WORK_DIR"

if ! command -v sqlite3 >/dev/null 2>&1; then
  echo "sqlite3 is required but was not found."
  exit 2
fi

if ! command -v python3 >/dev/null 2>&1; then
  echo "python3 is required for CSV normalization but was not found."
  exit 2
fi

if [[ ! -f "$DB_PATH" ]]; then
  echo "SQLite database file not found: $DB_PATH"
  exit 2
fi

overall_status=0

for src in "$DATA_DIR"/*.csv; do
  base="${src##*/}"
  stem="${base%.csv}"
  table="$stem"
  db_tsv="$WORK_DIR/${stem}_db.tsv"

  table_exists="$(sqlite3 "$DB_PATH" "SELECT COUNT(*) FROM sqlite_master WHERE type='table' AND name='$table';")"
  if [[ "$table_exists" -eq 0 ]]; then
    echo "$base: table '$table' not found"
    overall_status=1
    continue
  fi

  select_list=""
  while IFS= read -r col; do
    [[ -z "$col" ]] && continue
    expr="IFNULL(CAST(\"$col\" AS TEXT), '') AS \"$col\""
    if [[ -z "$select_list" ]]; then
      select_list="$expr"
    else
      select_list="$select_list, $expr"
    fi
  done < <(sqlite3 "$DB_PATH" "PRAGMA table_info(\"$table\");" | awk -F'|' '{print $2}')

  if [[ -z "$select_list" ]]; then
    echo "$base: no columns found for table '$table'"
    overall_status=1
    continue
  fi

  sqlite3 -tabs -noheader "$DB_PATH" "SELECT $select_list FROM \"$table\";" > "$db_tsv"

  src_norm="$WORK_DIR/${stem}_src.norm"
  exp_norm="$WORK_DIR/${stem}_exp.norm"

  python3 - "$src" "$src_norm" <<'PY'
import csv
import sys

src, out = sys.argv[1], sys.argv[2]
with open(src, newline='', encoding='utf-8') as f, open(out, 'w', encoding='utf-8', newline='') as o:
    r = csv.reader(f)
    next(r, None)
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
  echo "All CSV data matches after SQLite export/normalize/sort comparison."
else
  echo "One or more CSV files differ."
fi

exit "$overall_status"
