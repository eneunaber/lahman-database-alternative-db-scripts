# MySQL Test Guide (Docker Compose)

This guide validates the MySQL conversion using:
- `mysql/test/compose.yaml`
- `create_lahman_mysql.sql`
- `load_lahman_from_csv_mysql.sql`
- `mysql/test/validate_lahman_csv_roundtrip.sh`

The validator exports query results client-side from your shell session (for example WSL). It does not require MySQL `FILE` privilege or container bind-mount write permissions.

## 1. Start a clean MySQL container

From `mysql/test`:

```bash
cd mysql/test
docker compose down -v --remove-orphans
docker compose up -d
```

## 2. Create schema

From repository root:

```bash
cd ../..
mysql -h localhost -P 3306 -u testuser -p < mysql/create_lahman_mysql.sql
```

## 3. Load data from `data/*.csv`

From repository root:

```bash
mysql --local-infile=1 -h localhost -P 3306 -u testuser -p lahman < mysql/load_lahman_from_csv_mysql.sql
```

## 4. Validate round-trip output

From repository root:

```bash
chmod +x mysql/test/validate_lahman_csv_roundtrip.sh
./mysql/test/validate_lahman_csv_roundtrip.sh
```

Prerequisite for validator:

```bash
python3 --version
```

Remote host example:

```bash
DB_HOST=<server name> DB_PORT=3306 ./mysql/test/validate_lahman_csv_roundtrip.sh
```

Note:
- The validator defaults `DB_HOST=localhost`, which may use a local Unix socket instead of TCP on Linux/WSL.
- For remote Docker hosts, set `DB_HOST` explicitly (for example `DB_HOST=el-mini-pc.home`).
