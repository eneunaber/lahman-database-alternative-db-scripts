# Lahman Database SQLite Scripts

This project contains scripts to build a SQLite version of the **Lahman** baseball dataset from CSV files under `data/`.

## Project Files

- `sqlite/create_lahman_sqlite.sql`: Reset script that drops Lahman tables in a SQLite database file.
- `sqlite/load_lahman_from_csv_sqlite.sql`: Load script using `sqlite3` `.import` commands.
- `sqlite/test/validate_lahman_csv_roundtrip.sh`: Round-trip validation script.
- `data/*.csv`: Source CSV files (one file per table).

## Prerequisites

- `sqlite3` CLI available on PATH.
- `python3` available on PATH (used by validator normalization logic).

## Quick Start

Run from the repository root.

1. Reset existing Lahman tables in SQLite database file:

```bash
sqlite3 lahman.sqlite < sqlite/create_lahman_sqlite.sql
```

2. Load CSV data:

```bash
sqlite3 lahman.sqlite < sqlite/load_lahman_from_csv_sqlite.sql
```

## Notes

- The load script uses SQLite shell dot-commands (`.import`), so run with the `sqlite3` CLI.
- CSV header names become SQLite column names.
- Imported columns default to SQLite TEXT affinity when tables are created via `.import`.

## Validation

```bash
chmod +x sqlite/test/validate_lahman_csv_roundtrip.sh
DB_PATH=lahman.sqlite ./sqlite/test/validate_lahman_csv_roundtrip.sh
```

See `sqlite/test/README.md` for a fuller test flow.
