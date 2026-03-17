# Lahman Database MySQL Scripts

This project contains SQL scripts designed to create and populate a MySQL version of the [Lahman Baseball Database](https://sabr.org/lahman-database/) using CSV datasets provided by [SABR](https://sabr.org/lahman-database/).

## Project Files

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

## Testing & Validation

There is a Docker compose file provided to easily create a MariaDB database for testing. You can validate the PostgreSQL workflow with the Docker-based test harness in Use the test harness in `mysql/test`.

### Prerequisites:

- Docker + Docker Compose
- python3 --version
- Run commands from the repository root so `./data/*.csv` paths resolve

### 1. Start a clean MySQL container:

```bash
# Copy Docker Compose to your remote host, from the location where the files are stored
docker compose down -v --remove-orphans
docker compose up -d
```

### 2. Create schema:

```bash
# Likely, You are connecting to the remote host from your machine
mysql -h <server name> -P 3306 -u testuser -p < mysql/create_lahman_mysql.sql
```

### 3. Load data from `data/*.csv`:

```bash
mysql --local-infile=1 -h <server name> -P 3306 -u testuser -p lahman < mysql/load_lahman_from_csv_mysql.sql
```

### 4. Validate round-trip output:

```bash
chmod +x mysql/test/validate_lahman_csv_roundtrip.sh
DB_HOST=<server name> DB_PORT=3306 ./mysql/test/validate_lahman_csv_roundtrip.sh
```

### Notes:

- The validator exports query results client-side and does not require MySQL `FILE` privilege.
- The validator defaults `DB_HOST=localhost`, which may use a Unix socket on Linux/WSL. Set `DB_HOST=<server name>` to force TCP for remote hosts.

## Troubleshooting

- If load fails with `The used command is not allowed with this MySQL version`, ensure both server and client allow local infile and use `--local-infile=1`.
- If CSV files are not found, run commands from repository root so `./data/*.csv` paths resolve.
- If create script fails on views, confirm the schema script ran from the top so required helper function definitions are present.
- If create script fails with `ERROR 1419` while creating `TRANSLATE`, enable trusted function creators on the server (for Docker Compose, `--log-bin-trust-function-creators=1` is included in `mysql/test/compose.yaml`).
- If the validator fails with socket errors on Linux/WSL, run it with `DB_HOST=<server name>` (for example `DB_HOST=el-mini-pc.home`) to force TCP.

## Attribution and License

The underlying Lahman dataset is provided by SABR/Sean Lahman. Refer to them for the official copyright,
license, and contact information.
