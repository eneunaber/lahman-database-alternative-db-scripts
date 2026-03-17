# Lahman Database SQLite Scripts

This project contains SQL scripts designed to create and populate a SQLite version of the [Lahman Baseball Database](https://sabr.org/lahman-database/) using CSV datasets provided by [SABR](https://sabr.org/lahman-database/).

## Project Files

- `sqlite/create_lahman_sqlite.sql`: Reset/create script that rebuilds strict tables in a SQLite database file.
- `sqlite/load_lahman_from_csv_sqlite.sql`: Wrapper load script that calls the Python staging loader.
- `sqlite/load_lahman_from_csv_sqlite.py`: Strict-safe staging loader for CSV imports.
- `sqlite/test/validate_lahman_csv_roundtrip.sh`: Round-trip validation script.
- `data/*.csv`: Source CSV files (one file per table).

## Prerequisites

- `sqlite3` CLI available on PATH.
- `python3` available on PATH (used by loader and validator logic).

## Quick Start

Run from the repository root.

1. Create/reset strict schema:

```bash
sqlite3 lahman.sqlite < sqlite/create_lahman_sqlite.sql
```

2. Load CSV data:

```bash
sqlite3 lahman.sqlite < sqlite/load_lahman_from_csv_sqlite.sql
```

This wrapper calls `sqlite/load_lahman_from_csv_sqlite.py`, so `python3` must be available when you run it.

## Notes

- The create script contains committed `DROP TABLE` + `CREATE TABLE ... STRICT` statements.
- SQLite types are mapped from SQL Server types (`INTEGER`, `REAL`, `TEXT`, `BLOB`) for stricter consistency than auto-created all-text tables.
- The load wrapper calls a Python staging loader that:
  - loads raw CSV rows into temp TEXT tables
  - inserts into strict target tables using trim/NULL conversions
  - avoids strict-type failures from blank numeric CSV values

## Testing & Validation

```bash
#This assumes you are running the validation command within the same folder as the SQLite database
chmod +x sqlite/test/validate_lahman_csv_roundtrip.sh
DB_PATH=lahman.sqlite ./sqlite/test/validate_lahman_csv_roundtrip.sh
```

The validator normalizes exported SQLite values by declared column type before diffing. This avoids false mismatches such as `4` versus `4.0` in `REAL` columns.

### Notes:

- The validation methodology is to ensure the data that went in, is exactly the same data that comes back out.
- With the other databases a Docker compose file is provided to allow for local testing. SQLite is file-based, so no Docker database server is required and the script above is all that is needed to test.
- `sqlite/load_lahman_from_csv_sqlite.sql` calls `sqlite/load_lahman_from_csv_sqlite.py`, so `python3` must be available.
- The validator also requires `python3`.
- Run commands from repository root so `./data/*.csv` paths resolve.

## Attribution and License

The underlying Lahman dataset is provided by SABR/Sean Lahman. Refer to them for the official copyright,
license, and contact information.
