# MariaDB Test Guide (Docker Compose)

This guide validates the MariaDB conversion using:
- `mariadb/test/compose.yaml`
- `create_lahman_mariadb.sql`
- `load_lahman_from_csv_mariadb.sql`
- `mariadb/test/validate_lahman_csv_roundtrip.sh`

The validator exports query results client-side from your shell session (for example WSL). It does not require MariaDB `FILE` privilege or container bind-mount write permissions.

## 1. Start a clean MariaDB container

From `mariadb/test`:

```bash
cd mariadb/test
docker compose down -v --remove-orphans
docker compose up -d
```

## 2. Create schema

From repository root:

```bash
cd ../..
mariadb -h localhost -P 3306 -u testuser -p lahman < create_lahman_mariadb.sql
```

## 3. Load data from `data/*.csv`

From repository root:

```bash
mariadb --local-infile=1 -h localhost -P 3306 -u testuser -p lahman < load_lahman_from_csv_mariadb.sql
```

## 4. Validate round-trip output

From repository root:

```bash
chmod +x mariadb/test/validate_lahman_csv_roundtrip.sh
./mariadb/test/validate_lahman_csv_roundtrip.sh
```

Prerequisite for validator:

```bash
python3 --version
```

Remote host example:

```bash
DB_HOST=<server name> DB_PORT=3306 ./mariadb/test/validate_lahman_csv_roundtrip.sh
```
