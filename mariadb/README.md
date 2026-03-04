# Lahman Database MariaDB Scripts

This project contains scripts and CSV data to build the **Lahman** baseball database in MariaDB from the supplied Lahman CSV files.

## Project Files

- `create_lahman_mssql_script.sql`: Original SQL Server schema script.
- `mariadb/create_lahman_mariadb.sql`: MariaDB-converted schema script.
- `mariadb/load_lahman_from_csv_mariadb.sql`: Post-create data load script using `LOAD DATA LOCAL INFILE`.
- `data/*.csv`: Source directory to place comma delimited files from https://sabr.org/lahman-database/ (one CSV per table).
- `mariadb/test/`: Docker Compose and validation scripts for round-trip testing.

## Prerequisites

- MariaDB (recommended v10.6+).
- `mariadb` client available on PATH.
- Permissions to create a database and objects.
- Client/server support for local infile (`--local-infile=1`) when loading CSVs.

## Quick Start

Run from the repository root.

1. Apply schema:

```bash
mariadb -h <server-name> -P 3306 -u <username> -p < mariadb/create_lahman_mariadb.sql
```

2. Load CSV data:

```bash
mariadb --local-infile=1 -h <server-name> -P 3306 -u <username> -p lahman < mariadb/load_lahman_from_csv_mariadb.sql
```

## Notes

- The schema script creates database `lahman` if it does not already exist.
- The load script expects CSV files at `./data/*.csv` relative to repository root.
- Empty CSV values are converted to `NULL` where columns are nullable.
- Some views rely on a compatibility `TRANSLATE(...)` function shim included in the schema script.

## Validation

Use the test harness in `mariadb/test` to verify round-trip data fidelity.

```bash
./mariadb/test/validate_lahman_csv_roundtrip.sh
```

Remote host example:

```bash
DB_HOST=<server name> DB_PORT=3306 ./mariadb/test/validate_lahman_csv_roundtrip.sh
```

See `mariadb/test/README.md` for full Docker-based test workflow.

## Troubleshooting

- If load fails with `The used command is not allowed with this MariaDB version`, ensure both server and client allow local infile and use `--local-infile=1`.
- If CSV files are not found, run commands from repository root so `./data/*.csv` paths resolve.
- If create script fails on views, confirm the schema script ran from the top so required helper function definitions are present.

## Attribution and License

The underlying Lahman dataset is provided by SABR/Sean Lahman. Refer to them for the official copyright,
license, and contact information.