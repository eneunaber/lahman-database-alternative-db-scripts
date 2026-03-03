-- Load data into lahman PostgreSQL tables from CSV files.
-- Run with psql from the project root so relative paths resolve:
--   psql -d lahman -f postgresql/load_lahman_from_csv_postgres.sql

SET search_path TO public;

BEGIN;

\copy allstarfull         FROM './data/AllstarFull.csv'         WITH (FORMAT csv, HEADER true, NULL '', ENCODING 'UTF8');
\copy appearances         FROM './data/Appearances.csv'         WITH (FORMAT csv, HEADER true, NULL '', ENCODING 'UTF8');
\copy awardsmanagers      FROM './data/AwardsManagers.csv'      WITH (FORMAT csv, HEADER true, NULL '', ENCODING 'UTF8');
\copy awardsplayers       FROM './data/AwardsPlayers.csv'       WITH (FORMAT csv, HEADER true, NULL '', ENCODING 'UTF8');
\copy awardssharemanagers FROM './data/AwardsShareManagers.csv' WITH (FORMAT csv, HEADER true, NULL '', ENCODING 'UTF8');
\copy awardsshareplayers  FROM './data/AwardsSharePlayers.csv'  WITH (FORMAT csv, HEADER true, NULL '', ENCODING 'UTF8');
\copy batting             FROM './data/Batting.csv'             WITH (FORMAT csv, HEADER true, NULL '', ENCODING 'UTF8');
\copy battingpost         FROM './data/BattingPost.csv'         WITH (FORMAT csv, HEADER true, NULL '', ENCODING 'UTF8');
\copy collegeplaying      FROM './data/CollegePlaying.csv'      WITH (FORMAT csv, HEADER true, NULL '', ENCODING 'UTF8');
\copy fielding            FROM './data/Fielding.csv'            WITH (FORMAT csv, HEADER true, NULL '', ENCODING 'UTF8');
\copy fieldingof          FROM './data/FieldingOF.csv'          WITH (FORMAT csv, HEADER true, NULL '', ENCODING 'UTF8');
\copy fieldingofsplit     FROM './data/FieldingOFsplit.csv'     WITH (FORMAT csv, HEADER true, NULL '', ENCODING 'UTF8');
\copy fieldingpost        FROM './data/FieldingPost.csv'        WITH (FORMAT csv, HEADER true, NULL '', ENCODING 'UTF8');
\copy halloffame          FROM './data/HallOfFame.csv'          WITH (FORMAT csv, HEADER true, NULL '', ENCODING 'UTF8');
\copy homegames           FROM './data/HomeGames.csv'           WITH (FORMAT csv, HEADER true, NULL '', ENCODING 'UTF8');
\copy managers            FROM './data/Managers.csv'            WITH (FORMAT csv, HEADER true, NULL '', ENCODING 'UTF8');
\copy managershalf        FROM './data/ManagersHalf.csv'        WITH (FORMAT csv, HEADER true, NULL '', ENCODING 'UTF8');
\copy parks               FROM './data/Parks.csv'               WITH (FORMAT csv, HEADER true, NULL '', ENCODING 'UTF8');
\copy people              FROM './data/People.csv'              WITH (FORMAT csv, HEADER true, NULL '', ENCODING 'UTF8');
\copy pitching            FROM './data/Pitching.csv'            WITH (FORMAT csv, HEADER true, NULL '', ENCODING 'UTF8');
\copy pitchingpost        FROM './data/PitchingPost.csv'        WITH (FORMAT csv, HEADER true, NULL '', ENCODING 'UTF8');
\copy salaries            FROM './data/Salaries.csv'            WITH (FORMAT csv, HEADER true, NULL '', ENCODING 'UTF8');
\copy schools             FROM './data/Schools.csv'             WITH (FORMAT csv, HEADER true, NULL '', ENCODING 'UTF8');
\copy seriespost          FROM './data/SeriesPost.csv'          WITH (FORMAT csv, HEADER true, NULL '', ENCODING 'UTF8');
\copy teams               FROM './data/Teams.csv'               WITH (FORMAT csv, HEADER true, NULL '', ENCODING 'UTF8');
\copy teamsfranchises     FROM './data/TeamsFranchises.csv'     WITH (FORMAT csv, HEADER true, NULL '', ENCODING 'UTF8');
\copy teamshalf           FROM './data/TeamsHalf.csv'           WITH (FORMAT csv, HEADER true, NULL '', ENCODING 'UTF8');

COMMIT;
