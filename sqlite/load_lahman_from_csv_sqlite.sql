-- Load Lahman CSV data into SQLite from ./data.
-- Run from repository root:
--   sqlite3 lahman.sqlite < sqlite/load_lahman_from_csv_sqlite.sql
--
-- Notes:
-- - Uses sqlite shell commands (.mode/.import), not pure SQL.
-- - Tables are created on first import using CSV headers as column names.
-- - All imported columns use SQLite TEXT affinity by default.

.bail on
.mode csv

.import ./data/AllstarFull.csv AllstarFull
.import ./data/Appearances.csv Appearances
.import ./data/AwardsManagers.csv AwardsManagers
.import ./data/AwardsPlayers.csv AwardsPlayers
.import ./data/AwardsShareManagers.csv AwardsShareManagers
.import ./data/AwardsSharePlayers.csv AwardsSharePlayers
.import ./data/Batting.csv Batting
.import ./data/BattingPost.csv BattingPost
.import ./data/CollegePlaying.csv CollegePlaying
.import ./data/Fielding.csv Fielding
.import ./data/FieldingOF.csv FieldingOF
.import ./data/FieldingOFsplit.csv FieldingOFsplit
.import ./data/FieldingPost.csv FieldingPost
.import ./data/HallOfFame.csv HallOfFame
.import ./data/HomeGames.csv HomeGames
.import ./data/Managers.csv Managers
.import ./data/ManagersHalf.csv ManagersHalf
.import ./data/Parks.csv Parks
.import ./data/People.csv People
.import ./data/Pitching.csv Pitching
.import ./data/PitchingPost.csv PitchingPost
.import ./data/Salaries.csv Salaries
.import ./data/Schools.csv Schools
.import ./data/SeriesPost.csv SeriesPost
.import ./data/Teams.csv Teams
.import ./data/TeamsFranchises.csv TeamsFranchises
.import ./data/TeamsHalf.csv TeamsHalf
