-- Load Lahman CSV data into MariaDB tables
-- Empty CSV fields are imported as NULL for nullable columns; only each row's last field is CR-cleaned.
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
  `playerID` = NULLIF(@playerID, ''),
  `yearID` = NULLIF(@yearID, ''),
  `gameNum` = NULLIF(@gameNum, ''),
  `gameID` = NULLIF(@gameID, ''),
  `teamID` = NULLIF(@teamID, ''),
  `lgID` = NULLIF(@lgID, ''),
  `GP` = NULLIF(@GP, ''),
  `startingPos` = NULLIF(REPLACE(@startingPos, CHAR(13), ''), '');

LOAD DATA LOCAL INFILE './data/Appearances.csv'
INTO TABLE `Appearances`
CHARACTER SET utf8mb4
FIELDS TERMINATED BY ',' OPTIONALLY ENCLOSED BY '"' ESCAPED BY '"'
LINES TERMINATED BY '\n'
IGNORE 1 LINES
(@yearID, @teamID, @lgID, @playerID, @G_all, @GS, @G_batting, @G_defense, @G_p, @G_c, @G_1b, @G_2b, @G_3b, @G_ss, @G_lf, @G_cf, @G_rf, @G_of, @G_dh, @G_ph, @G_pr)
SET
  `yearID` = @yearID,
  `teamID` = @teamID,
  `lgID` = NULLIF(@lgID, ''),
  `playerID` = @playerID,
  `G_all` = NULLIF(@G_all, ''),
  `GS` = NULLIF(@GS, ''),
  `G_batting` = NULLIF(@G_batting, ''),
  `G_defense` = NULLIF(@G_defense, ''),
  `G_p` = NULLIF(@G_p, ''),
  `G_c` = NULLIF(@G_c, ''),
  `G_1b` = NULLIF(@G_1b, ''),
  `G_2b` = NULLIF(@G_2b, ''),
  `G_3b` = NULLIF(@G_3b, ''),
  `G_ss` = NULLIF(@G_ss, ''),
  `G_lf` = NULLIF(@G_lf, ''),
  `G_cf` = NULLIF(@G_cf, ''),
  `G_rf` = NULLIF(@G_rf, ''),
  `G_of` = NULLIF(@G_of, ''),
  `G_dh` = NULLIF(@G_dh, ''),
  `G_ph` = NULLIF(@G_ph, ''),
  `G_pr` = NULLIF(REPLACE(@G_pr, CHAR(13), ''), '');

LOAD DATA LOCAL INFILE './data/AwardsManagers.csv'
INTO TABLE `AwardsManagers`
CHARACTER SET utf8mb4
FIELDS TERMINATED BY ',' OPTIONALLY ENCLOSED BY '"' ESCAPED BY '"'
LINES TERMINATED BY '\n'
IGNORE 1 LINES
(@playerID, @awardID, @yearID, @lgID, @tie, @notes)
SET
  `playerID` = @playerID,
  `awardID` = @awardID,
  `yearID` = @yearID,
  `lgID` = @lgID,
  `tie` = NULLIF(@tie, ''),
  `notes` = NULLIF(REPLACE(@notes, CHAR(13), ''), '');

LOAD DATA LOCAL INFILE './data/AwardsPlayers.csv'
INTO TABLE `AwardsPlayers`
CHARACTER SET utf8mb4
FIELDS TERMINATED BY ',' OPTIONALLY ENCLOSED BY '"' ESCAPED BY '"'
LINES TERMINATED BY '\n'
IGNORE 1 LINES
(@playerID, @awardID, @yearID, @lgID, @tie, @notes)
SET
  `playerID` = NULLIF(@playerID, ''),
  `awardID` = NULLIF(@awardID, ''),
  `yearID` = NULLIF(@yearID, ''),
  `lgID` = NULLIF(@lgID, ''),
  `tie` = NULLIF(@tie, ''),
  `notes` = NULLIF(REPLACE(@notes, CHAR(13), ''), '');

LOAD DATA LOCAL INFILE './data/AwardsShareManagers.csv'
INTO TABLE `AwardsShareManagers`
CHARACTER SET utf8mb4
FIELDS TERMINATED BY ',' OPTIONALLY ENCLOSED BY '"' ESCAPED BY '"'
LINES TERMINATED BY '\n'
IGNORE 1 LINES
(@awardID, @yearID, @lgID, @playerID, @pointsWon, @pointsMax, @votesFirst)
SET
  `awardID` = @awardID,
  `yearID` = @yearID,
  `lgID` = @lgID,
  `playerID` = @playerID,
  `pointsWon` = NULLIF(@pointsWon, ''),
  `pointsMax` = NULLIF(@pointsMax, ''),
  `votesFirst` = NULLIF(REPLACE(@votesFirst, CHAR(13), ''), '');

LOAD DATA LOCAL INFILE './data/AwardsSharePlayers.csv'
INTO TABLE `AwardsSharePlayers`
CHARACTER SET utf8mb4
FIELDS TERMINATED BY ',' OPTIONALLY ENCLOSED BY '"' ESCAPED BY '"'
LINES TERMINATED BY '\n'
IGNORE 1 LINES
(@awardID, @yearID, @lgID, @playerID, @pointsWon, @pointsMax, @votesFirst)
SET
  `awardID` = @awardID,
  `yearID` = @yearID,
  `lgID` = @lgID,
  `playerID` = @playerID,
  `pointsWon` = NULLIF(@pointsWon, ''),
  `pointsMax` = NULLIF(@pointsMax, ''),
  `votesFirst` = NULLIF(REPLACE(@votesFirst, CHAR(13), ''), '');

LOAD DATA LOCAL INFILE './data/Batting.csv'
INTO TABLE `Batting`
CHARACTER SET utf8mb4
FIELDS TERMINATED BY ',' OPTIONALLY ENCLOSED BY '"' ESCAPED BY '"'
LINES TERMINATED BY '\n'
IGNORE 1 LINES
(@playerID, @yearID, @stint, @teamID, @lgID, @G, @AB, @R, @H, @2B, @3B, @HR, @RBI, @SB, @CS, @BB, @SO, @IBB, @HBP, @SH, @SF, @GIDP)
SET
  `playerID` = @playerID,
  `yearID` = @yearID,
  `stint` = @stint,
  `teamID` = NULLIF(@teamID, ''),
  `lgID` = NULLIF(@lgID, ''),
  `G` = NULLIF(@G, ''),
  `AB` = NULLIF(@AB, ''),
  `R` = NULLIF(@R, ''),
  `H` = NULLIF(@H, ''),
  `2B` = NULLIF(@2B, ''),
  `3B` = NULLIF(@3B, ''),
  `HR` = NULLIF(@HR, ''),
  `RBI` = NULLIF(@RBI, ''),
  `SB` = NULLIF(@SB, ''),
  `CS` = NULLIF(@CS, ''),
  `BB` = NULLIF(@BB, ''),
  `SO` = NULLIF(@SO, ''),
  `IBB` = NULLIF(@IBB, ''),
  `HBP` = NULLIF(@HBP, ''),
  `SH` = NULLIF(@SH, ''),
  `SF` = NULLIF(@SF, ''),
  `GIDP` = NULLIF(REPLACE(@GIDP, CHAR(13), ''), '');

LOAD DATA LOCAL INFILE './data/BattingPost.csv'
INTO TABLE `BattingPost`
CHARACTER SET utf8mb4
FIELDS TERMINATED BY ',' OPTIONALLY ENCLOSED BY '"' ESCAPED BY '"'
LINES TERMINATED BY '\n'
IGNORE 1 LINES
(@yearID, @round, @playerID, @teamID, @lgID, @G, @AB, @R, @H, @2B, @3B, @HR, @RBI, @SB, @CS, @BB, @SO, @IBB, @HBP, @SH, @SF, @GIDP)
SET
  `yearID` = @yearID,
  `round` = @round,
  `playerID` = @playerID,
  `teamID` = NULLIF(@teamID, ''),
  `lgID` = NULLIF(@lgID, ''),
  `G` = NULLIF(@G, ''),
  `AB` = NULLIF(@AB, ''),
  `R` = NULLIF(@R, ''),
  `H` = NULLIF(@H, ''),
  `2B` = NULLIF(@2B, ''),
  `3B` = NULLIF(@3B, ''),
  `HR` = NULLIF(@HR, ''),
  `RBI` = NULLIF(@RBI, ''),
  `SB` = NULLIF(@SB, ''),
  `CS` = NULLIF(@CS, ''),
  `BB` = NULLIF(@BB, ''),
  `SO` = NULLIF(@SO, ''),
  `IBB` = NULLIF(@IBB, ''),
  `HBP` = NULLIF(@HBP, ''),
  `SH` = NULLIF(@SH, ''),
  `SF` = NULLIF(@SF, ''),
  `GIDP` = NULLIF(REPLACE(@GIDP, CHAR(13), ''), '');

LOAD DATA LOCAL INFILE './data/CollegePlaying.csv'
INTO TABLE `CollegePlaying`
CHARACTER SET utf8mb4
FIELDS TERMINATED BY ',' OPTIONALLY ENCLOSED BY '"' ESCAPED BY '"'
LINES TERMINATED BY '\n'
IGNORE 1 LINES
(@playerID, @schoolID, @yearID)
SET
  `playerID` = @playerID,
  `schoolID` = NULLIF(@schoolID, ''),
  `yearID` = NULLIF(REPLACE(@yearID, CHAR(13), ''), '');

LOAD DATA LOCAL INFILE './data/Fielding.csv'
INTO TABLE `Fielding`
CHARACTER SET utf8mb4
FIELDS TERMINATED BY ',' OPTIONALLY ENCLOSED BY '"' ESCAPED BY '"'
LINES TERMINATED BY '\n'
IGNORE 1 LINES
(@playerID, @yearID, @stint, @teamID, @lgID, @POS, @G, @GS, @InnOuts, @PO, @A, @E, @DP, @PB, @WP, @SB, @CS, @ZR)
SET
  `playerID` = @playerID,
  `yearID` = @yearID,
  `stint` = @stint,
  `teamID` = NULLIF(@teamID, ''),
  `lgID` = NULLIF(@lgID, ''),
  `POS` = @POS,
  `G` = NULLIF(@G, ''),
  `GS` = NULLIF(@GS, ''),
  `InnOuts` = NULLIF(@InnOuts, ''),
  `PO` = NULLIF(@PO, ''),
  `A` = NULLIF(@A, ''),
  `E` = NULLIF(@E, ''),
  `DP` = NULLIF(@DP, ''),
  `PB` = NULLIF(@PB, ''),
  `WP` = NULLIF(@WP, ''),
  `SB` = NULLIF(@SB, ''),
  `CS` = NULLIF(@CS, ''),
  `ZR` = NULLIF(REPLACE(@ZR, CHAR(13), ''), '');

LOAD DATA LOCAL INFILE './data/FieldingOF.csv'
INTO TABLE `FieldingOF`
CHARACTER SET utf8mb4
FIELDS TERMINATED BY ',' OPTIONALLY ENCLOSED BY '"' ESCAPED BY '"'
LINES TERMINATED BY '\n'
IGNORE 1 LINES
(@playerID, @yearID, @stint, @Glf, @Gcf, @Grf)
SET
  `playerID` = @playerID,
  `yearID` = @yearID,
  `stint` = @stint,
  `Glf` = NULLIF(@Glf, ''),
  `Gcf` = NULLIF(@Gcf, ''),
  `Grf` = NULLIF(REPLACE(@Grf, CHAR(13), ''), '');

LOAD DATA LOCAL INFILE './data/FieldingOFsplit.csv'
INTO TABLE `FieldingOFsplit`
CHARACTER SET utf8mb4
FIELDS TERMINATED BY ',' OPTIONALLY ENCLOSED BY '"' ESCAPED BY '"'
LINES TERMINATED BY '\n'
IGNORE 1 LINES
(@playerID, @yearID, @stint, @teamID, @lgID, @POS, @G, @GS, @InnOuts, @PO, @A, @E, @DP, @PB, @WP, @SB, @CS, @ZR)
SET
  `playerID` = @playerID,
  `yearID` = @yearID,
  `stint` = @stint,
  `teamID` = NULLIF(@teamID, ''),
  `lgID` = NULLIF(@lgID, ''),
  `POS` = @POS,
  `G` = NULLIF(@G, ''),
  `GS` = NULLIF(@GS, ''),
  `InnOuts` = NULLIF(@InnOuts, ''),
  `PO` = NULLIF(@PO, ''),
  `A` = NULLIF(@A, ''),
  `E` = NULLIF(@E, ''),
  `DP` = NULLIF(@DP, ''),
  `PB` = NULLIF(@PB, ''),
  `WP` = NULLIF(@WP, ''),
  `SB` = NULLIF(@SB, ''),
  `CS` = NULLIF(@CS, ''),
  `ZR` = NULLIF(REPLACE(@ZR, CHAR(13), ''), '');

LOAD DATA LOCAL INFILE './data/FieldingPost.csv'
INTO TABLE `FieldingPost`
CHARACTER SET utf8mb4
FIELDS TERMINATED BY ',' OPTIONALLY ENCLOSED BY '"' ESCAPED BY '"'
LINES TERMINATED BY '\n'
IGNORE 1 LINES
(@playerID, @yearID, @teamID, @lgID, @round, @POS, @G, @GS, @InnOuts, @PO, @A, @E, @DP, @TP, @PB, @SB, @CS)
SET
  `playerID` = @playerID,
  `yearID` = @yearID,
  `teamID` = NULLIF(@teamID, ''),
  `lgID` = NULLIF(@lgID, ''),
  `round` = @round,
  `POS` = @POS,
  `G` = NULLIF(@G, ''),
  `GS` = NULLIF(@GS, ''),
  `InnOuts` = NULLIF(@InnOuts, ''),
  `PO` = NULLIF(@PO, ''),
  `A` = NULLIF(@A, ''),
  `E` = NULLIF(@E, ''),
  `DP` = NULLIF(@DP, ''),
  `TP` = NULLIF(@TP, ''),
  `PB` = NULLIF(@PB, ''),
  `SB` = NULLIF(@SB, ''),
  `CS` = NULLIF(REPLACE(@CS, CHAR(13), ''), '');

LOAD DATA LOCAL INFILE './data/HallOfFame.csv'
INTO TABLE `HallOfFame`
CHARACTER SET utf8mb4
FIELDS TERMINATED BY ',' OPTIONALLY ENCLOSED BY '"' ESCAPED BY '"'
LINES TERMINATED BY '\n'
IGNORE 1 LINES
(@playerID, @yearid, @votedBy, @ballots, @needed, @votes, @inducted, @category, @needed_note)
SET
  `playerID` = @playerID,
  `yearid` = @yearid,
  `votedBy` = @votedBy,
  `ballots` = NULLIF(@ballots, ''),
  `needed` = NULLIF(@needed, ''),
  `votes` = NULLIF(@votes, ''),
  `inducted` = NULLIF(@inducted, ''),
  `category` = NULLIF(@category, ''),
  `needed_note` = NULLIF(REPLACE(@needed_note, CHAR(13), ''), '');

LOAD DATA LOCAL INFILE './data/HomeGames.csv'
INTO TABLE `HomeGames`
CHARACTER SET utf8mb4
FIELDS TERMINATED BY ',' OPTIONALLY ENCLOSED BY '"' ESCAPED BY '"'
LINES TERMINATED BY '\n'
IGNORE 1 LINES
(@yearkey, @leaguekey, @teamkey, @parkkey, @spanfirst, @spanlast, @games, @openings, @attendance)
SET
  `yearkey` = NULLIF(@yearkey, ''),
  `leaguekey` = NULLIF(@leaguekey, ''),
  `teamkey` = NULLIF(@teamkey, ''),
  `parkkey` = NULLIF(@parkkey, ''),
  `spanfirst` = NULLIF(@spanfirst, ''),
  `spanlast` = NULLIF(@spanlast, ''),
  `games` = NULLIF(@games, ''),
  `openings` = NULLIF(@openings, ''),
  `attendance` = NULLIF(REPLACE(@attendance, CHAR(13), ''), '');

LOAD DATA LOCAL INFILE './data/Managers.csv'
INTO TABLE `Managers`
CHARACTER SET utf8mb4
FIELDS TERMINATED BY ',' OPTIONALLY ENCLOSED BY '"' ESCAPED BY '"'
LINES TERMINATED BY '\n'
IGNORE 1 LINES
(@playerID, @yearID, @teamID, @lgID, @inseason, @G, @W, @L, @rank, @plyrMgr)
SET
  `playerID` = NULLIF(@playerID, ''),
  `yearID` = @yearID,
  `teamID` = @teamID,
  `lgID` = NULLIF(@lgID, ''),
  `inseason` = @inseason,
  `G` = NULLIF(@G, ''),
  `W` = NULLIF(@W, ''),
  `L` = NULLIF(@L, ''),
  `rank` = NULLIF(@rank, ''),
  `plyrMgr` = NULLIF(REPLACE(@plyrMgr, CHAR(13), ''), '');

LOAD DATA LOCAL INFILE './data/ManagersHalf.csv'
INTO TABLE `ManagersHalf`
CHARACTER SET utf8mb4
FIELDS TERMINATED BY ',' OPTIONALLY ENCLOSED BY '"' ESCAPED BY '"'
LINES TERMINATED BY '\n'
IGNORE 1 LINES
(@playerID, @yearID, @teamID, @lgID, @inseason, @half, @G, @W, @L, @rank)
SET
  `playerID` = @playerID,
  `yearID` = @yearID,
  `teamID` = @teamID,
  `lgID` = NULLIF(@lgID, ''),
  `inseason` = NULLIF(@inseason, ''),
  `half` = @half,
  `G` = NULLIF(@G, ''),
  `W` = NULLIF(@W, ''),
  `L` = NULLIF(@L, ''),
  `rank` = NULLIF(REPLACE(@rank, CHAR(13), ''), '');

LOAD DATA LOCAL INFILE './data/Parks.csv'
INTO TABLE `Parks`
CHARACTER SET utf8mb4
FIELDS TERMINATED BY ',' OPTIONALLY ENCLOSED BY '"' ESCAPED BY '"'
LINES TERMINATED BY '\n'
IGNORE 1 LINES
(@ID, @parkalias, @parkkey, @parkname, @city, @state, @country)
SET
  `ID` = @ID,
  `parkalias` = NULLIF(@parkalias, ''),
  `parkkey` = NULLIF(@parkkey, ''),
  `parkname` = NULLIF(@parkname, ''),
  `city` = NULLIF(@city, ''),
  `state` = NULLIF(@state, ''),
  `country` = NULLIF(REPLACE(@country, CHAR(13), ''), '');

LOAD DATA LOCAL INFILE './data/People.csv'
INTO TABLE `People`
CHARACTER SET utf8mb4
FIELDS TERMINATED BY ',' OPTIONALLY ENCLOSED BY '"' ESCAPED BY '"'
LINES TERMINATED BY '\n'
IGNORE 1 LINES
(@ID, @playerID, @birthYear, @birthMonth, @birthDay, @birthCity, @birthCountry, @birthState, @deathYear, @deathMonth, @deathDay, @deathCountry, @deathState, @deathCity, @nameFirst, @nameLast, @nameGiven, @weight, @height, @bats, @throws, @debut, @bbrefID, @finalGame, @retroID)
SET
  `ID` = @ID,
  `playerID` = @playerID,
  `birthYear` = NULLIF(@birthYear, ''),
  `birthMonth` = NULLIF(@birthMonth, ''),
  `birthDay` = NULLIF(@birthDay, ''),
  `birthCity` = NULLIF(@birthCity, ''),
  `birthCountry` = NULLIF(@birthCountry, ''),
  `birthState` = NULLIF(@birthState, ''),
  `deathYear` = NULLIF(@deathYear, ''),
  `deathMonth` = NULLIF(@deathMonth, ''),
  `deathDay` = NULLIF(@deathDay, ''),
  `deathCountry` = NULLIF(@deathCountry, ''),
  `deathState` = NULLIF(@deathState, ''),
  `deathCity` = NULLIF(@deathCity, ''),
  `nameFirst` = NULLIF(@nameFirst, ''),
  `nameLast` = NULLIF(@nameLast, ''),
  `nameGiven` = NULLIF(@nameGiven, ''),
  `weight` = NULLIF(@weight, ''),
  `height` = NULLIF(@height, ''),
  `bats` = NULLIF(@bats, ''),
  `throws` = NULLIF(@throws, ''),
  `debut` = NULLIF(@debut, ''),
  `bbrefID` = NULLIF(@bbrefID, ''),
  `finalGame` = NULLIF(@finalGame, ''),
  `retroID` = NULLIF(REPLACE(@retroID, CHAR(13), ''), '');

LOAD DATA LOCAL INFILE './data/Pitching.csv'
INTO TABLE `Pitching`
CHARACTER SET utf8mb4
FIELDS TERMINATED BY ',' OPTIONALLY ENCLOSED BY '"' ESCAPED BY '"'
LINES TERMINATED BY '\n'
IGNORE 1 LINES
(@playerID, @yearID, @stint, @teamID, @lgID, @W, @L, @G, @GS, @CG, @SHO, @SV, @IPouts, @H, @ER, @HR, @BB, @SO, @BAOpp, @ERA, @IBB, @WP, @HBP, @BK, @BFP, @GF, @R, @SH, @SF, @GIDP)
SET
  `playerID` = @playerID,
  `yearID` = @yearID,
  `stint` = @stint,
  `teamID` = NULLIF(@teamID, ''),
  `lgID` = NULLIF(@lgID, ''),
  `W` = NULLIF(@W, ''),
  `L` = NULLIF(@L, ''),
  `G` = NULLIF(@G, ''),
  `GS` = NULLIF(@GS, ''),
  `CG` = NULLIF(@CG, ''),
  `SHO` = NULLIF(@SHO, ''),
  `SV` = NULLIF(@SV, ''),
  `IPouts` = NULLIF(@IPouts, ''),
  `H` = NULLIF(@H, ''),
  `ER` = NULLIF(@ER, ''),
  `HR` = NULLIF(@HR, ''),
  `BB` = NULLIF(@BB, ''),
  `SO` = NULLIF(@SO, ''),
  `BAOpp` = NULLIF(@BAOpp, ''),
  `ERA` = NULLIF(@ERA, ''),
  `IBB` = NULLIF(@IBB, ''),
  `WP` = NULLIF(@WP, ''),
  `HBP` = NULLIF(@HBP, ''),
  `BK` = NULLIF(@BK, ''),
  `BFP` = NULLIF(@BFP, ''),
  `GF` = NULLIF(@GF, ''),
  `R` = NULLIF(@R, ''),
  `SH` = NULLIF(@SH, ''),
  `SF` = NULLIF(@SF, ''),
  `GIDP` = NULLIF(REPLACE(@GIDP, CHAR(13), ''), '');

LOAD DATA LOCAL INFILE './data/PitchingPost.csv'
INTO TABLE `PitchingPost`
CHARACTER SET utf8mb4
FIELDS TERMINATED BY ',' OPTIONALLY ENCLOSED BY '"' ESCAPED BY '"'
LINES TERMINATED BY '\n'
IGNORE 1 LINES
(@playerID, @yearID, @round, @teamID, @lgID, @W, @L, @G, @GS, @CG, @SHO, @SV, @IPouts, @H, @ER, @HR, @BB, @SO, @BAOpp, @ERA, @IBB, @WP, @HBP, @BK, @BFP, @GF, @R, @SH, @SF, @GIDP)
SET
  `playerID` = @playerID,
  `yearID` = @yearID,
  `round` = @round,
  `teamID` = NULLIF(@teamID, ''),
  `lgID` = NULLIF(@lgID, ''),
  `W` = NULLIF(@W, ''),
  `L` = NULLIF(@L, ''),
  `G` = NULLIF(@G, ''),
  `GS` = NULLIF(@GS, ''),
  `CG` = NULLIF(@CG, ''),
  `SHO` = NULLIF(@SHO, ''),
  `SV` = NULLIF(@SV, ''),
  `IPouts` = NULLIF(@IPouts, ''),
  `H` = NULLIF(@H, ''),
  `ER` = NULLIF(@ER, ''),
  `HR` = NULLIF(@HR, ''),
  `BB` = NULLIF(@BB, ''),
  `SO` = NULLIF(@SO, ''),
  `BAOpp` = NULLIF(@BAOpp, ''),
  `ERA` = NULLIF(@ERA, ''),
  `IBB` = NULLIF(@IBB, ''),
  `WP` = NULLIF(@WP, ''),
  `HBP` = NULLIF(@HBP, ''),
  `BK` = NULLIF(@BK, ''),
  `BFP` = NULLIF(@BFP, ''),
  `GF` = NULLIF(@GF, ''),
  `R` = NULLIF(@R, ''),
  `SH` = NULLIF(@SH, ''),
  `SF` = NULLIF(@SF, ''),
  `GIDP` = NULLIF(REPLACE(@GIDP, CHAR(13), ''), '');

LOAD DATA LOCAL INFILE './data/Salaries.csv'
INTO TABLE `Salaries`
CHARACTER SET utf8mb4
FIELDS TERMINATED BY ',' OPTIONALLY ENCLOSED BY '"' ESCAPED BY '"'
LINES TERMINATED BY '\n'
IGNORE 1 LINES
(@yearID, @teamID, @lgID, @playerID, @salary)
SET
  `yearID` = @yearID,
  `teamID` = @teamID,
  `lgID` = @lgID,
  `playerID` = @playerID,
  `salary` = NULLIF(REPLACE(@salary, CHAR(13), ''), '');

LOAD DATA LOCAL INFILE './data/Schools.csv'
INTO TABLE `Schools`
CHARACTER SET utf8mb4
FIELDS TERMINATED BY ',' OPTIONALLY ENCLOSED BY '"' ESCAPED BY '"'
LINES TERMINATED BY '\n'
IGNORE 1 LINES
(@schoolID, @name_full, @city, @state, @country)
SET
  `schoolID` = @schoolID,
  `name_full` = NULLIF(@name_full, ''),
  `city` = NULLIF(@city, ''),
  `state` = NULLIF(@state, ''),
  `country` = NULLIF(REPLACE(@country, CHAR(13), ''), '');

LOAD DATA LOCAL INFILE './data/SeriesPost.csv'
INTO TABLE `SeriesPost`
CHARACTER SET utf8mb4
FIELDS TERMINATED BY ',' OPTIONALLY ENCLOSED BY '"' ESCAPED BY '"'
LINES TERMINATED BY '\n'
IGNORE 1 LINES
(@yearID, @round, @teamIDwinner, @lgIDwinner, @teamIDloser, @lgIDloser, @wins, @losses, @ties)
SET
  `yearID` = @yearID,
  `round` = @round,
  `teamIDwinner` = NULLIF(@teamIDwinner, ''),
  `lgIDwinner` = NULLIF(@lgIDwinner, ''),
  `teamIDloser` = NULLIF(@teamIDloser, ''),
  `lgIDloser` = NULLIF(@lgIDloser, ''),
  `wins` = NULLIF(@wins, ''),
  `losses` = NULLIF(@losses, ''),
  `ties` = NULLIF(REPLACE(@ties, CHAR(13), ''), '');

LOAD DATA LOCAL INFILE './data/Teams.csv'
INTO TABLE `Teams`
CHARACTER SET utf8mb4
FIELDS TERMINATED BY ',' OPTIONALLY ENCLOSED BY '"' ESCAPED BY '"'
LINES TERMINATED BY '\n'
IGNORE 1 LINES
(@yearID, @lgID, @teamID, @franchID, @divID, @Rank, @G, @Ghome, @W, @L, @DivWin, @WCWin, @LgWin, @WSWin, @R, @AB, @H, @2B, @3B, @HR, @BB, @SO, @SB, @CS, @HBP, @SF, @RA, @ER, @ERA, @CG, @SHO, @SV, @IPouts, @HA, @HRA, @BBA, @SOA, @E, @DP, @FP, @name, @park, @attendance, @BPF, @PPF, @teamIDBR, @teamIDlahman45, @teamIDretro)
SET
  `yearID` = @yearID,
  `lgID` = @lgID,
  `teamID` = @teamID,
  `franchID` = NULLIF(@franchID, ''),
  `divID` = NULLIF(@divID, ''),
  `Rank` = NULLIF(@Rank, ''),
  `G` = NULLIF(@G, ''),
  `Ghome` = NULLIF(@Ghome, ''),
  `W` = NULLIF(@W, ''),
  `L` = NULLIF(@L, ''),
  `DivWin` = NULLIF(@DivWin, ''),
  `WCWin` = NULLIF(@WCWin, ''),
  `LgWin` = NULLIF(@LgWin, ''),
  `WSWin` = NULLIF(@WSWin, ''),
  `R` = NULLIF(@R, ''),
  `AB` = NULLIF(@AB, ''),
  `H` = NULLIF(@H, ''),
  `2B` = NULLIF(@2B, ''),
  `3B` = NULLIF(@3B, ''),
  `HR` = NULLIF(@HR, ''),
  `BB` = NULLIF(@BB, ''),
  `SO` = NULLIF(@SO, ''),
  `SB` = NULLIF(@SB, ''),
  `CS` = NULLIF(@CS, ''),
  `HBP` = NULLIF(@HBP, ''),
  `SF` = NULLIF(@SF, ''),
  `RA` = NULLIF(@RA, ''),
  `ER` = NULLIF(@ER, ''),
  `ERA` = NULLIF(@ERA, ''),
  `CG` = NULLIF(@CG, ''),
  `SHO` = NULLIF(@SHO, ''),
  `SV` = NULLIF(@SV, ''),
  `IPouts` = NULLIF(@IPouts, ''),
  `HA` = NULLIF(@HA, ''),
  `HRA` = NULLIF(@HRA, ''),
  `BBA` = NULLIF(@BBA, ''),
  `SOA` = NULLIF(@SOA, ''),
  `E` = NULLIF(@E, ''),
  `DP` = NULLIF(@DP, ''),
  `FP` = NULLIF(@FP, ''),
  `name` = NULLIF(@name, ''),
  `park` = NULLIF(@park, ''),
  `attendance` = NULLIF(@attendance, ''),
  `BPF` = NULLIF(@BPF, ''),
  `PPF` = NULLIF(@PPF, ''),
  `teamIDBR` = NULLIF(@teamIDBR, ''),
  `teamIDlahman45` = NULLIF(@teamIDlahman45, ''),
  `teamIDretro` = NULLIF(REPLACE(@teamIDretro, CHAR(13), ''), '');

LOAD DATA LOCAL INFILE './data/TeamsFranchises.csv'
INTO TABLE `TeamsFranchises`
CHARACTER SET utf8mb4
FIELDS TERMINATED BY ',' OPTIONALLY ENCLOSED BY '"' ESCAPED BY '"'
LINES TERMINATED BY '\n'
IGNORE 1 LINES
(@franchID, @franchName, @active, @NAassoc)
SET
  `franchID` = @franchID,
  `franchName` = NULLIF(@franchName, ''),
  `active` = NULLIF(@active, ''),
  `NAassoc` = NULLIF(REPLACE(@NAassoc, CHAR(13), ''), '');

LOAD DATA LOCAL INFILE './data/TeamsHalf.csv'
INTO TABLE `TeamsHalf`
CHARACTER SET utf8mb4
FIELDS TERMINATED BY ',' OPTIONALLY ENCLOSED BY '"' ESCAPED BY '"'
LINES TERMINATED BY '\n'
IGNORE 1 LINES
(@yearID, @lgID, @teamID, @Half, @divID, @DivWin, @Rank, @G, @W, @L)
SET
  `yearID` = @yearID,
  `lgID` = @lgID,
  `teamID` = @teamID,
  `Half` = @Half,
  `divID` = NULLIF(@divID, ''),
  `DivWin` = NULLIF(@DivWin, ''),
  `Rank` = NULLIF(@Rank, ''),
  `G` = NULLIF(@G, ''),
  `W` = NULLIF(@W, ''),
  `L` = NULLIF(REPLACE(@L, CHAR(13), ''), '');

SET FOREIGN_KEY_CHECKS=1;
