#!/usr/bin/env bash
set -euo pipefail

DB_HOST="${DB_HOST:-localhost}"
DB_USER="testuser"
DB_NAME="lahman"
EXPORT_DIR="/tmp/lahman_exports"
WORK_DIR="/tmp/lahman_compare"

mkdir -p "$EXPORT_DIR" "$WORK_DIR"

read -rsp "Postgres password for ${DB_USER}: " PGPASSWORD
echo
export PGPASSWORD
trap 'unset PGPASSWORD' EXIT

overall_status=0

for src in ./data/*.csv; do
  base="${src##*/}"
  stem="${base%.csv}"
  table="${stem,,}"
  exported="${EXPORT_DIR}/${stem}_new.csv"

  # Export table data to client-side file in WSL.
  psql -h "$DB_HOST" -U "$DB_USER" -d "$DB_NAME" -v ON_ERROR_STOP=1 \
    -c "\\copy ${table} TO '${exported}' WITH (FORMAT csv, HEADER true)" >/dev/null

  # Normalize and compare data rows only (ignore header differences/case).
  src_norm="${WORK_DIR}/${stem}_src.norm"
  exp_norm="${WORK_DIR}/${stem}_exp.norm"

  tail -n +2 "$src" | sed 's/\r$//' | sort > "$src_norm"
  tail -n +2 "$exported" | sed 's/\r$//' | sort > "$exp_norm"

  if diff -q "$src_norm" "$exp_norm" >/dev/null; then
    echo "$base: same"
  else
    echo "$base: different"
    overall_status=1

    # Show first chunk of differences for quick diagnosis.
    diff -u "$src_norm" "$exp_norm" | head -n 60 || true
  fi
done

if [[ "$overall_status" -eq 0 ]]; then
  echo "All CSV data matches after export/normalize/sort comparison."
else
  echo "One or more CSV files differ."
fi

exit "$overall_status"
