# SQLite Test Guide

This guide validates the SQLite conversion using:
- `sqlite/create_lahman_sqlite.sql`
- `sqlite/load_lahman_from_csv_sqlite.sql`
- `sqlite/test/validate_lahman_csv_roundtrip.sh`

SQLite is file-based, so no Docker database server is required.

## 1. Create/reset tables

From repository root:

```bash
sqlite3 lahman.sqlite < sqlite/create_lahman_sqlite.sql
```

## 2. Load data from `data/*.csv`

From repository root:

```bash
sqlite3 lahman.sqlite < sqlite/load_lahman_from_csv_sqlite.sql
```

This wrapper invokes `sqlite/load_lahman_from_csv_sqlite.py`, so `python3` must be available.

## 3. Validate round-trip output

From repository root:

```bash
chmod +x sqlite/test/validate_lahman_csv_roundtrip.sh
DB_PATH=lahman.sqlite ./sqlite/test/validate_lahman_csv_roundtrip.sh
```

Prerequisites:

```bash
sqlite3 --version
python3 --version
```

Notes:
- `sqlite/create_lahman_sqlite.sql` drops and recreates SQLite tables from committed SQL.
- `sqlite/load_lahman_from_csv_sqlite.sql` calls `sqlite/load_lahman_from_csv_sqlite.py` for strict-safe staging imports.
- `sqlite/test/validate_lahman_csv_roundtrip.sh` normalizes values by declared SQLite column type before comparison, which prevents false diffs for values like `4` and `4.0` in `REAL` columns.
- Run commands from repository root so `./data/*.csv` paths resolve.
