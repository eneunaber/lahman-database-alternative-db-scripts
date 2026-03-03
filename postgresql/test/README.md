# PostgreSQL Test Guide (Docker Compose)

This guide validates the PostgreSQL conversion using:
- `postgresql/test/compose.yaml`
- `postgresql/create_lahman_postgres.sql`
- `postgresql/load_lahman_from_csv_postgres.sql`
- `postgresql/test/validate_lahman_csv_roundtrip.sh`

## Prerequisites

- Docker + Docker Compose
- `psql` client available in your shell
- Run commands from the project root:
  - `lahman-database-conversion-scripts/`

## 1. Start With a Clean Database

From `postgresql/test`:

```bash
cd postgresql/test
docker compose down -v --remove-orphans
docker compose up -d
```

This removes the `pgdata` volume so no previous data is reused.

## 2. Create Schema

From project root:

```bash
cd ../..
psql -h localhost -U testuser -d lahman -f postgresql/create_lahman_postgres.sql
```

## 3. Load CSV Data

From project root:

```bash
psql -h localhost -U testuser -d lahman -f postgresql/load_lahman_from_csv_postgres.sql
```

## 4. Run Round-Trip Validation

From project root:

```bash
chmod +x postgresql/test/validate_lahman_csv_roundtrip.sh
./postgresql/test/validate_lahman_csv_roundtrip.sh
```

To target a remote PostgreSQL host for this step, pass `DB_HOST` as an environment variable:

```bash
DB_HOST=<server name> ./postgresql/test/validate_lahman_csv_roundtrip.sh
```

Expected successful ending:

```text
All CSV data matches after export/normalize/sort comparison.
```

If any table differs, the script prints `different` and a small diff preview.

## Notes

- The validation script compares data rows only (header removed), normalizes line endings, and sorts rows before comparing.
- Because the script reads `./data/*.csv`, running it from `postgresql/test` will not work as intended. Run it from repo root.
- `validate_lahman_csv_roundtrip.sh` uses:
  - `DB_HOST="${DB_HOST:-localhost}"`
  - It defaults to `localhost` and can be overridden per run with `DB_HOST=<host>`.

## Optional Cleanup

Stop containers when done:

```bash
cd postgresql/test
docker compose down
```
