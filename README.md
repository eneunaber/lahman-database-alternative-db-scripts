# Lahman Database Alternative Database Scripts

This repository contains scripts for creating and loading data provided by the [Lahman Baseball Database](https://sabr.org/lahman-database/) into multiple alternative database engines.

## Why?
I wanted the Lahman Baseball Database available in a non-Microsoft relational database.  

## Methodology
This project was a passion project and a good excuse to experiment with AI, in this case Codex by ChatGPT.

To begin the databse .bak file, provided by [SABR](https://sabr.org/lahman-database/), was restored to a MSSQL server. The schema for the database was exported and imported into this project. Codex was then directed to convert the schema to work for PostgreSQL. Then a script was created to load the data from the .CSV files, also provided by SABR, into the database. The final step was to validate that the data that went into the database is the same data that comes out (i.e., matches the source data found in the .CSV files). A Docker-Compose file for PostgreSQL with some pre-configured usernames and passwords was generated and a validation script was created. The Docker image was used to test all the commands against a working database. After some iterating, version one was created. The final step for version one was to create the README file.

The process was then repeated for the other databases.

The final step was to rework some parts of the README files and call version one complete.

## Database Targets

- [PostgreSQL](./postgresql/README.md)
- [MariaDB](./mariadb/README.md)
- [MySQL](./mysql/README.md)
- [SQLite](./sqlite/README.md)

## Version
- 2025.1.0.0 - Initial release that matches Lahman Baseball Database Version 2025, released January 2, 2026

## Project Structure

- `create_lahman_mssql_script.sql`: original SQL Server source script used as the baseline for conversions
- `data/*.csv`: Lahman CSV files used for loading and round-trip validation
- `postgresql/`: PostgreSQL schema, load scripts, and test workflow
- `mariadb/`: MariaDB schema, load scripts, and test workflow
- `mysql/`: MySQL schema, load scripts, and test workflow
- `sqlite/`: SQLite schema, load scripts, and test workflow

## What This Project Provides

- Schema creation scripts for each supported database
- CSV load/import scripts
- Validation scripts to compare exported database contents back to source CSV data
- Database-specific setup and testing documentation

## Data Source

> The Lahman Baseball Database, created by SABR member Sean Lahman, contains complete major league batting and pitching statistics back to 1871, plus fielding statistics, standings, team stats, managerial records, postseason data, and more

The [Lahman Baseball Database](https://sabr.org/lahman-database/) is provided by SABR and can be found [here](https://sabr.org/lahman-database/).


## License

This repository is licensed under the MIT License. See [LICENSE](./LICENSE).
