# Lahman Database MariaDB Scripts

This project contains SQL scripts designed to create and populate a MariaDB version of the [Lahman Baseball Database](https://sabr.org/lahman-database/) using CSV datasets provided by [SABR](https://sabr.org/lahman-database/).

## Project Files

- `mariadb/create_lahman_mariadb.sql`: Schema script for a MariaDB.
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

## Testing & Validation

There is a Docker compose file provided to easily create a MariaDB database for testing. You can validate the PostgreSQL workflow with the Docker-based test harness in Use the test harness in `mariadb/test`.

### Prerequisites:

- Docker + Docker Compose
- python3 --version
- Run commands from the repository root so `./data/*.csv` paths resolve

#### 1. Start With a Clean Database

Files located in `mariadb/test`:

```bash
# Copy Docker Compose to your remote host, from the location where the files are stored
docker compose down -v --remove-orphans
docker compose up -d
```

### 2. Create schema

From repository root:

```bash
# Likely, You are connecting to the remote host from your machine
mariadb -h <server-name> -P 3306 -u testuser -p lahman < create_lahman_mariadb.sql
```

### 3. Load data from `data/*.csv`

From repository root:

```bash
mariadb --local-infile=1 -h <server-name> -P 3306 -u testuser -p lahman < load_lahman_from_csv_mariadb.sql
```

### 4. Validate round-trip output

From repository root:

```bash
chmod +x mariadb/test/validate_lahman_csv_roundtrip.sh
DB_HOST=<server name> DB_PORT=3306 ./mariadb/**test**/validate_lahman_csv_roundtrip.sh
```

### Notes:

- The validator exports query results client-side and does not require MariaDB `FILE` privilege.
- For remote Docker hosts, set `DB_HOST` explicitly.

## Troubleshooting

- If load fails with `The used command is not allowed with this MariaDB version`, ensure both server and client allow local infile and use `--local-infile=1`.
- If CSV files are not found, run commands from repository root so `./data/*.csv` paths resolve.
- If create script fails on views, confirm the schema script ran from the top so required helper function definitions are present.

## Attribution and License

The underlying Lahman dataset is provided by SABR/Sean Lahman. Refer to them for the official copyright,
license, and contact information.
