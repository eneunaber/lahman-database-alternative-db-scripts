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
  type_map="$WORK_DIR/${stem}_types.tsv"

  table_exists="$(sqlite3 "$DB_PATH" "SELECT COUNT(*) FROM sqlite_master WHERE type='table' AND name='$table';")"
  if [[ "$table_exists" -eq 0 ]]; then
    echo "$base: table '$table' not found"
    overall_status=1
    continue
  fi

  select_list=""
  : > "$type_map"
  while IFS='|' read -r _cid col col_type _notnull _default _pk; do
    [[ -z "$col" ]] && continue
    printf '%s\t%s\n' "$col" "$col_type" >> "$type_map"
    expr="IFNULL(CAST(\"$col\" AS TEXT), '') AS \"$col\""
    if [[ -z "$select_list" ]]; then
      select_list="$expr"
    else
      select_list="$select_list, $expr"
    fi
  done < <(sqlite3 "$DB_PATH" "PRAGMA table_info(\"$table\");")

  if [[ -z "$select_list" ]]; then
    echo "$base: no columns found for table '$table'"
    overall_status=1
    continue
  fi

  sqlite3 -tabs -noheader "$DB_PATH" "SELECT $select_list FROM \"$table\";" > "$db_tsv"

  src_norm="$WORK_DIR/${stem}_src.norm"
  exp_norm="$WORK_DIR/${stem}_exp.norm"

  python3 - "$src" "$db_tsv" "$src_norm" "$exp_norm" "$type_map" <<'PY'
import csv
import decimal
import sys

src, db_tsv, src_out, exp_out, type_map = sys.argv[1:6]


def canon(value: str, declared_type: str) -> str:
    if value == "":
        return ""
    t = (declared_type or "").upper()
    if "REAL" in t or "FLOA" in t or "DOUB" in t:
        d = decimal.Decimal(value)
        if d == d.to_integral_value():
            return f"{d.quantize(decimal.Decimal('0.0'))}"
        return format(d.normalize(), "f")
    if "INT" in t:
        return str(int(decimal.Decimal(value)))
    return value


types = []
with open(type_map, encoding="utf-8", newline="") as f:
    for line in f:
        line = line.rstrip("\n")
        if not line:
            continue
        col, declared = line.split("\t", 1)
        types.append((col, declared))

with open(src, newline='', encoding='utf-8-sig') as f, open(src_out, 'w', encoding='utf-8', newline='') as o:
    r = csv.reader(f)
    header = next(r, None)
    for row in r:
        row = [canon(v, types[i][1] if i < len(types) else "") for i, v in enumerate(row)]
        o.write('\t'.join(row))
        o.write('\n')

with open(db_tsv, newline='', encoding='utf-8') as f, open(exp_out, 'w', encoding='utf-8', newline='') as o:
    for raw in f:
        row = raw.rstrip('\n').rstrip('\r').split('\t')
        row = [canon(v, types[i][1] if i < len(types) else "") for i, v in enumerate(row)]
        o.write('\t'.join(row))
        o.write('\n')
PY

  sort "$src_norm" -o "$src_norm"
  sort "$exp_norm" -o "$exp_norm"

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
