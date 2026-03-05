-- SQLite setup/reset script for Lahman imports.
-- Run from repository root:
--   sqlite3 lahman.sqlite < sqlite/create_lahman_sqlite.sql

PRAGMA foreign_keys = OFF;

DROP TABLE IF EXISTS "AllstarFull";
DROP TABLE IF EXISTS "Appearances";
DROP TABLE IF EXISTS "AwardsManagers";
DROP TABLE IF EXISTS "AwardsPlayers";
DROP TABLE IF EXISTS "AwardsShareManagers";
DROP TABLE IF EXISTS "AwardsSharePlayers";
DROP TABLE IF EXISTS "Batting";
DROP TABLE IF EXISTS "BattingPost";
DROP TABLE IF EXISTS "CollegePlaying";
DROP TABLE IF EXISTS "Fielding";
DROP TABLE IF EXISTS "FieldingOF";
DROP TABLE IF EXISTS "FieldingOFsplit";
DROP TABLE IF EXISTS "FieldingPost";
DROP TABLE IF EXISTS "HallOfFame";
DROP TABLE IF EXISTS "HomeGames";
DROP TABLE IF EXISTS "Managers";
DROP TABLE IF EXISTS "ManagersHalf";
DROP TABLE IF EXISTS "Parks";
DROP TABLE IF EXISTS "People";
DROP TABLE IF EXISTS "Pitching";
DROP TABLE IF EXISTS "PitchingPost";
DROP TABLE IF EXISTS "Salaries";
DROP TABLE IF EXISTS "Schools";
DROP TABLE IF EXISTS "SeriesPost";
DROP TABLE IF EXISTS "Teams";
DROP TABLE IF EXISTS "TeamsFranchises";
DROP TABLE IF EXISTS "TeamsHalf";
