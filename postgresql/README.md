# Lahman Database PostgreSQL Scripts

This project contains scripts and CSV data to build the **Lahman** baseball database in PostgreSQL from the supplied Lahman CSV files.

## Project Files

- `create_lahman_mssql_script.sql`: Original SQL Server schema script.
- `postgresql/create_lahman_postgres.sql`: PostgreSQL-converted schema script.
- `postgresql/load_lahman_from_csv_postgres.sql`: Post-create data load script using `psql` `\copy`.
- `data/*.csv`: Source directory to place comma delimited files from https://sabr.org/lahman-database/ (one CSV per table).

## Prerequisites

- PostgreSQL (recommended v11+).
- `psql` client available on PATH.
- Permissions to create a database and schema.

## Quick Start

Run from the repository root.

1. Create database:

```sql
CREATE DATABASE lahman;
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

## Validation Queries

After load, you can run:

```sql
SELECT COUNT(*) FROM public.people;
SELECT COUNT(*) FROM public.teams;
SELECT COUNT(*) FROM public.batting;
```

## Troubleshooting

- If `\copy` reports file not found, run from repository root so `./data/*.csv` paths resolve, or update paths in `postgresql/load_lahman_from_csv_postgres.sql`.
- If schema creation fails, ensure the database exists and that you have create permissions.
- If load fails on a specific table, inspect the CSV header for column alignment with that table.

## Attribution and License

The underlying Lahman dataset is provided by SABR/Sean Lahman. Refer to them for the official copyright,
license, and contact information.
