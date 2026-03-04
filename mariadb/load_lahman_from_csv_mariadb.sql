-- Load Lahman CSV data into MariaDB tables
-- Empty CSV fields are imported as NULL for nullable columns using NULLIF(REPLACE(@col, CHAR(13), ''), '').
-- Run from repository root (example):
--   mariadb --local-infile=1 -h <server-name> -P 3306 -u <username> -p lahman < load_lahman_from_csv_mariadb.sql

USE lahman;
SET FOREIGN_KEY_CHECKS=0;

LOAD DATA LOCAL INFILE './data/AllstarFull.csv'
INTO TABLE `AllstarFull`
CHARACTER SET utf8mb4
FIELDS TERMINATED BY ',' OPTIONALLY ENCLOSED BY '"' ESCAPED BY '"'
LINES TERMINATED BY '\n'
IGNORE 1 LINES
(@playerID, @yearID, @gameNum, @gameID, @teamID, @lgID, @GP, @startingPos)
SET
  `playerID` = NULLIF(REPLACE(@playerID, CHAR(13), ''), ''),
  `yearID` = NULLIF(REPLACE(@yearID, CHAR(13), ''), ''),
  `gameNum` = NULLIF(REPLACE(@gameNum, CHAR(13), ''), ''),
  `gameID` = NULLIF(REPLACE(@gameID, CHAR(13), ''), ''),
  `teamID` = NULLIF(REPLACE(@teamID, CHAR(13), ''), ''),
  `lgID` = NULLIF(REPLACE(@lgID, CHAR(13), ''), ''),
  `GP` = NULLIF(REPLACE(@GP, CHAR(13), ''), ''),
  `startingPos` = NULLIF(REPLACE(@startingPos, CHAR(13), ''), '');

LOAD DATA LOCAL INFILE './data/Appearances.csv'
INTO TABLE `Appearances`
CHARACTER SET utf8mb4
FIELDS TERMINATED BY ',' OPTIONALLY ENCLOSED BY '"' ESCAPED BY '"'
LINES TERMINATED BY '\n'
IGNORE 1 LINES
(@yearID, @teamID, @lgID, @playerID, @G_all, @GS, @G_batting, @G_defense, @G_p, @G_c, @G_1b, @G_2b, @G_3b, @G_ss, @G_lf, @G_cf, @G_rf, @G_of, @G_dh, @G_ph, @G_pr)
SET
  `yearID` = NULLIF(REPLACE(@yearID, CHAR(13), ''), ''),
  `teamID` = NULLIF(REPLACE(@teamID, CHAR(13), ''), ''),
  `lgID` = NULLIF(REPLACE(@lgID, CHAR(13), ''), ''),
  `playerID` = NULLIF(REPLACE(@playerID, CHAR(13), ''), ''),
  `G_all` = NULLIF(REPLACE(@G_all, CHAR(13), ''), ''),
  `GS` = NULLIF(REPLACE(@GS, CHAR(13), ''), ''),
  `G_batting` = NULLIF(REPLACE(@G_batting, CHAR(13), ''), ''),
  `G_defense` = NULLIF(REPLACE(@G_defense, CHAR(13), ''), ''),
  `G_p` = NULLIF(REPLACE(@G_p, CHAR(13), ''), ''),
  `G_c` = NULLIF(REPLACE(@G_c, CHAR(13), ''), ''),
  `G_1b` = NULLIF(REPLACE(@G_1b, CHAR(13), ''), ''),
  `G_2b` = NULLIF(REPLACE(@G_2b, CHAR(13), ''), ''),
  `G_3b` = NULLIF(REPLACE(@G_3b, CHAR(13), ''), ''),
  `G_ss` = NULLIF(REPLACE(@G_ss, CHAR(13), ''), ''),
  `G_lf` = NULLIF(REPLACE(@G_lf, CHAR(13), ''), ''),
  `G_cf` = NULLIF(REPLACE(@G_cf, CHAR(13), ''), ''),
  `G_rf` = NULLIF(REPLACE(@G_rf, CHAR(13), ''), ''),
  `G_of` = NULLIF(REPLACE(@G_of, CHAR(13), ''), ''),
  `G_dh` = NULLIF(REPLACE(@G_dh, CHAR(13), ''), ''),
  `G_ph` = NULLIF(REPLACE(@G_ph, CHAR(13), ''), ''),
  `G_pr` = NULLIF(REPLACE(@G_pr, CHAR(13), ''), '');

LOAD DATA LOCAL INFILE './data/AwardsManagers.csv'
INTO TABLE `AwardsManagers`
CHARACTER SET utf8mb4
FIELDS TERMINATED BY ',' OPTIONALLY ENCLOSED BY '"' ESCAPED BY '"'
LINES TERMINATED BY '\n'
IGNORE 1 LINES
(@playerID, @awardID, @yearID, @lgID, @tie, @notes)
SET
  `playerID` = NULLIF(REPLACE(@playerID, CHAR(13), ''), ''),
  `awardID` = NULLIF(REPLACE(@awardID, CHAR(13), ''), ''),
  `yearID` = NULLIF(REPLACE(@yearID, CHAR(13), ''), ''),
  `lgID` = NULLIF(REPLACE(@lgID, CHAR(13), ''), ''),
  `tie` = NULLIF(REPLACE(@tie, CHAR(13), ''), ''),
  `notes` = NULLIF(REPLACE(@notes, CHAR(13), ''), '');

LOAD DATA LOCAL INFILE './data/AwardsPlayers.csv'
INTO TABLE `AwardsPlayers`
CHARACTER SET utf8mb4
FIELDS TERMINATED BY ',' OPTIONALLY ENCLOSED BY '"' ESCAPED BY '"'
LINES TERMINATED BY '\n'
IGNORE 1 LINES
(@playerID, @awardID, @yearID, @lgID, @tie, @notes)
SET
  `playerID` = NULLIF(REPLACE(@playerID, CHAR(13), ''), ''),
  `awardID` = NULLIF(REPLACE(@awardID, CHAR(13), ''), ''),
  `yearID` = NULLIF(REPLACE(@yearID, CHAR(13), ''), ''),
  `lgID` = NULLIF(REPLACE(@lgID, CHAR(13), ''), ''),
  `tie` = NULLIF(REPLACE(@tie, CHAR(13), ''), ''),
  `notes` = NULLIF(REPLACE(@notes, CHAR(13), ''), '');

LOAD DATA LOCAL INFILE './data/AwardsShareManagers.csv'
INTO TABLE `AwardsShareManagers`
CHARACTER SET utf8mb4
FIELDS TERMINATED BY ',' OPTIONALLY ENCLOSED BY '"' ESCAPED BY '"'
LINES TERMINATED BY '\n'
IGNORE 1 LINES
(@awardID, @yearID, @lgID, @playerID, @pointsWon, @pointsMax, @votesFirst)
SET
  `awardID` = NULLIF(REPLACE(@awardID, CHAR(13), ''), ''),
  `yearID` = NULLIF(REPLACE(@yearID, CHAR(13), ''), ''),
  `lgID` = NULLIF(REPLACE(@lgID, CHAR(13), ''), ''),
  `playerID` = NULLIF(REPLACE(@playerID, CHAR(13), ''), ''),
  `pointsWon` = NULLIF(REPLACE(@pointsWon, CHAR(13), ''), ''),
  `pointsMax` = NULLIF(REPLACE(@pointsMax, CHAR(13), ''), ''),
  `votesFirst` = NULLIF(REPLACE(@votesFirst, CHAR(13), ''), '');

LOAD DATA LOCAL INFILE './data/AwardsSharePlayers.csv'
INTO TABLE `AwardsSharePlayers`
CHARACTER SET utf8mb4
FIELDS TERMINATED BY ',' OPTIONALLY ENCLOSED BY '"' ESCAPED BY '"'
LINES TERMINATED BY '\n'
IGNORE 1 LINES
(@awardID, @yearID, @lgID, @playerID, @pointsWon, @pointsMax, @votesFirst)
SET
  `awardID` = NULLIF(REPLACE(@awardID, CHAR(13), ''), ''),
  `yearID` = NULLIF(REPLACE(@yearID, CHAR(13), ''), ''),
  `lgID` = NULLIF(REPLACE(@lgID, CHAR(13), ''), ''),
  `playerID` = NULLIF(REPLACE(@playerID, CHAR(13), ''), ''),
  `pointsWon` = NULLIF(REPLACE(@pointsWon, CHAR(13), ''), ''),
  `pointsMax` = NULLIF(REPLACE(@pointsMax, CHAR(13), ''), ''),
  `votesFirst` = NULLIF(REPLACE(@votesFirst, CHAR(13), ''), '');

LOAD DATA LOCAL INFILE './data/Batting.csv'
INTO TABLE `Batting`
CHARACTER SET utf8mb4
FIELDS TERMINATED BY ',' OPTIONALLY ENCLOSED BY '"' ESCAPED BY '"'
LINES TERMINATED BY '\n'
IGNORE 1 LINES
(@playerID, @yearID, @stint, @teamID, @lgID, @G, @AB, @R, @H, @2B, @3B, @HR, @RBI, @SB, @CS, @BB, @SO, @IBB, @HBP, @SH, @SF, @GIDP)
SET
  `playerID` = NULLIF(REPLACE(@playerID, CHAR(13), ''), ''),
  `yearID` = NULLIF(REPLACE(@yearID, CHAR(13), ''), ''),
  `stint` = NULLIF(REPLACE(@stint, CHAR(13), ''), ''),
  `teamID` = NULLIF(REPLACE(@teamID, CHAR(13), ''), ''),
  `lgID` = NULLIF(REPLACE(@lgID, CHAR(13), ''), ''),
  `G` = NULLIF(REPLACE(@G, CHAR(13), ''), ''),
  `AB` = NULLIF(REPLACE(@AB, CHAR(13), ''), ''),
  `R` = NULLIF(REPLACE(@R, CHAR(13), ''), ''),
  `H` = NULLIF(REPLACE(@H, CHAR(13), ''), ''),
  `2B` = NULLIF(REPLACE(@2B, CHAR(13), ''), ''),
  `3B` = NULLIF(REPLACE(@3B, CHAR(13), ''), ''),
  `HR` = NULLIF(REPLACE(@HR, CHAR(13), ''), ''),
  `RBI` = NULLIF(REPLACE(@RBI, CHAR(13), ''), ''),
  `SB` = NULLIF(REPLACE(@SB, CHAR(13), ''), ''),
  `CS` = NULLIF(REPLACE(@CS, CHAR(13), ''), ''),
  `BB` = NULLIF(REPLACE(@BB, CHAR(13), ''), ''),
  `SO` = NULLIF(REPLACE(@SO, CHAR(13), ''), ''),
  `IBB` = NULLIF(REPLACE(@IBB, CHAR(13), ''), ''),
  `HBP` = NULLIF(REPLACE(@HBP, CHAR(13), ''), ''),
  `SH` = NULLIF(REPLACE(@SH, CHAR(13), ''), ''),
  `SF` = NULLIF(REPLACE(@SF, CHAR(13), ''), ''),
  `GIDP` = NULLIF(REPLACE(@GIDP, CHAR(13), ''), '');

LOAD DATA LOCAL INFILE './data/BattingPost.csv'
INTO TABLE `BattingPost`
CHARACTER SET utf8mb4
FIELDS TERMINATED BY ',' OPTIONALLY ENCLOSED BY '"' ESCAPED BY '"'
LINES TERMINATED BY '\n'
IGNORE 1 LINES
(@yearID, @round, @playerID, @teamID, @lgID, @G, @AB, @R, @H, @2B, @3B, @HR, @RBI, @SB, @CS, @BB, @SO, @IBB, @HBP, @SH, @SF, @GIDP)
SET
  `yearID` = NULLIF(REPLACE(@yearID, CHAR(13), ''), ''),
  `round` = NULLIF(REPLACE(@round, CHAR(13), ''), ''),
  `playerID` = NULLIF(REPLACE(@playerID, CHAR(13), ''), ''),
  `teamID` = NULLIF(REPLACE(@teamID, CHAR(13), ''), ''),
  `lgID` = NULLIF(REPLACE(@lgID, CHAR(13), ''), ''),
  `G` = NULLIF(REPLACE(@G, CHAR(13), ''), ''),
  `AB` = NULLIF(REPLACE(@AB, CHAR(13), ''), ''),
  `R` = NULLIF(REPLACE(@R, CHAR(13), ''), ''),
  `H` = NULLIF(REPLACE(@H, CHAR(13), ''), ''),
  `2B` = NULLIF(REPLACE(@2B, CHAR(13), ''), ''),
  `3B` = NULLIF(REPLACE(@3B, CHAR(13), ''), ''),
  `HR` = NULLIF(REPLACE(@HR, CHAR(13), ''), ''),
  `RBI` = NULLIF(REPLACE(@RBI, CHAR(13), ''), ''),
  `SB` = NULLIF(REPLACE(@SB, CHAR(13), ''), ''),
  `CS` = NULLIF(REPLACE(@CS, CHAR(13), ''), ''),
  `BB` = NULLIF(REPLACE(@BB, CHAR(13), ''), ''),
  `SO` = NULLIF(REPLACE(@SO, CHAR(13), ''), ''),
  `IBB` = NULLIF(REPLACE(@IBB, CHAR(13), ''), ''),
  `HBP` = NULLIF(REPLACE(@HBP, CHAR(13), ''), ''),
  `SH` = NULLIF(REPLACE(@SH, CHAR(13), ''), ''),
  `SF` = NULLIF(REPLACE(@SF, CHAR(13), ''), ''),
  `GIDP` = NULLIF(REPLACE(@GIDP, CHAR(13), ''), '');

LOAD DATA LOCAL INFILE './data/CollegePlaying.csv'
INTO TABLE `CollegePlaying`
CHARACTER SET utf8mb4
FIELDS TERMINATED BY ',' OPTIONALLY ENCLOSED BY '"' ESCAPED BY '"'
LINES TERMINATED BY '\n'
IGNORE 1 LINES
(@playerID, @schoolID, @yearID)
SET
  `playerID` = NULLIF(REPLACE(@playerID, CHAR(13), ''), ''),
  `schoolID` = NULLIF(REPLACE(@schoolID, CHAR(13), ''), ''),
  `yearID` = NULLIF(REPLACE(@yearID, CHAR(13), ''), '');

LOAD DATA LOCAL INFILE './data/Fielding.csv'
INTO TABLE `Fielding`
CHARACTER SET utf8mb4
FIELDS TERMINATED BY ',' OPTIONALLY ENCLOSED BY '"' ESCAPED BY '"'
LINES TERMINATED BY '\n'
IGNORE 1 LINES
(@playerID, @yearID, @stint, @teamID, @lgID, @POS, @G, @GS, @InnOuts, @PO, @A, @E, @DP, @PB, @WP, @SB, @CS, @ZR)
SET
  `playerID` = NULLIF(REPLACE(@playerID, CHAR(13), ''), ''),
  `yearID` = NULLIF(REPLACE(@yearID, CHAR(13), ''), ''),
  `stint` = NULLIF(REPLACE(@stint, CHAR(13), ''), ''),
  `teamID` = NULLIF(REPLACE(@teamID, CHAR(13), ''), ''),
  `lgID` = NULLIF(REPLACE(@lgID, CHAR(13), ''), ''),
  `POS` = NULLIF(REPLACE(@POS, CHAR(13), ''), ''),
  `G` = NULLIF(REPLACE(@G, CHAR(13), ''), ''),
  `GS` = NULLIF(REPLACE(@GS, CHAR(13), ''), ''),
  `InnOuts` = NULLIF(REPLACE(@InnOuts, CHAR(13), ''), ''),
  `PO` = NULLIF(REPLACE(@PO, CHAR(13), ''), ''),
  `A` = NULLIF(REPLACE(@A, CHAR(13), ''), ''),
  `E` = NULLIF(REPLACE(@E, CHAR(13), ''), ''),
  `DP` = NULLIF(REPLACE(@DP, CHAR(13), ''), ''),
  `PB` = NULLIF(REPLACE(@PB, CHAR(13), ''), ''),
  `WP` = NULLIF(REPLACE(@WP, CHAR(13), ''), ''),
  `SB` = NULLIF(REPLACE(@SB, CHAR(13), ''), ''),
  `CS` = NULLIF(REPLACE(@CS, CHAR(13), ''), ''),
  `ZR` = NULLIF(REPLACE(@ZR, CHAR(13), ''), '');

LOAD DATA LOCAL INFILE './data/FieldingOF.csv'
INTO TABLE `FieldingOF`
CHARACTER SET utf8mb4
FIELDS TERMINATED BY ',' OPTIONALLY ENCLOSED BY '"' ESCAPED BY '"'
LINES TERMINATED BY '\n'
IGNORE 1 LINES
(@playerID, @yearID, @stint, @Glf, @Gcf, @Grf)
SET
  `playerID` = NULLIF(REPLACE(@playerID, CHAR(13), ''), ''),
  `yearID` = NULLIF(REPLACE(@yearID, CHAR(13), ''), ''),
  `stint` = NULLIF(REPLACE(@stint, CHAR(13), ''), ''),
  `Glf` = NULLIF(REPLACE(@Glf, CHAR(13), ''), ''),
  `Gcf` = NULLIF(REPLACE(@Gcf, CHAR(13), ''), ''),
  `Grf` = NULLIF(REPLACE(@Grf, CHAR(13), ''), '');

LOAD DATA LOCAL INFILE './data/FieldingOFsplit.csv'
INTO TABLE `FieldingOFsplit`
CHARACTER SET utf8mb4
FIELDS TERMINATED BY ',' OPTIONALLY ENCLOSED BY '"' ESCAPED BY '"'
LINES TERMINATED BY '\n'
IGNORE 1 LINES
(@playerID, @yearID, @stint, @teamID, @lgID, @POS, @G, @GS, @InnOuts, @PO, @A, @E, @DP, @PB, @WP, @SB, @CS, @ZR)
SET
  `playerID` = NULLIF(REPLACE(@playerID, CHAR(13), ''), ''),
  `yearID` = NULLIF(REPLACE(@yearID, CHAR(13), ''), ''),
  `stint` = NULLIF(REPLACE(@stint, CHAR(13), ''), ''),
  `teamID` = NULLIF(REPLACE(@teamID, CHAR(13), ''), ''),
  `lgID` = NULLIF(REPLACE(@lgID, CHAR(13), ''), ''),
  `POS` = NULLIF(REPLACE(@POS, CHAR(13), ''), ''),
  `G` = NULLIF(REPLACE(@G, CHAR(13), ''), ''),
  `GS` = NULLIF(REPLACE(@GS, CHAR(13), ''), ''),
  `InnOuts` = NULLIF(REPLACE(@InnOuts, CHAR(13), ''), ''),
  `PO` = NULLIF(REPLACE(@PO, CHAR(13), ''), ''),
  `A` = NULLIF(REPLACE(@A, CHAR(13), ''), ''),
  `E` = NULLIF(REPLACE(@E, CHAR(13), ''), ''),
  `DP` = NULLIF(REPLACE(@DP, CHAR(13), ''), ''),
  `PB` = NULLIF(REPLACE(@PB, CHAR(13), ''), ''),
  `WP` = NULLIF(REPLACE(@WP, CHAR(13), ''), ''),
  `SB` = NULLIF(REPLACE(@SB, CHAR(13), ''), ''),
  `CS` = NULLIF(REPLACE(@CS, CHAR(13), ''), ''),
  `ZR` = NULLIF(REPLACE(@ZR, CHAR(13), ''), '');

LOAD DATA LOCAL INFILE './data/FieldingPost.csv'
INTO TABLE `FieldingPost`
CHARACTER SET utf8mb4
FIELDS TERMINATED BY ',' OPTIONALLY ENCLOSED BY '"' ESCAPED BY '"'
LINES TERMINATED BY '\n'
IGNORE 1 LINES
(@playerID, @yearID, @teamID, @lgID, @round, @POS, @G, @GS, @InnOuts, @PO, @A, @E, @DP, @TP, @PB, @SB, @CS)
SET
  `playerID` = NULLIF(REPLACE(@playerID, CHAR(13), ''), ''),
  `yearID` = NULLIF(REPLACE(@yearID, CHAR(13), ''), ''),
  `teamID` = NULLIF(REPLACE(@teamID, CHAR(13), ''), ''),
  `lgID` = NULLIF(REPLACE(@lgID, CHAR(13), ''), ''),
  `round` = NULLIF(REPLACE(@round, CHAR(13), ''), ''),
  `POS` = NULLIF(REPLACE(@POS, CHAR(13), ''), ''),
  `G` = NULLIF(REPLACE(@G, CHAR(13), ''), ''),
  `GS` = NULLIF(REPLACE(@GS, CHAR(13), ''), ''),
  `InnOuts` = NULLIF(REPLACE(@InnOuts, CHAR(13), ''), ''),
  `PO` = NULLIF(REPLACE(@PO, CHAR(13), ''), ''),
  `A` = NULLIF(REPLACE(@A, CHAR(13), ''), ''),
  `E` = NULLIF(REPLACE(@E, CHAR(13), ''), ''),
  `DP` = NULLIF(REPLACE(@DP, CHAR(13), ''), ''),
  `TP` = NULLIF(REPLACE(@TP, CHAR(13), ''), ''),
  `PB` = NULLIF(REPLACE(@PB, CHAR(13), ''), ''),
  `SB` = NULLIF(REPLACE(@SB, CHAR(13), ''), ''),
  `CS` = NULLIF(REPLACE(@CS, CHAR(13), ''), '');

LOAD DATA LOCAL INFILE './data/HallOfFame.csv'
INTO TABLE `HallOfFame`
CHARACTER SET utf8mb4
FIELDS TERMINATED BY ',' OPTIONALLY ENCLOSED BY '"' ESCAPED BY '"'
LINES TERMINATED BY '\n'
IGNORE 1 LINES
(@playerID, @yearid, @votedBy, @ballots, @needed, @votes, @inducted, @category, @needed_note)
SET
  `playerID` = NULLIF(REPLACE(@playerID, CHAR(13), ''), ''),
  `yearid` = NULLIF(REPLACE(@yearid, CHAR(13), ''), ''),
  `votedBy` = NULLIF(REPLACE(@votedBy, CHAR(13), ''), ''),
  `ballots` = NULLIF(REPLACE(@ballots, CHAR(13), ''), ''),
  `needed` = NULLIF(REPLACE(@needed, CHAR(13), ''), ''),
  `votes` = NULLIF(REPLACE(@votes, CHAR(13), ''), ''),
  `inducted` = NULLIF(REPLACE(@inducted, CHAR(13), ''), ''),
  `category` = NULLIF(REPLACE(@category, CHAR(13), ''), ''),
  `needed_note` = NULLIF(REPLACE(@needed_note, CHAR(13), ''), '');

LOAD DATA LOCAL INFILE './data/HomeGames.csv'
INTO TABLE `HomeGames`
CHARACTER SET utf8mb4
FIELDS TERMINATED BY ',' OPTIONALLY ENCLOSED BY '"' ESCAPED BY '"'
LINES TERMINATED BY '\n'
IGNORE 1 LINES
(@yearkey, @leaguekey, @teamkey, @parkkey, @spanfirst, @spanlast, @games, @openings, @attendance)
SET
  `yearkey` = NULLIF(REPLACE(@yearkey, CHAR(13), ''), ''),
  `leaguekey` = NULLIF(REPLACE(@leaguekey, CHAR(13), ''), ''),
  `teamkey` = NULLIF(REPLACE(@teamkey, CHAR(13), ''), ''),
  `parkkey` = NULLIF(REPLACE(@parkkey, CHAR(13), ''), ''),
  `spanfirst` = NULLIF(REPLACE(@spanfirst, CHAR(13), ''), ''),
  `spanlast` = NULLIF(REPLACE(@spanlast, CHAR(13), ''), ''),
  `games` = NULLIF(REPLACE(@games, CHAR(13), ''), ''),
  `openings` = NULLIF(REPLACE(@openings, CHAR(13), ''), ''),
  `attendance` = NULLIF(REPLACE(@attendance, CHAR(13), ''), '');

LOAD DATA LOCAL INFILE './data/Managers.csv'
INTO TABLE `Managers`
CHARACTER SET utf8mb4
FIELDS TERMINATED BY ',' OPTIONALLY ENCLOSED BY '"' ESCAPED BY '"'
LINES TERMINATED BY '\n'
IGNORE 1 LINES
(@playerID, @yearID, @teamID, @lgID, @inseason, @G, @W, @L, @rank, @plyrMgr)
SET
  `playerID` = NULLIF(REPLACE(@playerID, CHAR(13), ''), ''),
  `yearID` = NULLIF(REPLACE(@yearID, CHAR(13), ''), ''),
  `teamID` = NULLIF(REPLACE(@teamID, CHAR(13), ''), ''),
  `lgID` = NULLIF(REPLACE(@lgID, CHAR(13), ''), ''),
  `inseason` = NULLIF(REPLACE(@inseason, CHAR(13), ''), ''),
  `G` = NULLIF(REPLACE(@G, CHAR(13), ''), ''),
  `W` = NULLIF(REPLACE(@W, CHAR(13), ''), ''),
  `L` = NULLIF(REPLACE(@L, CHAR(13), ''), ''),
  `rank` = NULLIF(REPLACE(@rank, CHAR(13), ''), ''),
  `plyrMgr` = NULLIF(REPLACE(@plyrMgr, CHAR(13), ''), '');

LOAD DATA LOCAL INFILE './data/ManagersHalf.csv'
INTO TABLE `ManagersHalf`
CHARACTER SET utf8mb4
FIELDS TERMINATED BY ',' OPTIONALLY ENCLOSED BY '"' ESCAPED BY '"'
LINES TERMINATED BY '\n'
IGNORE 1 LINES
(@playerID, @yearID, @teamID, @lgID, @inseason, @half, @G, @W, @L, @rank)
SET
  `playerID` = NULLIF(REPLACE(@playerID, CHAR(13), ''), ''),
  `yearID` = NULLIF(REPLACE(@yearID, CHAR(13), ''), ''),
  `teamID` = NULLIF(REPLACE(@teamID, CHAR(13), ''), ''),
  `lgID` = NULLIF(REPLACE(@lgID, CHAR(13), ''), ''),
  `inseason` = NULLIF(REPLACE(@inseason, CHAR(13), ''), ''),
  `half` = NULLIF(REPLACE(@half, CHAR(13), ''), ''),
  `G` = NULLIF(REPLACE(@G, CHAR(13), ''), ''),
  `W` = NULLIF(REPLACE(@W, CHAR(13), ''), ''),
  `L` = NULLIF(REPLACE(@L, CHAR(13), ''), ''),
  `rank` = NULLIF(REPLACE(@rank, CHAR(13), ''), '');

LOAD DATA LOCAL INFILE './data/Parks.csv'
INTO TABLE `Parks`
CHARACTER SET utf8mb4
FIELDS TERMINATED BY ',' OPTIONALLY ENCLOSED BY '"' ESCAPED BY '"'
LINES TERMINATED BY '\n'
IGNORE 1 LINES
(@ID, @parkalias, @parkkey, @parkname, @city, @state, @country)
SET
  `ID` = NULLIF(REPLACE(@ID, CHAR(13), ''), ''),
  `parkalias` = NULLIF(REPLACE(@parkalias, CHAR(13), ''), ''),
  `parkkey` = NULLIF(REPLACE(@parkkey, CHAR(13), ''), ''),
  `parkname` = NULLIF(REPLACE(@parkname, CHAR(13), ''), ''),
  `city` = NULLIF(REPLACE(@city, CHAR(13), ''), ''),
  `state` = NULLIF(REPLACE(@state, CHAR(13), ''), ''),
  `country` = NULLIF(REPLACE(@country, CHAR(13), ''), '');

LOAD DATA LOCAL INFILE './data/People.csv'
INTO TABLE `People`
CHARACTER SET utf8mb4
FIELDS TERMINATED BY ',' OPTIONALLY ENCLOSED BY '"' ESCAPED BY '"'
LINES TERMINATED BY '\n'
IGNORE 1 LINES
(@ID, @playerID, @birthYear, @birthMonth, @birthDay, @birthCity, @birthCountry, @birthState, @deathYear, @deathMonth, @deathDay, @deathCountry, @deathState, @deathCity, @nameFirst, @nameLast, @nameGiven, @weight, @height, @bats, @throws, @debut, @bbrefID, @finalGame, @retroID)
SET
  `ID` = NULLIF(REPLACE(@ID, CHAR(13), ''), ''),
  `playerID` = NULLIF(REPLACE(@playerID, CHAR(13), ''), ''),
  `birthYear` = NULLIF(REPLACE(@birthYear, CHAR(13), ''), ''),
  `birthMonth` = NULLIF(REPLACE(@birthMonth, CHAR(13), ''), ''),
  `birthDay` = NULLIF(REPLACE(@birthDay, CHAR(13), ''), ''),
  `birthCity` = NULLIF(REPLACE(@birthCity, CHAR(13), ''), ''),
  `birthCountry` = NULLIF(REPLACE(@birthCountry, CHAR(13), ''), ''),
  `birthState` = NULLIF(REPLACE(@birthState, CHAR(13), ''), ''),
  `deathYear` = NULLIF(REPLACE(@deathYear, CHAR(13), ''), ''),
  `deathMonth` = NULLIF(REPLACE(@deathMonth, CHAR(13), ''), ''),
  `deathDay` = NULLIF(REPLACE(@deathDay, CHAR(13), ''), ''),
  `deathCountry` = NULLIF(REPLACE(@deathCountry, CHAR(13), ''), ''),
  `deathState` = NULLIF(REPLACE(@deathState, CHAR(13), ''), ''),
  `deathCity` = NULLIF(REPLACE(@deathCity, CHAR(13), ''), ''),
  `nameFirst` = NULLIF(REPLACE(@nameFirst, CHAR(13), ''), ''),
  `nameLast` = NULLIF(REPLACE(@nameLast, CHAR(13), ''), ''),
  `nameGiven` = NULLIF(REPLACE(@nameGiven, CHAR(13), ''), ''),
  `weight` = NULLIF(REPLACE(@weight, CHAR(13), ''), ''),
  `height` = NULLIF(REPLACE(@height, CHAR(13), ''), ''),
  `bats` = NULLIF(REPLACE(@bats, CHAR(13), ''), ''),
  `throws` = NULLIF(REPLACE(@throws, CHAR(13), ''), ''),
  `debut` = NULLIF(REPLACE(@debut, CHAR(13), ''), ''),
  `bbrefID` = NULLIF(REPLACE(@bbrefID, CHAR(13), ''), ''),
  `finalGame` = NULLIF(REPLACE(@finalGame, CHAR(13), ''), ''),
  `retroID` = NULLIF(REPLACE(@retroID, CHAR(13), ''), '');

LOAD DATA LOCAL INFILE './data/Pitching.csv'
INTO TABLE `Pitching`
CHARACTER SET utf8mb4
FIELDS TERMINATED BY ',' OPTIONALLY ENCLOSED BY '"' ESCAPED BY '"'
LINES TERMINATED BY '\n'
IGNORE 1 LINES
(@playerID, @yearID, @stint, @teamID, @lgID, @W, @L, @G, @GS, @CG, @SHO, @SV, @IPouts, @H, @ER, @HR, @BB, @SO, @BAOpp, @ERA, @IBB, @WP, @HBP, @BK, @BFP, @GF, @R, @SH, @SF, @GIDP)
SET
  `playerID` = NULLIF(REPLACE(@playerID, CHAR(13), ''), ''),
  `yearID` = NULLIF(REPLACE(@yearID, CHAR(13), ''), ''),
  `stint` = NULLIF(REPLACE(@stint, CHAR(13), ''), ''),
  `teamID` = NULLIF(REPLACE(@teamID, CHAR(13), ''), ''),
  `lgID` = NULLIF(REPLACE(@lgID, CHAR(13), ''), ''),
  `W` = NULLIF(REPLACE(@W, CHAR(13), ''), ''),
  `L` = NULLIF(REPLACE(@L, CHAR(13), ''), ''),
  `G` = NULLIF(REPLACE(@G, CHAR(13), ''), ''),
  `GS` = NULLIF(REPLACE(@GS, CHAR(13), ''), ''),
  `CG` = NULLIF(REPLACE(@CG, CHAR(13), ''), ''),
  `SHO` = NULLIF(REPLACE(@SHO, CHAR(13), ''), ''),
  `SV` = NULLIF(REPLACE(@SV, CHAR(13), ''), ''),
  `IPouts` = NULLIF(REPLACE(@IPouts, CHAR(13), ''), ''),
  `H` = NULLIF(REPLACE(@H, CHAR(13), ''), ''),
  `ER` = NULLIF(REPLACE(@ER, CHAR(13), ''), ''),
  `HR` = NULLIF(REPLACE(@HR, CHAR(13), ''), ''),
  `BB` = NULLIF(REPLACE(@BB, CHAR(13), ''), ''),
  `SO` = NULLIF(REPLACE(@SO, CHAR(13), ''), ''),
  `BAOpp` = NULLIF(REPLACE(@BAOpp, CHAR(13), ''), ''),
  `ERA` = NULLIF(REPLACE(@ERA, CHAR(13), ''), ''),
  `IBB` = NULLIF(REPLACE(@IBB, CHAR(13), ''), ''),
  `WP` = NULLIF(REPLACE(@WP, CHAR(13), ''), ''),
  `HBP` = NULLIF(REPLACE(@HBP, CHAR(13), ''), ''),
  `BK` = NULLIF(REPLACE(@BK, CHAR(13), ''), ''),
  `BFP` = NULLIF(REPLACE(@BFP, CHAR(13), ''), ''),
  `GF` = NULLIF(REPLACE(@GF, CHAR(13), ''), ''),
  `R` = NULLIF(REPLACE(@R, CHAR(13), ''), ''),
  `SH` = NULLIF(REPLACE(@SH, CHAR(13), ''), ''),
  `SF` = NULLIF(REPLACE(@SF, CHAR(13), ''), ''),
  `GIDP` = NULLIF(REPLACE(@GIDP, CHAR(13), ''), '');

LOAD DATA LOCAL INFILE './data/PitchingPost.csv'
INTO TABLE `PitchingPost`
CHARACTER SET utf8mb4
FIELDS TERMINATED BY ',' OPTIONALLY ENCLOSED BY '"' ESCAPED BY '"'
LINES TERMINATED BY '\n'
IGNORE 1 LINES
(@playerID, @yearID, @round, @teamID, @lgID, @W, @L, @G, @GS, @CG, @SHO, @SV, @IPouts, @H, @ER, @HR, @BB, @SO, @BAOpp, @ERA, @IBB, @WP, @HBP, @BK, @BFP, @GF, @R, @SH, @SF, @GIDP)
SET
  `playerID` = NULLIF(REPLACE(@playerID, CHAR(13), ''), ''),
  `yearID` = NULLIF(REPLACE(@yearID, CHAR(13), ''), ''),
  `round` = NULLIF(REPLACE(@round, CHAR(13), ''), ''),
  `teamID` = NULLIF(REPLACE(@teamID, CHAR(13), ''), ''),
  `lgID` = NULLIF(REPLACE(@lgID, CHAR(13), ''), ''),
  `W` = NULLIF(REPLACE(@W, CHAR(13), ''), ''),
  `L` = NULLIF(REPLACE(@L, CHAR(13), ''), ''),
  `G` = NULLIF(REPLACE(@G, CHAR(13), ''), ''),
  `GS` = NULLIF(REPLACE(@GS, CHAR(13), ''), ''),
  `CG` = NULLIF(REPLACE(@CG, CHAR(13), ''), ''),
  `SHO` = NULLIF(REPLACE(@SHO, CHAR(13), ''), ''),
  `SV` = NULLIF(REPLACE(@SV, CHAR(13), ''), ''),
  `IPouts` = NULLIF(REPLACE(@IPouts, CHAR(13), ''), ''),
  `H` = NULLIF(REPLACE(@H, CHAR(13), ''), ''),
  `ER` = NULLIF(REPLACE(@ER, CHAR(13), ''), ''),
  `HR` = NULLIF(REPLACE(@HR, CHAR(13), ''), ''),
  `BB` = NULLIF(REPLACE(@BB, CHAR(13), ''), ''),
  `SO` = NULLIF(REPLACE(@SO, CHAR(13), ''), ''),
  `BAOpp` = NULLIF(REPLACE(@BAOpp, CHAR(13), ''), ''),
  `ERA` = NULLIF(REPLACE(@ERA, CHAR(13), ''), ''),
  `IBB` = NULLIF(REPLACE(@IBB, CHAR(13), ''), ''),
  `WP` = NULLIF(REPLACE(@WP, CHAR(13), ''), ''),
  `HBP` = NULLIF(REPLACE(@HBP, CHAR(13), ''), ''),
  `BK` = NULLIF(REPLACE(@BK, CHAR(13), ''), ''),
  `BFP` = NULLIF(REPLACE(@BFP, CHAR(13), ''), ''),
  `GF` = NULLIF(REPLACE(@GF, CHAR(13), ''), ''),
  `R` = NULLIF(REPLACE(@R, CHAR(13), ''), ''),
  `SH` = NULLIF(REPLACE(@SH, CHAR(13), ''), ''),
  `SF` = NULLIF(REPLACE(@SF, CHAR(13), ''), ''),
  `GIDP` = NULLIF(REPLACE(@GIDP, CHAR(13), ''), '');

LOAD DATA LOCAL INFILE './data/Salaries.csv'
INTO TABLE `Salaries`
CHARACTER SET utf8mb4
FIELDS TERMINATED BY ',' OPTIONALLY ENCLOSED BY '"' ESCAPED BY '"'
LINES TERMINATED BY '\n'
IGNORE 1 LINES
(@yearID, @teamID, @lgID, @playerID, @salary)
SET
  `yearID` = NULLIF(REPLACE(@yearID, CHAR(13), ''), ''),
  `teamID` = NULLIF(REPLACE(@teamID, CHAR(13), ''), ''),
  `lgID` = NULLIF(REPLACE(@lgID, CHAR(13), ''), ''),
  `playerID` = NULLIF(REPLACE(@playerID, CHAR(13), ''), ''),
  `salary` = NULLIF(REPLACE(@salary, CHAR(13), ''), '');

LOAD DATA LOCAL INFILE './data/Schools.csv'
INTO TABLE `Schools`
CHARACTER SET utf8mb4
FIELDS TERMINATED BY ',' OPTIONALLY ENCLOSED BY '"' ESCAPED BY '"'
LINES TERMINATED BY '\n'
IGNORE 1 LINES
(@schoolID, @name_full, @city, @state, @country)
SET
  `schoolID` = NULLIF(REPLACE(@schoolID, CHAR(13), ''), ''),
  `name_full` = NULLIF(REPLACE(@name_full, CHAR(13), ''), ''),
  `city` = NULLIF(REPLACE(@city, CHAR(13), ''), ''),
  `state` = NULLIF(REPLACE(@state, CHAR(13), ''), ''),
  `country` = NULLIF(REPLACE(@country, CHAR(13), ''), '');

LOAD DATA LOCAL INFILE './data/SeriesPost.csv'
INTO TABLE `SeriesPost`
CHARACTER SET utf8mb4
FIELDS TERMINATED BY ',' OPTIONALLY ENCLOSED BY '"' ESCAPED BY '"'
LINES TERMINATED BY '\n'
IGNORE 1 LINES
(@yearID, @round, @teamIDwinner, @lgIDwinner, @teamIDloser, @lgIDloser, @wins, @losses, @ties)
SET
  `yearID` = NULLIF(REPLACE(@yearID, CHAR(13), ''), ''),
  `round` = NULLIF(REPLACE(@round, CHAR(13), ''), ''),
  `teamIDwinner` = NULLIF(REPLACE(@teamIDwinner, CHAR(13), ''), ''),
  `lgIDwinner` = NULLIF(REPLACE(@lgIDwinner, CHAR(13), ''), ''),
  `teamIDloser` = NULLIF(REPLACE(@teamIDloser, CHAR(13), ''), ''),
  `lgIDloser` = NULLIF(REPLACE(@lgIDloser, CHAR(13), ''), ''),
  `wins` = NULLIF(REPLACE(@wins, CHAR(13), ''), ''),
  `losses` = NULLIF(REPLACE(@losses, CHAR(13), ''), ''),
  `ties` = NULLIF(REPLACE(@ties, CHAR(13), ''), '');

LOAD DATA LOCAL INFILE './data/Teams.csv'
INTO TABLE `Teams`
CHARACTER SET utf8mb4
FIELDS TERMINATED BY ',' OPTIONALLY ENCLOSED BY '"' ESCAPED BY '"'
LINES TERMINATED BY '\n'
IGNORE 1 LINES
(@yearID, @lgID, @teamID, @franchID, @divID, @Rank, @G, @Ghome, @W, @L, @DivWin, @WCWin, @LgWin, @WSWin, @R, @AB, @H, @2B, @3B, @HR, @BB, @SO, @SB, @CS, @HBP, @SF, @RA, @ER, @ERA, @CG, @SHO, @SV, @IPouts, @HA, @HRA, @BBA, @SOA, @E, @DP, @FP, @name, @park, @attendance, @BPF, @PPF, @teamIDBR, @teamIDlahman45, @teamIDretro)
SET
  `yearID` = NULLIF(REPLACE(@yearID, CHAR(13), ''), ''),
  `lgID` = NULLIF(REPLACE(@lgID, CHAR(13), ''), ''),
  `teamID` = NULLIF(REPLACE(@teamID, CHAR(13), ''), ''),
  `franchID` = NULLIF(REPLACE(@franchID, CHAR(13), ''), ''),
  `divID` = NULLIF(REPLACE(@divID, CHAR(13), ''), ''),
  `Rank` = NULLIF(REPLACE(@Rank, CHAR(13), ''), ''),
  `G` = NULLIF(REPLACE(@G, CHAR(13), ''), ''),
  `Ghome` = NULLIF(REPLACE(@Ghome, CHAR(13), ''), ''),
  `W` = NULLIF(REPLACE(@W, CHAR(13), ''), ''),
  `L` = NULLIF(REPLACE(@L, CHAR(13), ''), ''),
  `DivWin` = NULLIF(REPLACE(@DivWin, CHAR(13), ''), ''),
  `WCWin` = NULLIF(REPLACE(@WCWin, CHAR(13), ''), ''),
  `LgWin` = NULLIF(REPLACE(@LgWin, CHAR(13), ''), ''),
  `WSWin` = NULLIF(REPLACE(@WSWin, CHAR(13), ''), ''),
  `R` = NULLIF(REPLACE(@R, CHAR(13), ''), ''),
  `AB` = NULLIF(REPLACE(@AB, CHAR(13), ''), ''),
  `H` = NULLIF(REPLACE(@H, CHAR(13), ''), ''),
  `2B` = NULLIF(REPLACE(@2B, CHAR(13), ''), ''),
  `3B` = NULLIF(REPLACE(@3B, CHAR(13), ''), ''),
  `HR` = NULLIF(REPLACE(@HR, CHAR(13), ''), ''),
  `BB` = NULLIF(REPLACE(@BB, CHAR(13), ''), ''),
  `SO` = NULLIF(REPLACE(@SO, CHAR(13), ''), ''),
  `SB` = NULLIF(REPLACE(@SB, CHAR(13), ''), ''),
  `CS` = NULLIF(REPLACE(@CS, CHAR(13), ''), ''),
  `HBP` = NULLIF(REPLACE(@HBP, CHAR(13), ''), ''),
  `SF` = NULLIF(REPLACE(@SF, CHAR(13), ''), ''),
  `RA` = NULLIF(REPLACE(@RA, CHAR(13), ''), ''),
  `ER` = NULLIF(REPLACE(@ER, CHAR(13), ''), ''),
  `ERA` = NULLIF(REPLACE(@ERA, CHAR(13), ''), ''),
  `CG` = NULLIF(REPLACE(@CG, CHAR(13), ''), ''),
  `SHO` = NULLIF(REPLACE(@SHO, CHAR(13), ''), ''),
  `SV` = NULLIF(REPLACE(@SV, CHAR(13), ''), ''),
  `IPouts` = NULLIF(REPLACE(@IPouts, CHAR(13), ''), ''),
  `HA` = NULLIF(REPLACE(@HA, CHAR(13), ''), ''),
  `HRA` = NULLIF(REPLACE(@HRA, CHAR(13), ''), ''),
  `BBA` = NULLIF(REPLACE(@BBA, CHAR(13), ''), ''),
  `SOA` = NULLIF(REPLACE(@SOA, CHAR(13), ''), ''),
  `E` = NULLIF(REPLACE(@E, CHAR(13), ''), ''),
  `DP` = NULLIF(REPLACE(@DP, CHAR(13), ''), ''),
  `FP` = NULLIF(REPLACE(@FP, CHAR(13), ''), ''),
  `name` = NULLIF(REPLACE(@name, CHAR(13), ''), ''),
  `park` = NULLIF(REPLACE(@park, CHAR(13), ''), ''),
  `attendance` = NULLIF(REPLACE(@attendance, CHAR(13), ''), ''),
  `BPF` = NULLIF(REPLACE(@BPF, CHAR(13), ''), ''),
  `PPF` = NULLIF(REPLACE(@PPF, CHAR(13), ''), ''),
  `teamIDBR` = NULLIF(REPLACE(@teamIDBR, CHAR(13), ''), ''),
  `teamIDlahman45` = NULLIF(REPLACE(@teamIDlahman45, CHAR(13), ''), ''),
  `teamIDretro` = NULLIF(REPLACE(@teamIDretro, CHAR(13), ''), '');

LOAD DATA LOCAL INFILE './data/TeamsFranchises.csv'
INTO TABLE `TeamsFranchises`
CHARACTER SET utf8mb4
FIELDS TERMINATED BY ',' OPTIONALLY ENCLOSED BY '"' ESCAPED BY '"'
LINES TERMINATED BY '\n'
IGNORE 1 LINES
(@franchID, @franchName, @active, @NAassoc)
SET
  `franchID` = NULLIF(REPLACE(@franchID, CHAR(13), ''), ''),
  `franchName` = NULLIF(REPLACE(@franchName, CHAR(13), ''), ''),
  `active` = NULLIF(REPLACE(@active, CHAR(13), ''), ''),
  `NAassoc` = NULLIF(REPLACE(@NAassoc, CHAR(13), ''), '');

LOAD DATA LOCAL INFILE './data/TeamsHalf.csv'
INTO TABLE `TeamsHalf`
CHARACTER SET utf8mb4
FIELDS TERMINATED BY ',' OPTIONALLY ENCLOSED BY '"' ESCAPED BY '"'
LINES TERMINATED BY '\n'
IGNORE 1 LINES
(@yearID, @lgID, @teamID, @Half, @divID, @DivWin, @Rank, @G, @W, @L)
SET
  `yearID` = NULLIF(REPLACE(@yearID, CHAR(13), ''), ''),
  `lgID` = NULLIF(REPLACE(@lgID, CHAR(13), ''), ''),
  `teamID` = NULLIF(REPLACE(@teamID, CHAR(13), ''), ''),
  `Half` = NULLIF(REPLACE(@Half, CHAR(13), ''), ''),
  `divID` = NULLIF(REPLACE(@divID, CHAR(13), ''), ''),
  `DivWin` = NULLIF(REPLACE(@DivWin, CHAR(13), ''), ''),
  `Rank` = NULLIF(REPLACE(@Rank, CHAR(13), ''), ''),
  `G` = NULLIF(REPLACE(@G, CHAR(13), ''), ''),
  `W` = NULLIF(REPLACE(@W, CHAR(13), ''), ''),
  `L` = NULLIF(REPLACE(@L, CHAR(13), ''), '');

SET FOREIGN_KEY_CHECKS=1;
