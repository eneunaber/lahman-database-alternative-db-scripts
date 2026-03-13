-- Wrapper load script for SQLite strict-schema imports.
-- Run from repository root:
--   sqlite3 lahman.sqlite < sqlite/load_lahman_from_csv_sqlite.sql
--
-- This delegates to the Python staging loader, which imports CSV rows
-- into temp TEXT tables and inserts into strict target tables with
-- NULL/trim conversion for nullable numeric fields.

.bail on
.shell python3 ./sqlite/load_lahman_from_csv_sqlite.py ./lahman.sqlite
