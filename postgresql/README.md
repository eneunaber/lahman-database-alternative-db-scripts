# Lahman Database PostgreSQL Scripts

This project contains SQL scripts designed to create and populate a PostgreSQL version of the [Lahman Baseball Database](https://sabr.org/lahman-database/) using CSV datasets provided by [SABR](https://sabr.org/lahman-database/).

## Project Files
- `postgresql/create_lahman_postgres.sql`: Schema script for a PostgreSQL.
- `postgresql/load_lahman_from_csv_postgres.sql`: Post-create data load script using `psql` `\copy`.
- `data/*.csv`: Source directory to place comma delimited files from https://sabr.org/lahman-database/ (one CSV per table).

## Prerequisites

- PostgreSQL (recommended v11+).
- `psql` client available on PATH.
- Permissions to create a database and schema.

## Quick Start

Run from the repository root.****

1. Create database:

```bash
psql -h <server-name> -p 5432 -U <username> -d postgres -c "CREATE DATABASE lahman;"
```

2. Apply schema:

```bash
psql -h <server-name> -p 5432 -U <username> -d lahman -v ON_ERROR_STOP=1 -f postgresql/create_lahman_postgres.sql
```

3. Load CSV data:

```bash
psql -h <server-name> -p 5432 -U <username> -d lahman -v ON_ERROR_STOP=1 -f postgresql/load_lahman_from_csv_postgres.sql
```

## Notes

- The load script uses `\copy`, which reads CSV files from the **client machine** running `psql`.
- The script sets `search_path` to `public` and loads into `public` tables.
- CSV files are mapped to tables by matching file/table names (for example `data/Batting.csv` -> `public.batting`).
- Empty CSV values are loaded as `NULL` (`NULL ''`).

## Testing & Validation

There is a Docker compose file provided to easily create a PostgreSQL database for testing. You can validate the PostgreSQL workflow with the Docker-based test harness in `postgresql/test`.

### Prerequisites:

- Docker + Docker Compose
- `psql` client available on PATH
- Run commands from the repository root so `./data/*.csv` paths resolve

Create & Load (Remote host example):

#### 1. Start With a Clean Database

Files located in `postgresql/test`:

```bash
# Copy Docker Compose to your remote host, from the location where the files are stored
docker compose down -v --remove-orphans
docker compose up -d
```

This removes the `pgdata` volume so no previous data is reused.

#### 2. Create Schema

From project root:

```bash
# Likely, You are connecting to the remote host from your machine
psql -h <server-name>  -U testuser -d lahman -f postgresql/create_lahman_postgres.sql
```

#### 3. Load CSV Data

From project root:

```bash
psql -h <server-name>  -U testuser -d lahman -f postgresql/load_lahman_from_csv_postgres.sql
```

#### 4. Run Round-Trip Validation

From project root:

```bash
chmod +x postgresql/test/validate_lahman_csv_roundtrip.sh
DB_HOST=<server name> ./postgresql/test/validate_lahman_csv_roundtrip.sh
```

Expected successful ending:

```text
All CSV data matches after export/normalize/sort comparison.
```

If any table differs, the script prints `different` and a small diff preview.

### Notes:
- The validation methodology is to ensure the data that went in, is exactly the same data that comes back out.
- The validation script compares data rows only, normalizes line endings, and sorts rows before comparing.
- Expected success output ends with `All CSV data matches after export/normalize/sort comparison.`
- If any table differs, the script prints `different` and a short diff preview.

## Troubleshooting

- If `\copy` reports file not found, run from repository root so `./data/*.csv` paths resolve, or update paths in `postgresql/load_lahman_from_csv_postgres.sql`.
- If schema creation fails, ensure the database exists and that you have create permissions.
- If load fails on a specific table, inspect the CSV header for column alignment with that table.

## Attribution and License

The underlying Lahman dataset is provided by SABR/Sean Lahman. Refer to them for the official copyright,
license, and contact information.
