# Lahman Database MySQL Scripts

This project contains scripts and CSV data to build the **Lahman** baseball database in MySQL from the supplied Lahman CSV files.

## Project Files

- `create_lahman_mssql_script.sql`: Original SQL Server schema script.
- `mysql/create_lahman_mysql.sql`: MySQL-converted schema script.
- `mysql/load_lahman_from_csv_mysql.sql`: Post-create data load script using `LOAD DATA LOCAL INFILE`.
- `data/*.csv`: Source directory to place comma delimited files from https://sabr.org/lahman-database/ (one CSV per table).
- `mysql/test/`: Docker Compose and validation scripts for round-trip testing.

## Prerequisites

- MySQL (recommended v8.0+).
- `mysql` client available on PATH.
- Permissions to create a database and objects.
- Client/server support for local infile (`--local-infile=1`) when loading CSVs.

## Quick Start

Run from the repository root.

1. Apply schema:

```bash
mysql -h <server-name> -P 3306 -u <username> -p < mysql/create_lahman_mysql.sql
```

2. Load CSV data:

```bash
mysql --local-infile=1 -h <server-name> -P 3306 -u <username> -p lahman < mysql/load_lahman_from_csv_mysql.sql
```

## Notes

- The schema script creates database `lahman` if it does not already exist.
- The load script expects CSV files at `./data/*.csv` relative to repository root.
- Empty CSV values are converted to `NULL` where columns are nullable.
- Some views rely on a compatibility `TRANSLATE(...)` function shim included in the schema script.

## Validation

Use the test harness in `mysql/test` to verify round-trip data fidelity.

```bash
./mysql/test/validate_lahman_csv_roundtrip.sh
```

Remote host example:

```bash
DB_HOST=<server name> DB_PORT=3306 ./mysql/test/validate_lahman_csv_roundtrip.sh
```

See `mysql/test/README.md` for full Docker-based test workflow.

## Troubleshooting

- If load fails with `The used command is not allowed with this MySQL version`, ensure both server and client allow local infile and use `--local-infile=1`.
- If CSV files are not found, run commands from repository root so `./data/*.csv` paths resolve.
- If create script fails on views, confirm the schema script ran from the top so required helper function definitions are present.
- If create script fails with `ERROR 1419` while creating `TRANSLATE`, enable trusted function creators on the server (for Docker Compose, `--log-bin-trust-function-creators=1` is included in `mysql/test/compose.yaml`).
- If the validator fails with socket errors on Linux/WSL, run it with `DB_HOST=<server name>` (for example `DB_HOST=el-mini-pc.home`) to force TCP.

## Attribution and License

The underlying Lahman dataset is provided by SABR/Sean Lahman. Refer to them for the official copyright,
license, and contact information.
