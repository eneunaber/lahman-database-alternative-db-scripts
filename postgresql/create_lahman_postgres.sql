-- PostgreSQL conversion of create_lahman_script.sql
-- Run this in psql connected to your target cluster.
-- Optionally create the database first:
--   CREATE DATABASE lahman;
-- Then connect:
--   \c lahman

SET search_path TO public;
/****** Object:  Table PitchingPost    Script Date: 2/26/2026 10:12:25 PM ******/
;
;
CREATE TABLE PitchingPost(
	playerID varchar(20) NOT NULL,
	yearID smallint NOT NULL,
	round varchar(10) NOT NULL,
	teamID varchar(4) NULL,
	lgID varchar(3) NULL,
	W smallint NULL,
	L smallint NULL,
	G smallint NULL,
	GS smallint NULL,
	CG smallint NULL,
	SHO smallint NULL,
	SV smallint NULL,
	IPouts integer NULL,
	H smallint NULL,
	ER smallint NULL,
	HR smallint NULL,
	BB smallint NULL,
	SO smallint NULL,
	BAOpp double precision NULL,
	ERA double precision NULL,
	IBB smallint NULL,
	WP smallint NULL,
	HBP smallint NULL,
	BK smallint NULL,
	BFP smallint NULL,
	GF smallint NULL,
	R smallint NULL,
	SH smallint NULL,
	SF smallint NULL,
	GIDP smallint NULL
)
;
;
/****** Object:  Index CX_PitchingPost_year_round_player    Script Date: 2/26/2026 10:12:25 PM ******/
CREATE INDEX CX_PitchingPost_year_round_player ON PitchingPost
(
	yearID ASC,
	round ASC,
	playerID ASC
)
;
/****** Object:  View vw_Duplicate_PitchingPost    Script Date: 2/26/2026 10:12:25 PM ******/
;
;
-- PitchingPost: (playerID, yearID, teamID, round)
CREATE   VIEW vw_Duplicate_PitchingPost AS
SELECT playerID, yearID, teamID, round, COUNT(*) AS dup_count
FROM PitchingPost
GROUP BY playerID, yearID, teamID, round
HAVING COUNT(*) > 1;
;
/****** Object:  Table FieldingPost    Script Date: 2/26/2026 10:12:25 PM ******/
;
;
CREATE TABLE FieldingPost(
	playerID varchar(20) NOT NULL,
	yearID smallint NOT NULL,
	teamID varchar(4) NULL,
	lgID varchar(3) NULL,
	round varchar(10) NOT NULL,
	POS varchar(2) NOT NULL,
	G smallint NULL,
	GS smallint NULL,
	InnOuts smallint NULL,
	PO smallint NULL,
	A smallint NULL,
	E smallint NULL,
	DP smallint NULL,
	TP smallint NULL,
	PB smallint NULL,
	SB smallint NULL,
	CS smallint NULL
)
;
;
/****** Object:  Index CX_FieldingPost_player_year_team_round_pos    Script Date: 2/26/2026 10:12:25 PM ******/
CREATE INDEX CX_FieldingPost_player_year_team_round_pos ON FieldingPost
(
	playerID ASC,
	yearID ASC,
	teamID ASC,
	round ASC,
	POS ASC
)
;
/****** Object:  View vw_Duplicate_FieldingPost    Script Date: 2/26/2026 10:12:25 PM ******/
;
;
-- FieldingPost: (playerID, yearID, teamID, round, Pos)
CREATE   VIEW vw_Duplicate_FieldingPost AS
SELECT playerID, yearID, teamID, round, Pos, COUNT(*) AS dup_count
FROM FieldingPost
GROUP BY playerID, yearID, teamID, round, Pos
HAVING COUNT(*) > 1;
;
/****** Object:  Table SeriesPost    Script Date: 2/26/2026 10:12:25 PM ******/
;
;
CREATE TABLE SeriesPost(
	yearID smallint NOT NULL,
	round varchar(10) NOT NULL,
	teamIDwinner varchar(4) NULL,
	lgIDwinner varchar(3) NULL,
	teamIDloser varchar(4) NULL,
	lgIDloser varchar(3) NULL,
	wins smallint NULL,
	losses smallint NULL,
	ties smallint NULL
)
;
;
/****** Object:  Index CX_SeriesPost_year_round    Script Date: 2/26/2026 10:12:25 PM ******/
CREATE INDEX CX_SeriesPost_year_round ON SeriesPost
(
	yearID ASC,
	round ASC
)
;
/****** Object:  View vw_Duplicate_SeriesPost    Script Date: 2/26/2026 10:12:25 PM ******/
;
;
-- SeriesPost: (yearID, round)
CREATE   VIEW vw_Duplicate_SeriesPost AS
SELECT yearID, round, COUNT(*) AS dup_count
FROM SeriesPost
GROUP BY yearID, round
HAVING COUNT(*) > 1;
;
/****** Object:  Table ManagersHalf    Script Date: 2/26/2026 10:12:25 PM ******/
;
;
CREATE TABLE ManagersHalf(
	playerID varchar(20) NOT NULL,
	yearID smallint NOT NULL,
	teamID varchar(4) NOT NULL,
	lgID varchar(3) NULL,
	inseason smallint NULL,
	half smallint NOT NULL,
	G smallint NULL,
	W smallint NULL,
	L smallint NULL,
	rank smallint NULL
)
;
;
/****** Object:  Index CX_ManagersHalf_year_team_half    Script Date: 2/26/2026 10:12:25 PM ******/
CREATE INDEX CX_ManagersHalf_year_team_half ON ManagersHalf
(
	yearID ASC,
	teamID ASC,
	half ASC
)
;
/****** Object:  View vw_Duplicate_ManagersHalf    Script Date: 2/26/2026 10:12:25 PM ******/
;
;
-- ManagersHalf: (playerID, yearID, teamID, half)
CREATE   VIEW vw_Duplicate_ManagersHalf AS
SELECT playerID, yearID, teamID, half, COUNT(*) AS dup_count
FROM ManagersHalf
GROUP BY playerID, yearID, teamID, half
HAVING COUNT(*) > 1;
;
/****** Object:  Table TeamsHalf    Script Date: 2/26/2026 10:12:25 PM ******/
;
;
CREATE TABLE TeamsHalf(
	yearID smallint NOT NULL,
	lgID varchar(3) NOT NULL,
	teamID varchar(4) NOT NULL,
	Half smallint NOT NULL,
	divID varchar(2) NULL,
	DivWin varchar(1) NULL,
	Rank smallint NULL,
	G smallint NULL,
	W smallint NULL,
	L smallint NULL
)
;
;
/****** Object:  Index CX_TeamsHalf_year_team_half    Script Date: 2/26/2026 10:12:25 PM ******/
CREATE INDEX CX_TeamsHalf_year_team_half ON TeamsHalf
(
	yearID ASC,
	teamID ASC,
	Half ASC
)
;
/****** Object:  View vw_Duplicate_TeamsHalf    Script Date: 2/26/2026 10:12:25 PM ******/
;
;
-- TeamsHalf: (yearID, lgID, teamID, half)
CREATE   VIEW vw_Duplicate_TeamsHalf AS
SELECT yearID, lgID, teamID, half, COUNT(*) AS dup_count
FROM TeamsHalf
GROUP BY yearID, lgID, teamID, half
HAVING COUNT(*) > 1;
;
/****** Object:  Table AwardsManagers    Script Date: 2/26/2026 10:12:25 PM ******/
;
;
CREATE TABLE AwardsManagers(
	playerID varchar(20) NOT NULL,
	awardID varchar(255) NOT NULL,
	yearID smallint NOT NULL,
	lgID varchar(3) NOT NULL,
	tie varchar(1) NULL,
	notes varchar(255) NULL
)
;
;
/****** Object:  Index CX_AwardsManagers_player_award_year    Script Date: 2/26/2026 10:12:25 PM ******/
CREATE INDEX CX_AwardsManagers_player_award_year ON AwardsManagers
(
	playerID ASC,
	awardID ASC,
	yearID ASC
)
;
/****** Object:  View vw_Duplicate_AwardsManagers    Script Date: 2/26/2026 10:12:25 PM ******/
;
;
-- AwardsManagers: (playerID, awardID, yearID, lgID)
CREATE   VIEW vw_Duplicate_AwardsManagers AS
SELECT playerID, awardID, yearID, lgID, CAST(notes AS text) AS notes, COUNT(*) AS dup_count
FROM AwardsManagers
GROUP BY playerID, awardID, yearID, lgID, CAST(notes AS text)
HAVING COUNT(*) > 1;
;
/****** Object:  Table AwardsPlayers    Script Date: 2/26/2026 10:12:25 PM ******/
;
;
CREATE TABLE AwardsPlayers(
	playerID varchar(20) NULL,
	awardID varchar(255) NULL,
	yearID integer NULL,
	lgID varchar(3) NULL,
	tie varchar(1) NULL,
	notes varchar(255) NULL
)
;
;
/****** Object:  Index CX_AwardsPlayers_player_award_year    Script Date: 2/26/2026 10:12:25 PM ******/
CREATE INDEX CX_AwardsPlayers_player_award_year ON AwardsPlayers
(
	playerID ASC,
	awardID ASC,
	yearID ASC
)
;
/****** Object:  View vw_Duplicate_AwardsPlayers    Script Date: 2/26/2026 10:12:25 PM ******/
;
;
-- AwardsPlayers: (playerID, awardID, yearID, lgID)
CREATE   VIEW vw_Duplicate_AwardsPlayers AS
SELECT playerID, awardID, yearID, lgID, CAST(notes AS text) AS notes, COUNT(*) AS dup_count
FROM AwardsPlayers
GROUP BY playerID, awardID, yearID, lgID, CAST(notes AS text)
HAVING COUNT(*) > 1;
;
/****** Object:  Table AwardsShareManagers    Script Date: 2/26/2026 10:12:25 PM ******/
;
;
CREATE TABLE AwardsShareManagers(
	awardID varchar(255) NOT NULL,
	yearID smallint NOT NULL,
	lgID varchar(3) NOT NULL,
	playerID varchar(20) NOT NULL,
	pointsWon smallint NULL,
	pointsMax smallint NULL,
	votesFirst smallint NULL
)
;
;
/****** Object:  Index CX_AwardsShareManagers_player_award_year    Script Date: 2/26/2026 10:12:25 PM ******/
CREATE INDEX CX_AwardsShareManagers_player_award_year ON AwardsShareManagers
(
	playerID ASC,
	awardID ASC,
	yearID ASC
)
;
/****** Object:  View vw_Duplicate_AwardsShareManagers    Script Date: 2/26/2026 10:12:25 PM ******/
;
;
-- AwardsShareManagers: (playerID, awardID, yearID, lgID)
CREATE   VIEW vw_Duplicate_AwardsShareManagers AS
SELECT playerID, awardID, yearID, lgID, COUNT(*) AS dup_count
FROM AwardsShareManagers
GROUP BY playerID, awardID, yearID, lgID
HAVING COUNT(*) > 1;
;
/****** Object:  Table AwardsSharePlayers    Script Date: 2/26/2026 10:12:25 PM ******/
;
;
CREATE TABLE AwardsSharePlayers(
	awardID varchar(255) NOT NULL,
	yearID smallint NOT NULL,
	lgID varchar(3) NOT NULL,
	playerID varchar(20) NOT NULL,
	pointsWon smallint NULL,
	pointsMax smallint NULL,
	votesFirst smallint NULL
)
;
;
/****** Object:  Index CX_AwardsSharePlayers_player_award_year    Script Date: 2/26/2026 10:12:25 PM ******/
CREATE INDEX CX_AwardsSharePlayers_player_award_year ON AwardsSharePlayers
(
	playerID ASC,
	awardID ASC,
	yearID ASC
)
;
/****** Object:  View vw_Duplicate_AwardsSharePlayers    Script Date: 2/26/2026 10:12:25 PM ******/
;
;
-- AwardsSharePlayers: (playerID, awardID, yearID, lgID)
CREATE   VIEW vw_Duplicate_AwardsSharePlayers AS
SELECT playerID, awardID, yearID, lgID, COUNT(*) AS dup_count
FROM AwardsSharePlayers
GROUP BY playerID, awardID, yearID, lgID
HAVING COUNT(*) > 1;
;
/****** Object:  Table HallOfFame    Script Date: 2/26/2026 10:12:25 PM ******/
;
;
CREATE TABLE HallOfFame(
	playerID varchar(20) NOT NULL,
	yearid smallint NOT NULL,
	votedBy varchar(255) NOT NULL,
	ballots smallint NULL,
	needed smallint NULL,
	votes smallint NULL,
	inducted varchar(1) NULL,
	category varchar(100) NULL,
	needed_note varchar(1000) NULL
)
;
;
/****** Object:  Index CX_HallOfFame_player_year_votedBy    Script Date: 2/26/2026 10:12:25 PM ******/
CREATE INDEX CX_HallOfFame_player_year_votedBy ON HallOfFame
(
	playerID ASC,
	yearid ASC,
	votedBy ASC
)
;
/****** Object:  View vw_Duplicate_HallOfFame    Script Date: 2/26/2026 10:12:25 PM ******/
;
;
-- HallOfFame: (playerID, yearID, votedBy)
CREATE   VIEW vw_Duplicate_HallOfFame AS
SELECT playerID, yearID, votedBy, COUNT(*) AS dup_count
FROM HallOfFame
GROUP BY playerID, yearID, votedBy
HAVING COUNT(*) > 1;
;
/****** Object:  Table CollegePlaying    Script Date: 2/26/2026 10:12:25 PM ******/
;
;
CREATE TABLE CollegePlaying(
	playerID varchar(20) NOT NULL,
	schoolID varchar(20) NULL,
	yearID smallint NULL
)
;
;
/****** Object:  Index CX_CollegePlaying_player_year_school    Script Date: 2/26/2026 10:12:25 PM ******/
CREATE INDEX CX_CollegePlaying_player_year_school ON CollegePlaying
(
	playerID ASC,
	yearID ASC,
	schoolID ASC
)
;
/****** Object:  View vw_Duplicate_CollegePlaying    Script Date: 2/26/2026 10:12:25 PM ******/
;
;
-- CollegePlaying: (playerID, schoolID, year)
CREATE   VIEW vw_Duplicate_CollegePlaying AS
SELECT playerID, schoolID, yearID, COUNT(*) AS dup_count
FROM CollegePlaying
GROUP BY playerID, schoolID, yearID
HAVING COUNT(*) > 1;
;
/****** Object:  Table Salaries    Script Date: 2/26/2026 10:12:25 PM ******/
;
;
CREATE TABLE Salaries(
	yearID smallint NOT NULL,
	teamID varchar(4) NOT NULL,
	lgID varchar(3) NOT NULL,
	playerID varchar(20) NOT NULL,
	salary bigint NULL
)
;
;
/****** Object:  Index CX_Salaries_player_year_team    Script Date: 2/26/2026 10:12:25 PM ******/
CREATE INDEX CX_Salaries_player_year_team ON Salaries
(
	playerID ASC,
	yearID ASC,
	teamID ASC
)
;
/****** Object:  View vw_Duplicate_Salaries    Script Date: 2/26/2026 10:12:25 PM ******/
;
;
-- Salaries: (yearID, teamID, lgID, playerID)
CREATE   VIEW vw_Duplicate_Salaries AS
SELECT yearID, teamID, lgID, playerID, COUNT(*) AS dup_count
FROM Salaries
GROUP BY yearID, teamID, lgID, playerID
HAVING COUNT(*) > 1;
;
/****** Object:  Table Schools    Script Date: 2/26/2026 10:12:25 PM ******/
;
;
CREATE TABLE Schools(
	schoolID varchar(20) NOT NULL,
	name_full varchar(255) NULL,
	city varchar(100) NULL,
	state varchar(50) NULL,
	country varchar(50) NULL
)
;
;
/****** Object:  Index CX_Schools_schoolID    Script Date: 2/26/2026 10:12:25 PM ******/
CREATE INDEX CX_Schools_schoolID ON Schools
(
	schoolID ASC
)
;
/****** Object:  View vw_Duplicate_Schools    Script Date: 2/26/2026 10:12:25 PM ******/
;
;
-- Schools: (schoolID)
CREATE   VIEW vw_Duplicate_Schools AS
SELECT schoolID, COUNT(*) AS dup_count
FROM Schools
GROUP BY schoolID
HAVING COUNT(*) > 1;
;
/****** Object:  Table HomeGames    Script Date: 2/26/2026 10:12:25 PM ******/
;
;
CREATE TABLE HomeGames(
	yearkey integer NULL,
	leaguekey varchar(3) NULL,
	teamkey varchar(4) NULL,
	parkkey varchar(20) NULL,
	spanfirst varchar(10) NULL,
	spanlast varchar(10) NULL,
	games smallint NULL,
	openings smallint NULL,
	attendance integer NULL
)
;
;
/****** Object:  Index CX_HomeGames_year_team_park    Script Date: 2/26/2026 10:12:25 PM ******/
CREATE INDEX CX_HomeGames_year_team_park ON HomeGames
(
	yearkey ASC,
	teamkey ASC,
	parkkey ASC
)
;
/****** Object:  View vw_Duplicate_HomeGames    Script Date: 2/26/2026 10:12:25 PM ******/
;
;
-- HomeGames: (yearkey, leaguekey, teamkey, parkkey)
CREATE   VIEW vw_Duplicate_HomeGames AS
SELECT yearkey, leaguekey, teamkey, parkkey, COUNT(*) AS dup_count
FROM HomeGames
GROUP BY yearkey, leaguekey, teamkey, parkkey
HAVING COUNT(*) > 1;
;
/****** Object:  Table People    Script Date: 2/26/2026 10:12:25 PM ******/
;
;
CREATE TABLE People(
	ID integer NOT NULL,
	playerID varchar(20) NOT NULL,
	birthYear integer NULL,
	birthMonth integer NULL,
	birthDay integer NULL,
	birthCity varchar(100) NULL,
	birthCountry varchar(50) NULL,
	birthState varchar(50) NULL,
	deathYear integer NULL,
	deathMonth integer NULL,
	deathDay integer NULL,
	deathCountry varchar(50) NULL,
	deathState varchar(50) NULL,
	deathCity varchar(100) NULL,
	nameFirst varchar(100) NULL,
	nameLast varchar(100) NULL,
	nameGiven varchar(100) NULL,
	weight varchar(10) NULL,
	height varchar(10) NULL,
	bats varchar(10) NULL,
	throws varchar(10) NULL,
	debut varchar(20) NULL,
	bbrefID varchar(20) NULL,
	finalGame varchar(20) NULL,
	retroID varchar(20) NULL
)
;
;
/****** Object:  Index CX_People_playerID    Script Date: 2/26/2026 10:12:25 PM ******/
CREATE INDEX CX_People_playerID ON People
(
	playerID ASC
)
;
/****** Object:  View vw_Duplicate_People    Script Date: 2/26/2026 10:12:25 PM ******/
;
;
-- People: playerID should be unique
CREATE   VIEW vw_Duplicate_People AS
SELECT playerID, COUNT(*) AS dup_count
FROM People
GROUP BY playerID
HAVING COUNT(*) > 1;
;
/****** Object:  Table Teams    Script Date: 2/26/2026 10:12:25 PM ******/
;
;
CREATE TABLE Teams(
	yearID smallint NOT NULL,
	lgID varchar(3) NOT NULL,
	teamID varchar(4) NOT NULL,
	franchID varchar(4) NULL,
	divID varchar(2) NULL,
	Rank smallint NULL,
	G smallint NULL,
	Ghome smallint NULL,
	W smallint NULL,
	L smallint NULL,
	DivWin varchar(1) NULL,
	WCWin varchar(1) NULL,
	LgWin varchar(1) NULL,
	WSWin varchar(1) NULL,
	R smallint NULL,
	AB smallint NULL,
	H smallint NULL,
	"2B" smallint NULL,
	"3B" smallint NULL,
	HR smallint NULL,
	BB smallint NULL,
	SO smallint NULL,
	SB smallint NULL,
	CS smallint NULL,
	HBP smallint NULL,
	SF smallint NULL,
	RA smallint NULL,
	ER smallint NULL,
	ERA double precision NULL,
	CG smallint NULL,
	SHO smallint NULL,
	SV smallint NULL,
	IPouts smallint NULL,
	HA smallint NULL,
	HRA smallint NULL,
	BBA smallint NULL,
	SOA smallint NULL,
	E smallint NULL,
	DP smallint NULL,
	FP double precision NULL,
	name varchar(100) NULL,
	park varchar(255) NULL,
	attendance integer NULL,
	BPF smallint NULL,
	PPF smallint NULL,
	teamIDBR varchar(4) NULL,
	teamIDlahman45 varchar(4) NULL,
	teamIDretro varchar(4) NULL
)
;
;
/****** Object:  Index CX_Teams_year_team    Script Date: 2/26/2026 10:12:25 PM ******/
CREATE INDEX CX_Teams_year_team ON Teams
(
	yearID ASC,
	teamID ASC
)
;
/****** Object:  View vw_Duplicate_Teams    Script Date: 2/26/2026 10:12:25 PM ******/
;
;
-- Teams: (yearID, lgID, teamID)
CREATE   VIEW vw_Duplicate_Teams AS
SELECT yearID, lgID, teamID, COUNT(*) AS dup_count
FROM Teams
GROUP BY yearID, lgID, teamID
HAVING COUNT(*) > 1;
;
/****** Object:  Table Batting    Script Date: 2/26/2026 10:12:25 PM ******/
;
;
CREATE TABLE Batting(
	playerID varchar(20) NOT NULL,
	yearID smallint NOT NULL,
	stint smallint NOT NULL,
	teamID varchar(4) NULL,
	lgID varchar(3) NULL,
	G smallint NULL,
	AB smallint NULL,
	R smallint NULL,
	H smallint NULL,
	"2B" smallint NULL,
	"3B" smallint NULL,
	HR smallint NULL,
	RBI smallint NULL,
	SB smallint NULL,
	CS smallint NULL,
	BB smallint NULL,
	SO smallint NULL,
	IBB smallint NULL,
	HBP smallint NULL,
	SH smallint NULL,
	SF smallint NULL,
	GIDP smallint NULL
)
;
;
/****** Object:  Index CX_Batting_player_year_stint    Script Date: 2/26/2026 10:12:25 PM ******/
CREATE INDEX CX_Batting_player_year_stint ON Batting
(
	playerID ASC,
	yearID ASC,
	stint ASC
)
;
/****** Object:  View vw_Duplicate_Batting    Script Date: 2/26/2026 10:12:25 PM ******/
;
;
-- Batting: (playerID, yearID, stint, teamID)
CREATE   VIEW vw_Duplicate_Batting AS
SELECT playerID, yearID, stint, teamID, COUNT(*) AS dup_count
FROM Batting
GROUP BY playerID, yearID, stint, teamID
HAVING COUNT(*) > 1;
;
/****** Object:  Table Pitching    Script Date: 2/26/2026 10:12:25 PM ******/
;
;
CREATE TABLE Pitching(
	playerID varchar(20) NOT NULL,
	yearID smallint NOT NULL,
	stint smallint NOT NULL,
	teamID varchar(4) NULL,
	lgID varchar(3) NULL,
	W smallint NULL,
	L smallint NULL,
	G smallint NULL,
	GS smallint NULL,
	CG smallint NULL,
	SHO smallint NULL,
	SV smallint NULL,
	IPouts smallint NULL,
	H smallint NULL,
	ER smallint NULL,
	HR smallint NULL,
	BB smallint NULL,
	SO smallint NULL,
	BAOpp double precision NULL,
	ERA double precision NULL,
	IBB smallint NULL,
	WP smallint NULL,
	HBP smallint NULL,
	BK smallint NULL,
	BFP smallint NULL,
	GF smallint NULL,
	R smallint NULL,
	SH smallint NULL,
	SF smallint NULL,
	GIDP smallint NULL
)
;
;
/****** Object:  Index CX_Pitching_player_year_stint    Script Date: 2/26/2026 10:12:25 PM ******/
CREATE INDEX CX_Pitching_player_year_stint ON Pitching
(
	playerID ASC,
	yearID ASC,
	stint ASC
)
;
/****** Object:  View vw_Duplicate_Pitching    Script Date: 2/26/2026 10:12:25 PM ******/
;
;
-- Pitching: (playerID, yearID, stint, teamID)
CREATE   VIEW vw_Duplicate_Pitching AS
SELECT playerID, yearID, stint, teamID, COUNT(*) AS dup_count
FROM Pitching
GROUP BY playerID, yearID, stint, teamID
HAVING COUNT(*) > 1;
;
/****** Object:  Table Fielding    Script Date: 2/26/2026 10:12:25 PM ******/
;
;
CREATE TABLE Fielding(
	playerID varchar(20) NOT NULL,
	yearID smallint NOT NULL,
	stint smallint NOT NULL,
	teamID varchar(4) NULL,
	lgID varchar(3) NULL,
	POS varchar(2) NOT NULL,
	G smallint NULL,
	GS smallint NULL,
	InnOuts smallint NULL,
	PO smallint NULL,
	A smallint NULL,
	E smallint NULL,
	DP smallint NULL,
	PB smallint NULL,
	WP smallint NULL,
	SB smallint NULL,
	CS smallint NULL,
	ZR double precision NULL
)
;
;
/****** Object:  Index CX_Fielding_player_year_stint_pos    Script Date: 2/26/2026 10:12:25 PM ******/
CREATE INDEX CX_Fielding_player_year_stint_pos ON Fielding
(
	playerID ASC,
	yearID ASC,
	stint ASC,
	POS ASC
)
;
/****** Object:  View vw_Duplicate_Fielding    Script Date: 2/26/2026 10:12:25 PM ******/
;
;
-- Fielding: (playerID, yearID, stint, teamID, Pos)
CREATE   VIEW vw_Duplicate_Fielding AS
SELECT playerID, yearID, stint, teamID, Pos, COUNT(*) AS dup_count
FROM Fielding
GROUP BY playerID, yearID, stint, teamID, Pos
HAVING COUNT(*) > 1;
;
/****** Object:  Table FieldingOF    Script Date: 2/26/2026 10:12:25 PM ******/
;
;
CREATE TABLE FieldingOF(
	playerID varchar(20) NOT NULL,
	yearID smallint NOT NULL,
	stint smallint NOT NULL,
	Glf smallint NULL,
	Gcf smallint NULL,
	Grf smallint NULL
)
;
;
/****** Object:  Index CX_FieldingOF_player_year_stint    Script Date: 2/26/2026 10:12:25 PM ******/
CREATE INDEX CX_FieldingOF_player_year_stint ON FieldingOF
(
	playerID ASC,
	yearID ASC,
	stint ASC
)
;
/****** Object:  View vw_Duplicate_FieldingOF    Script Date: 2/26/2026 10:12:25 PM ******/
;
;
-- FieldingOF: (playerID, yearID, stint)
CREATE   VIEW vw_Duplicate_FieldingOF AS
SELECT playerID, yearID, stint, COUNT(*) AS dup_count
FROM FieldingOF
GROUP BY playerID, yearID, stint
HAVING COUNT(*) > 1;
;
/****** Object:  Table FieldingOFsplit    Script Date: 2/26/2026 10:12:25 PM ******/
;
;
CREATE TABLE FieldingOFsplit(
	playerID varchar(20) NOT NULL,
	yearID smallint NOT NULL,
	stint smallint NOT NULL,
	teamID varchar(4) NULL,
	lgID varchar(3) NULL,
	POS varchar(2) NOT NULL,
	G smallint NULL,
	GS smallint NULL,
	InnOuts smallint NULL,
	PO smallint NULL,
	A smallint NULL,
	E smallint NULL,
	DP smallint NULL,
	PB smallint NULL,
	WP smallint NULL,
	SB smallint NULL,
	CS smallint NULL,
	ZR double precision NULL
)
;
;
/****** Object:  Index CX_FieldingOFsplit_player_year_stint_pos    Script Date: 2/26/2026 10:12:25 PM ******/
CREATE INDEX CX_FieldingOFsplit_player_year_stint_pos ON FieldingOFsplit
(
	playerID ASC,
	yearID ASC,
	stint ASC,
	POS ASC
)
;
/****** Object:  View vw_Duplicate_FieldingOFsplit    Script Date: 2/26/2026 10:12:25 PM ******/
;
;
-- FieldingOFsplit: (playerID, yearID, stint, teamID, Pos)
CREATE   VIEW vw_Duplicate_FieldingOFsplit AS
SELECT playerID, yearID, stint, teamID, Pos, COUNT(*) AS dup_count
FROM FieldingOFsplit
GROUP BY playerID, yearID, stint, teamID, Pos
HAVING COUNT(*) > 1;
;
/****** Object:  Table Appearances    Script Date: 2/26/2026 10:12:25 PM ******/
;
;
CREATE TABLE Appearances(
	yearID smallint NOT NULL,
	teamID varchar(4) NOT NULL,
	lgID varchar(3) NULL,
	playerID varchar(20) NOT NULL,
	G_all smallint NULL,
	GS smallint NULL,
	G_batting smallint NULL,
	G_defense smallint NULL,
	G_p smallint NULL,
	G_c smallint NULL,
	G_1b smallint NULL,
	G_2b smallint NULL,
	G_3b smallint NULL,
	G_ss smallint NULL,
	G_lf smallint NULL,
	G_cf smallint NULL,
	G_rf smallint NULL,
	G_of smallint NULL,
	G_dh smallint NULL,
	G_ph smallint NULL,
	G_pr smallint NULL
)
;
;
/****** Object:  Index CX_Appearances_player_year_team    Script Date: 2/26/2026 10:12:25 PM ******/
CREATE INDEX CX_Appearances_player_year_team ON Appearances
(
	playerID ASC,
	yearID ASC,
	teamID ASC
)
;
/****** Object:  View vw_Duplicate_Appearances    Script Date: 2/26/2026 10:12:25 PM ******/
;
;
-- Appearances: (yearID, teamID, playerID)
CREATE   VIEW vw_Duplicate_Appearances AS
SELECT yearID, teamID, playerID, COUNT(*) AS dup_count
FROM Appearances
GROUP BY yearID, teamID, playerID
HAVING COUNT(*) > 1;
;
/****** Object:  Table Managers    Script Date: 2/26/2026 10:12:25 PM ******/
;
;
CREATE TABLE Managers(
	playerID varchar(20) NULL,
	yearID smallint NOT NULL,
	teamID varchar(4) NOT NULL,
	lgID varchar(3) NULL,
	inseason smallint NOT NULL,
	G smallint NULL,
	W smallint NULL,
	L smallint NULL,
	rank smallint NULL,
	plyrMgr varchar(1) NULL
)
;
;
/****** Object:  Index CX_Managers_year_team_inseason    Script Date: 2/26/2026 10:12:25 PM ******/
CREATE INDEX CX_Managers_year_team_inseason ON Managers
(
	yearID ASC,
	teamID ASC,
	inseason ASC
)
;
/****** Object:  View vw_Duplicate_Managers    Script Date: 2/26/2026 10:12:25 PM ******/
;
;
-- Managers: (playerID, yearID, teamID, inseason)
CREATE   VIEW vw_Duplicate_Managers AS
SELECT playerID, yearID, teamID, inseason, COUNT(*) AS dup_count
FROM Managers
GROUP BY playerID, yearID, teamID, inseason
HAVING COUNT(*) > 1;
;
/****** Object:  Table AllstarFull    Script Date: 2/26/2026 10:12:25 PM ******/
;
;
CREATE TABLE AllstarFull(
	playerID varchar(20) NULL,
	yearID smallint NULL,
	gameNum smallint NULL,
	gameID varchar(20) NULL,
	teamID varchar(4) NULL,
	lgID varchar(3) NULL,
	GP smallint NULL,
	startingPos varchar(10) NULL
)
;
;
/****** Object:  Index CX_AllstarFull_player_year_game    Script Date: 2/26/2026 10:12:25 PM ******/
CREATE INDEX CX_AllstarFull_player_year_game ON AllstarFull
(
	playerID ASC,
	yearID ASC,
	gameID ASC
)
;
/****** Object:  View vw_Duplicate_AllStarFull    Script Date: 2/26/2026 10:12:25 PM ******/
;
;
CREATE   VIEW vw_Duplicate_AllStarFull AS
SELECT playerID, yearID, lgID, COALESCE(gameNum,0) AS gameNum, COUNT(*) AS dup_count
FROM AllStarFull
GROUP BY playerID, yearID, lgID, COALESCE(gameNum,0)
HAVING COUNT(*) > 1;
;
/****** Object:  Table BattingPost    Script Date: 2/26/2026 10:12:25 PM ******/
;
;
CREATE TABLE BattingPost(
	yearID smallint NOT NULL,
	round varchar(10) NOT NULL,
	playerID varchar(20) NOT NULL,
	teamID varchar(4) NULL,
	lgID varchar(3) NULL,
	G smallint NULL,
	AB smallint NULL,
	R smallint NULL,
	H smallint NULL,
	"2B" smallint NULL,
	"3B" smallint NULL,
	HR smallint NULL,
	RBI smallint NULL,
	SB smallint NULL,
	CS smallint NULL,
	BB smallint NULL,
	SO smallint NULL,
	IBB smallint NULL,
	HBP smallint NULL,
	SH smallint NULL,
	SF smallint NULL,
	GIDP smallint NULL
)
;
;
/****** Object:  Index CX_BattingPost_year_round_player    Script Date: 2/26/2026 10:12:25 PM ******/
CREATE INDEX CX_BattingPost_year_round_player ON BattingPost
(
	yearID ASC,
	round ASC,
	playerID ASC
)
;
/****** Object:  View vw_Duplicate_BattingPost    Script Date: 2/26/2026 10:12:25 PM ******/
;
;
-- BattingPost: (playerID, yearID, teamID, round)
CREATE   VIEW vw_Duplicate_BattingPost AS
SELECT playerID, yearID, teamID, round, COUNT(*) AS dup_count
FROM BattingPost
GROUP BY playerID, yearID, teamID, round
HAVING COUNT(*) > 1;
;
/****** Object:  View vw_Duplicate_All    Script Date: 2/26/2026 10:12:25 PM ******/
;
;
CREATE     VIEW vw_Duplicate_All AS
SELECT 'People' AS table_name, COUNT(*) AS dup_groups, 'SELECT * FROM vw_Duplicate_People' AS query FROM vw_Duplicate_People
UNION ALL SELECT 'Teams', COUNT(*), 'SELECT * FROM vw_Duplicate_Teams' FROM vw_Duplicate_Teams
UNION ALL SELECT 'Batting', COUNT(*), 'SELECT * FROM vw_Duplicate_Batting' FROM vw_Duplicate_Batting
UNION ALL SELECT 'Pitching', COUNT(*), 'SELECT * FROM vw_Duplicate_Pitching' FROM vw_Duplicate_Pitching
UNION ALL SELECT 'Fielding', COUNT(*), 'SELECT * FROM vw_Duplicate_Fielding' FROM vw_Duplicate_Fielding
UNION ALL SELECT 'FieldingOF', COUNT(*), 'SELECT * FROM vw_Duplicate_FieldingOF' FROM vw_Duplicate_FieldingOF
UNION ALL SELECT 'FieldingOFsplit', COUNT(*), 'SELECT * FROM vw_Duplicate_FieldingOFsplit' FROM vw_Duplicate_FieldingOFsplit
UNION ALL SELECT 'Appearances', COUNT(*), 'SELECT * FROM vw_Duplicate_Appearances' FROM vw_Duplicate_Appearances
UNION ALL SELECT 'Managers', COUNT(*), 'SELECT * FROM vw_Duplicate_Managers' FROM vw_Duplicate_Managers
UNION ALL SELECT 'AllStarFull', COUNT(*), 'SELECT * FROM vw_Duplicate_AllStarFull' FROM vw_Duplicate_AllStarFull
UNION ALL SELECT 'BattingPost', COUNT(*), 'SELECT * FROM vw_Duplicate_BattingPost' FROM vw_Duplicate_BattingPost
UNION ALL SELECT 'PitchingPost', COUNT(*), 'SELECT * FROM vw_Duplicate_PitchingPost' FROM vw_Duplicate_PitchingPost
UNION ALL SELECT 'FieldingPost', COUNT(*), 'SELECT * FROM vw_Duplicate_FieldingPost' FROM vw_Duplicate_FieldingPost
UNION ALL SELECT 'SeriesPost', COUNT(*), 'SELECT * FROM vw_Duplicate_SeriesPost' FROM vw_Duplicate_SeriesPost
UNION ALL SELECT 'ManagersHalf', COUNT(*), 'SELECT * FROM vw_Duplicate_ManagersHalf' FROM vw_Duplicate_ManagersHalf
UNION ALL SELECT 'TeamsHalf', COUNT(*), 'SELECT * FROM vw_Duplicate_TeamsHalf' FROM vw_Duplicate_TeamsHalf
UNION ALL SELECT 'AwardsManagers', COUNT(*), 'SELECT * FROM vw_Duplicate_AwardsManagers' FROM vw_Duplicate_AwardsManagers
UNION ALL SELECT 'AwardsPlayers', COUNT(*), 'SELECT * FROM vw_Duplicate_AwardsPlayers' FROM vw_Duplicate_AwardsPlayers
UNION ALL SELECT 'AwardsShareManagers', COUNT(*), 'SELECT * FROM vw_Duplicate_AwardsShareManagers' FROM vw_Duplicate_AwardsShareManagers
UNION ALL SELECT 'AwardsSharePlayers', COUNT(*), 'SELECT * FROM vw_Duplicate_AwardsSharePlayers' FROM vw_Duplicate_AwardsSharePlayers
UNION ALL SELECT 'HallOfFame', COUNT(*), 'SELECT * FROM vw_Duplicate_HallOfFame' FROM vw_Duplicate_HallOfFame
UNION ALL SELECT 'CollegePlaying', COUNT(*), 'SELECT * FROM vw_Duplicate_CollegePlaying' FROM vw_Duplicate_CollegePlaying
UNION ALL SELECT 'Salaries', COUNT(*), 'SELECT * FROM vw_Duplicate_Salaries' FROM vw_Duplicate_Salaries
UNION ALL SELECT 'HomeGames', COUNT(*), 'SELECT * FROM vw_Duplicate_HomeGames' FROM vw_Duplicate_HomeGames
;
/****** Object:  View vw_Errors_Chrono_BirthDeath    Script Date: 2/26/2026 10:12:25 PM ******/
;
;
-- Birth/death chronological issues
CREATE   VIEW vw_Errors_Chrono_BirthDeath AS
SELECT playerID, birthYear, deathYear
FROM People
WHERE deathYear IS NOT NULL AND birthYear IS NOT NULL
  AND deathYear < birthYear;
;
/****** Object:  View vw_Errors_Chrono_DebutFinal    Script Date: 2/26/2026 10:12:25 PM ******/
;
;
-- Debut occurs after finalGame (reversed)
CREATE   VIEW vw_Errors_Chrono_DebutFinal AS
SELECT playerID, debut, finalGame
FROM People
WHERE debut IS NOT NULL AND finalGame IS NOT NULL
  AND debut > finalGame;
;
/****** Object:  View vw_Errors_Chrono_CollegeAfterDeath    Script Date: 2/26/2026 10:12:25 PM ******/
;
;
-- CollegePlaying after death year
CREATE   VIEW vw_Errors_Chrono_CollegeAfterDeath AS
SELECT c.playerID, c.yearID AS collegeYear, p.deathYear
FROM CollegePlaying c
JOIN People p ON p.playerID = c.playerID
WHERE p.deathYear IS NOT NULL AND c.yearID > p.deathYear;
;
/****** Object:  View vw_Errors_Chrono_StatsBeforeBirth    Script Date: 2/26/2026 10:12:25 PM ******/
;
;
-- Stats before player’s birth year
CREATE   VIEW vw_Errors_Chrono_StatsBeforeBirth AS
SELECT b.playerID, b.yearID, p.birthYear
FROM Batting b
JOIN People p ON p.playerID = b.playerID
WHERE p.birthYear IS NOT NULL AND b.yearID < p.birthYear;
;
/****** Object:  View vw_Errors_Chrono    Script Date: 2/26/2026 10:12:25 PM ******/
;
;
-- Chronological rollup
CREATE     VIEW vw_Errors_Chrono AS
SELECT 'Birth/Death' AS check_type, COUNT(*) AS issue_count, 'SELECT * FROM vw_Errors_Missing_PlayerNames' AS query FROM vw_Errors_Chrono_BirthDeath
UNION ALL
SELECT 'Debut > Final', COUNT(*), 'SELECT * FROM vw_Errors_Chrono_DebutFinal' FROM vw_Errors_Chrono_DebutFinal
UNION ALL
SELECT 'CollegeAfterDeath', COUNT(*), 'SELECT * FROM vw_Errors_Chrono_CollegeAfterDeath' FROM vw_Errors_Chrono_CollegeAfterDeath
UNION ALL
SELECT 'StatsBeforeBirth', COUNT(*), 'SELECT * FROM vw_Errors_Chrono_StatsBeforeBirth' FROM vw_Errors_Chrono_StatsBeforeBirth;
;
/****** Object:  View vw_Errors_Stats_Negative_Batting    Script Date: 2/26/2026 10:12:25 PM ******/
;
;
-- Negative batting stats
CREATE   VIEW vw_Errors_Stats_Negative_Batting AS
SELECT playerID, yearID, teamID, G, AB, H
FROM Batting
WHERE G < 0 OR AB < 0 OR H < 0;
;
/****** Object:  View vw_Errors_Stats_Negative_Pitching    Script Date: 2/26/2026 10:12:25 PM ******/
;
;
-- Negative pitching stats
CREATE   VIEW vw_Errors_Stats_Negative_Pitching AS
SELECT playerID, yearID, teamID, W, L, G, SO, BB
FROM Pitching
WHERE W < 0 OR L < 0 OR G < 0 OR SO < 0 OR BB < 0;
;
/****** Object:  View vw_Errors_Stats_Managers_WLG    Script Date: 2/26/2026 10:12:25 PM ******/
;
;
-- Managers: W + L must equal G (roughly)
CREATE     VIEW vw_Errors_Stats_Managers_WLG AS
SELECT playerID, yearID, teamID, W, L, G, G - (W + L) AS Diff
FROM Managers
WHERE W IS NOT NULL AND L IS NOT NULL AND G IS NOT NULL
  AND W + L <> G AND yearID > 2016;
;
/****** Object:  View vw_Errors_Stats_Team_WinLoss_Imbalance    Script Date: 2/26/2026 10:12:25 PM ******/
;
;
CREATE VIEW vw_errors_stats_team_winloss_imbalance AS
SELECT
  yearid,
  CASE lgid
    WHEN 'AL' THEN 'MLB'
    WHEN 'NL' THEN 'MLB'
    ELSE lgid
  END AS lgid,
  SUM(w) AS totalw,
  SUM(l) AS totall
FROM teams
WHERE lgid NOT IN ('EAS','WES','IND')
GROUP BY
  yearid,
  CASE lgid
    WHEN 'AL' THEN 'MLB'
    WHEN 'NL' THEN 'MLB'
    ELSE lgid
  END
HAVING SUM(w) <> SUM(l)
   AND COUNT(*) % 2 <> 1;
;
/****** Object:  View vw_Errors_Stats_Team_FP_Invalid    Script Date: 2/26/2026 10:12:25 PM ******/
;
;
-- Fielding: FP outside 0–1 range
CREATE   VIEW vw_Errors_Stats_Team_FP_Invalid AS
SELECT yearID, teamID, FP
FROM Teams
WHERE FP < 0 OR FP > 1;
;
/****** Object:  View vw_Errors_Stats_Salary_Invalid    Script Date: 2/26/2026 10:12:25 PM ******/
;
;
-- Salaries: negative or zero (invalid)
CREATE   VIEW vw_Errors_Stats_Salary_Invalid AS
SELECT playerID, yearID, teamID, salary
FROM Salaries
WHERE salary <= 0;
;
/****** Object:  View vw_Errors_Stats    Script Date: 2/26/2026 10:12:25 PM ******/
;
;
-- Stats sanity rollup
CREATE     VIEW vw_Errors_Stats AS
SELECT 'Negative_Batting' AS check_type, COUNT(*) AS issue_count, 'SELECT * FROM vw_Errors_Stats_Negative_Batting' AS query FROM vw_Errors_Stats_Negative_Batting
UNION ALL SELECT 'Negative_Pitching', COUNT(*), 'SELECT * FROM vw_Errors_Stats_Negative_Pitching' FROM vw_Errors_Stats_Negative_Pitching
UNION ALL SELECT 'Manager_W+L<>G', COUNT(*), 'SELECT * FROM vw_Errors_Stats_Managers_WLG' FROM vw_Errors_Stats_Managers_WLG
UNION ALL SELECT 'League_WinLoss_Imbalance', COUNT(*), 'SELECT * FROM vw_Errors_Stats_Team_WinLoss_Imbalance' FROM vw_Errors_Stats_Team_WinLoss_Imbalance
UNION ALL SELECT 'Team_FP_Invalid', COUNT(*), 'SELECT * FROM vw_Errors_Stats_Team_FP_Invalid' FROM vw_Errors_Stats_Team_FP_Invalid
UNION ALL SELECT 'Salary_Invalid', COUNT(*), 'SELECT * FROM vw_Errors_Stats_Salary_Invalid' FROM vw_Errors_Stats_Salary_Invalid;
;
/****** Object:  View vw_Errors_Missing_PlayerNames    Script Date: 2/26/2026 10:12:25 PM ******/
;
;
-- Missing player names
CREATE   VIEW vw_Errors_Missing_PlayerNames AS
SELECT playerID
FROM People
WHERE nameLast IS NULL;
;
/****** Object:  View vw_Errors_Missing_TeamFranchise    Script Date: 2/26/2026 10:12:25 PM ******/
;
;
-- Missing team franchise ID
CREATE   VIEW vw_Errors_Missing_TeamFranchise AS
SELECT yearID, teamID
FROM Teams
WHERE franchID IS NULL;
;
/****** Object:  Table Parks    Script Date: 2/26/2026 10:12:25 PM ******/
;
;
CREATE TABLE Parks(
	ID integer NOT NULL,
	parkalias varchar(512) NULL,
	parkkey varchar(20) NULL,
	parkname varchar(255) NULL,
	city varchar(100) NULL,
	state varchar(50) NULL,
	country varchar(50) NULL
)
;
/****** Object:  Index CX_Parks_ID    Script Date: 2/26/2026 10:12:25 PM ******/
CREATE INDEX CX_Parks_ID ON Parks
(
	ID ASC
)
;
/****** Object:  View vw_Errors_Missing_ParkLocation    Script Date: 2/26/2026 10:12:25 PM ******/
;
;
CREATE   VIEW vw_Errors_Missing_ParkLocation AS
SELECT parkkey, parkname
FROM Parks
WHERE city IS NULL OR (state IS NULL AND country <> 'PR');
;
/****** Object:  View vw_Errors_Missing_SchoolLocation    Script Date: 2/26/2026 10:12:25 PM ******/
;
;
-- Missing school location
CREATE   VIEW vw_Errors_Missing_SchoolLocation AS
SELECT schoolID, name_full
FROM Schools
WHERE City IS NULL OR State IS NULL;
;
/****** Object:  View vw_Errors_Missing    Script Date: 2/26/2026 10:12:25 PM ******/
;
;
-- Coverage rollup
CREATE     VIEW vw_Errors_Missing AS
SELECT 'Missing_PlayerNames' AS check_type, COUNT(*) AS issue_count, 'SELECT * FROM vw_Errors_Missing_PlayerNames' AS query FROM vw_Errors_Missing_PlayerNames
UNION ALL SELECT 'Missing_TeamFranchise', COUNT(*), 'SELECT * FROM vw_Errors_Missing_TeamFranchise' FROM vw_Errors_Missing_TeamFranchise
UNION ALL SELECT 'Missing_ParkLocatio', COUNT(*), 'SELECT * FROM vw_Errors_Missing_ParkLocatio' FROM vw_Errors_Missing_ParkLocation
UNION ALL SELECT 'Missing_SchoolLocatio', COUNT(*), 'SELECT * FROM vw_Errors_Missing_SchoolLocatio' FROM vw_Errors_Missing_SchoolLocation
;
/****** Object:  View vw_Orphan_Player_AwardsShareManagers    Script Date: 2/26/2026 10:12:25 PM ******/
;
;
CREATE   VIEW vw_Orphan_Player_AwardsShareManagers AS
SELECT DISTINCT 'AwardsShareManagers' AS table_name, a.playerID, a.yearID, NULL AS teamID, a.lgID
FROM AwardsShareManagers a
WHERE NOT EXISTS (SELECT 1 FROM People x WHERE x.playerID = a.playerID);
;
/****** Object:  View vw_Orphan_Player_AwardsSharePlayers    Script Date: 2/26/2026 10:12:25 PM ******/
;
;
CREATE   VIEW vw_Orphan_Player_AwardsSharePlayers AS
SELECT DISTINCT 'AwardsSharePlayers' AS table_name, a.playerID, a.yearID, NULL AS teamID, a.lgID
FROM AwardsSharePlayers a
WHERE NOT EXISTS (SELECT 1 FROM People x WHERE x.playerID = a.playerID);
;
/****** Object:  View vw_Orphan_Player_HallOfFame    Script Date: 2/26/2026 10:12:25 PM ******/
;
;
-- HallOfFame
CREATE   VIEW vw_Orphan_Player_HallOfFame AS
SELECT DISTINCT 'HallOfFame' AS table_name, h.playerID, h.yearID, NULL AS teamID, NULL AS lgID
FROM HallOfFame h
WHERE NOT EXISTS (SELECT 1 FROM People x WHERE x.playerID = h.playerID);
;
/****** Object:  View vw_Orphan_Player_CollegePlaying    Script Date: 2/26/2026 10:12:25 PM ******/
;
;
-- CollegePlaying (note: column is 'playerid' lowercase in your spec)
CREATE   VIEW vw_Orphan_Player_CollegePlaying AS
SELECT DISTINCT 'CollegePlaying' AS table_name, c.playerid AS playerID, c.yearID AS yearID, NULL AS teamID, NULL AS lgID
FROM CollegePlaying c
WHERE NOT EXISTS (SELECT 1 FROM People x WHERE x.playerID = c.playerid);
;
/****** Object:  View vw_Orphan_Player_Salaries    Script Date: 2/26/2026 10:12:25 PM ******/
;
;
-- Salaries
CREATE   VIEW vw_Orphan_Player_Salaries AS
SELECT DISTINCT 'Salaries' AS table_name, s.playerID, s.yearID, s.teamID, s.lgID
FROM Salaries s
WHERE NOT EXISTS (SELECT 1 FROM People x WHERE x.playerID = s.playerID);
;
/****** Object:  View vw_Orphan_Player_Batting    Script Date: 2/26/2026 10:12:25 PM ******/
;
;
-- Helper: consistent null/trim handling (optional; remove if you do't need it)
-- (If your IDs are clean, skip this UDF.)
-- CREATE OR ALTER FUNCTION _norm(@s varchar(50)) RETURNS varchar(50) AS
-- BEGIN RETURN LTRIM(RTRIM(@s)); END
-- GO

-- Batting
CREATE   VIEW vw_Orphan_Player_Batting AS
SELECT DISTINCT 'Batting' AS table_name, b.playerID, b.yearID, b.teamID, b.lgID
FROM Batting b
WHERE NOT EXISTS (SELECT 1 FROM People p WHERE p.playerID = b.playerID);
;
/****** Object:  View vw_Orphan_Player_Pitching    Script Date: 2/26/2026 10:12:25 PM ******/
;
;
-- Pitching
CREATE   VIEW vw_Orphan_Player_Pitching AS
SELECT DISTINCT 'Pitching' AS table_name, p.playerID, p.yearID, p.teamID, p.lgID
FROM Pitching p
WHERE NOT EXISTS (SELECT 1 FROM People x WHERE x.playerID = p.playerID);
;
/****** Object:  View vw_Orphan_Player_Fielding    Script Date: 2/26/2026 10:12:25 PM ******/
;
;
-- Fielding
CREATE   VIEW vw_Orphan_Player_Fielding AS
SELECT DISTINCT 'Fielding' AS table_name, f.playerID, f.yearID, f.teamID, f.lgID
FROM Fielding f
WHERE NOT EXISTS (SELECT 1 FROM People x WHERE x.playerID = f.playerID);
;
/****** Object:  View vw_Orphan_Player_FieldingOF    Script Date: 2/26/2026 10:12:25 PM ******/
;
;
-- FieldingOF
CREATE   VIEW vw_Orphan_Player_FieldingOF AS
SELECT DISTINCT 'FieldingOF' AS table_name, f.playerID, f.yearID, NULL AS teamID, NULL AS lgID
FROM FieldingOF f
WHERE NOT EXISTS (SELECT 1 FROM People x WHERE x.playerID = f.playerID);
;
/****** Object:  View vw_Orphan_Player_FieldingOFsplit    Script Date: 2/26/2026 10:12:25 PM ******/
;
;
-- FieldingOFsplit
CREATE   VIEW vw_Orphan_Player_FieldingOFsplit AS
SELECT DISTINCT 'FieldingOFsplit' AS table_name, f.playerID, f.yearID, f.teamID, f.lgID
FROM FieldingOFsplit f
WHERE NOT EXISTS (SELECT 1 FROM People x WHERE x.playerID = f.playerID);
;
/****** Object:  View vw_Orphan_Player_Appearances    Script Date: 2/26/2026 10:12:25 PM ******/
;
;
-- Appearances
CREATE   VIEW vw_Orphan_Player_Appearances AS
SELECT DISTINCT 'Appearances' AS table_name, a.playerID, a.yearID, a.teamID, a.lgID
FROM Appearances a
WHERE NOT EXISTS (SELECT 1 FROM People x WHERE x.playerID = a.playerID);
;
/****** Object:  View vw_Orphan_Player_Managers    Script Date: 2/26/2026 10:12:25 PM ******/
;
;
-- Managers
CREATE   VIEW vw_Orphan_Player_Managers AS
SELECT DISTINCT 'Managers' AS table_name, m.playerID, m.yearID, m.teamID, m.lgID
FROM Managers m
WHERE NOT EXISTS (SELECT 1 FROM People x WHERE x.playerID = m.playerID);
;
/****** Object:  View vw_Orphan_Player_AllStarFull    Script Date: 2/26/2026 10:12:25 PM ******/
;
;
-- AllStarFull
CREATE   VIEW vw_Orphan_Player_AllStarFull AS
SELECT DISTINCT 'AllStarFull' AS table_name, a.playerID, a.YearID AS yearID, a.teamID, a.lgID
FROM AllStarFull a
WHERE NOT EXISTS (SELECT 1 FROM People x WHERE x.playerID = a.playerID);
;
/****** Object:  View vw_Orphan_Player_BattingPost    Script Date: 2/26/2026 10:12:25 PM ******/
;
;
-- Postseason: BattingPost
CREATE   VIEW vw_Orphan_Player_BattingPost AS
SELECT DISTINCT 'BattingPost' AS table_name, b.playerID, b.yearID, b.teamID, b.lgID
FROM BattingPost b
WHERE NOT EXISTS (SELECT 1 FROM People x WHERE x.playerID = b.playerID);
;
/****** Object:  View vw_Orphan_Player_PitchingPost    Script Date: 2/26/2026 10:12:25 PM ******/
;
;
-- Postseason: PitchingPost
CREATE   VIEW vw_Orphan_Player_PitchingPost AS
SELECT DISTINCT 'PitchingPost' AS table_name, p.playerID, p.yearID, p.teamID, p.lgID
FROM PitchingPost p
WHERE NOT EXISTS (SELECT 1 FROM People x WHERE x.playerID = p.playerID);
;
/****** Object:  View vw_Orphan_Player_FieldingPost    Script Date: 2/26/2026 10:12:25 PM ******/
;
;
-- Postseason: FieldingPost
CREATE   VIEW vw_Orphan_Player_FieldingPost AS
SELECT DISTINCT 'FieldingPost' AS table_name, f.playerID, f.yearID, f.teamID, f.lgID
FROM FieldingPost f
WHERE NOT EXISTS (SELECT 1 FROM People x WHERE x.playerID = f.playerID);
;
/****** Object:  View vw_Orphan_Player_ManagersHalf    Script Date: 2/26/2026 10:12:25 PM ******/
;
;
-- ManagersHalf
CREATE   VIEW vw_Orphan_Player_ManagersHalf AS
SELECT DISTINCT 'ManagersHalf' AS table_name, m.playerID, m.yearID, m.teamID, m.lgID
FROM ManagersHalf m
WHERE NOT EXISTS (SELECT 1 FROM People x WHERE x.playerID = m.playerID);
;
/****** Object:  View vw_Orphan_Player_AwardsManagers    Script Date: 2/26/2026 10:12:25 PM ******/
;
;
-- Awards (Managers/Players & Share tables)
CREATE   VIEW vw_Orphan_Player_AwardsManagers AS
SELECT DISTINCT 'AwardsManagers' AS table_name, a.playerID, a.yearID, NULL AS teamID, a.lgID
FROM AwardsManagers a
WHERE NOT EXISTS (SELECT 1 FROM People x WHERE x.playerID = a.playerID);
;
/****** Object:  View vw_Orphan_Player_AwardsPlayers    Script Date: 2/26/2026 10:12:25 PM ******/
;
;
CREATE   VIEW vw_Orphan_Player_AwardsPlayers AS
SELECT DISTINCT 'AwardsPlayers' AS table_name, a.playerID, a.yearID, NULL AS teamID, a.lgID
FROM AwardsPlayers a
WHERE NOT EXISTS (SELECT 1 FROM People x WHERE x.playerID = a.playerID);
;
/****** Object:  View vw_Orphan_Player_All    Script Date: 2/26/2026 10:12:25 PM ******/
;
;
-- MASTER: all player orphans
CREATE   VIEW vw_Orphan_Player_All AS
SELECT * FROM vw_Orphan_Player_Batting UNION ALL
SELECT * FROM vw_Orphan_Player_Pitching UNION ALL
SELECT * FROM vw_Orphan_Player_Fielding UNION ALL
SELECT * FROM vw_Orphan_Player_FieldingOF UNION ALL
SELECT * FROM vw_Orphan_Player_FieldingOFsplit UNION ALL
SELECT * FROM vw_Orphan_Player_Appearances UNION ALL
SELECT * FROM vw_Orphan_Player_Managers UNION ALL
SELECT * FROM vw_Orphan_Player_AllStarFull UNION ALL
SELECT * FROM vw_Orphan_Player_BattingPost UNION ALL
SELECT * FROM vw_Orphan_Player_PitchingPost UNION ALL
SELECT * FROM vw_Orphan_Player_FieldingPost UNION ALL
SELECT * FROM vw_Orphan_Player_ManagersHalf UNION ALL
SELECT * FROM vw_Orphan_Player_AwardsManagers UNION ALL
SELECT * FROM vw_Orphan_Player_AwardsPlayers UNION ALL
SELECT * FROM vw_Orphan_Player_AwardsShareManagers UNION ALL
SELECT * FROM vw_Orphan_Player_AwardsSharePlayers UNION ALL
SELECT * FROM vw_Orphan_Player_HallOfFame UNION ALL
SELECT * FROM vw_Orphan_Player_CollegePlaying UNION ALL
SELECT * FROM vw_Orphan_Player_Salaries;
;
/****** Object:  View vw_Orphan_Team_Batting    Script Date: 2/26/2026 10:12:25 PM ******/
;
;
-- Batting
CREATE   VIEW vw_Orphan_Team_Batting AS
SELECT DISTINCT 'Batting' AS table_name, b.yearID, b.lgID, b.teamID
FROM Batting b
WHERE NOT EXISTS (
    SELECT 1 FROM Teams t
    WHERE t.yearID = b.yearID AND t.teamID = b.teamID AND t.lgID = b.lgID
);
;
/****** Object:  View vw_Orphan_Team_Pitching    Script Date: 2/26/2026 10:12:25 PM ******/
;
;
-- Pitching
CREATE   VIEW vw_Orphan_Team_Pitching AS
SELECT DISTINCT 'Pitching' AS table_name, p.yearID, p.lgID, p.teamID
FROM Pitching p
WHERE NOT EXISTS (
    SELECT 1 FROM Teams t
    WHERE t.yearID = p.yearID AND t.teamID = p.teamID AND t.lgID = p.lgID
);
;
/****** Object:  View vw_Orphan_Team_Fielding    Script Date: 2/26/2026 10:12:25 PM ******/
;
;
-- Fielding
CREATE   VIEW vw_Orphan_Team_Fielding AS
SELECT DISTINCT 'Fielding' AS table_name, f.yearID, f.lgID, f.teamID
FROM Fielding f
WHERE NOT EXISTS (
    SELECT 1 FROM Teams t
    WHERE t.yearID = f.yearID AND t.teamID = f.teamID AND t.lgID = f.lgID
);
;
/****** Object:  View vw_Orphan_Team_FieldingOFsplit    Script Date: 2/26/2026 10:12:25 PM ******/
;
;
-- FieldingOFsplit
CREATE   VIEW vw_Orphan_Team_FieldingOFsplit AS
SELECT DISTINCT 'FieldingOFsplit' AS table_name, f.yearID, f.lgID, f.teamID
FROM FieldingOFsplit f
WHERE NOT EXISTS (
    SELECT 1 FROM Teams t
    WHERE t.yearID = f.yearID AND t.teamID = f.teamID AND t.lgID = f.lgID
);
;
/****** Object:  View vw_Orphan_Team_Appearances    Script Date: 2/26/2026 10:12:25 PM ******/
;
;
-- Appearances
CREATE   VIEW vw_Orphan_Team_Appearances AS
SELECT DISTINCT 'Appearances' AS table_name, a.yearID, a.lgID, a.teamID
FROM Appearances a
WHERE NOT EXISTS (
    SELECT 1 FROM Teams t
    WHERE t.yearID = a.yearID AND t.teamID = a.teamID AND t.lgID = a.lgID
);
;
/****** Object:  View vw_Orphan_Team_Managers    Script Date: 2/26/2026 10:12:25 PM ******/
;
;
-- Managers
CREATE   VIEW vw_Orphan_Team_Managers AS
SELECT DISTINCT 'Managers' AS table_name, m.yearID, m.lgID, m.teamID
FROM Managers m
WHERE NOT EXISTS (
    SELECT 1 FROM Teams t
    WHERE t.yearID = m.yearID AND t.teamID = m.teamID AND t.lgID = m.lgID
);
;
/****** Object:  View vw_Orphan_Team_AllStarFull    Script Date: 2/26/2026 10:12:25 PM ******/
;
;
-- AllStarFull
CREATE   VIEW vw_Orphan_Team_AllStarFull AS
SELECT DISTINCT 'AllStarFull' AS table_name, a.YearID AS yearID, a.lgID, a.teamID
FROM AllStarFull a
WHERE NOT EXISTS (
    SELECT 1 FROM Teams t
    WHERE t.yearID = CASE WHEN a.yearID IN (1937,1939) AND a.lgID IN ('EAS','WES','NOS','SAS','NN','NNS') THEN t.yearID ELSE a.YearID END AND t.teamID = CASE WHEN a.yearID IN (1937,1939) AND a.teamID = 'SAS' THEN t.teamID ELSE a.teamID END AND t.lgID = CASE WHEN a.lgID IN ('EAS','WES','NOS','SAS','NN','NNS') THEN t.lgID ELSE a.lgID END
);
;
/****** Object:  View vw_Orphan_Team_BattingPost    Script Date: 2/26/2026 10:12:25 PM ******/
;
;
-- Postseason: BattingPost
CREATE   VIEW vw_Orphan_Team_BattingPost AS
SELECT DISTINCT 'BattingPost' AS table_name, b.yearID, b.lgID, b.teamID
FROM BattingPost b
WHERE NOT EXISTS (
    SELECT 1 FROM Teams t
    WHERE t.yearID = b.yearID AND t.teamID = b.teamID AND t.lgID = b.lgID
);
;
/****** Object:  View vw_Orphan_Team_PitchingPost    Script Date: 2/26/2026 10:12:25 PM ******/
;
;
-- Postseason: PitchingPost
CREATE   VIEW vw_Orphan_Team_PitchingPost AS
SELECT DISTINCT 'PitchingPost' AS table_name, p.yearID, p.lgID, p.teamID
FROM PitchingPost p
WHERE NOT EXISTS (
    SELECT 1 FROM Teams t
    WHERE t.yearID = p.yearID AND t.teamID = p.teamID AND t.lgID = p.lgID
);
;
/****** Object:  View vw_Orphan_Team_FieldingPost    Script Date: 2/26/2026 10:12:25 PM ******/
;
;
-- Postseason: FieldingPost
CREATE   VIEW vw_Orphan_Team_FieldingPost AS
SELECT DISTINCT 'FieldingPost' AS table_name, f.yearID, f.lgID, f.teamID
FROM FieldingPost f
WHERE NOT EXISTS (
    SELECT 1 FROM Teams t
    WHERE t.yearID = f.yearID AND t.teamID = f.teamID AND t.lgID = f.lgID
);
;
/****** Object:  View vw_Orphan_Team_ManagersHalf    Script Date: 2/26/2026 10:12:25 PM ******/
;
;
-- ManagersHalf
CREATE   VIEW vw_Orphan_Team_ManagersHalf AS
SELECT DISTINCT 'ManagersHalf' AS table_name, m.yearID, m.lgID, m.teamID
FROM ManagersHalf m
WHERE NOT EXISTS (
    SELECT 1 FROM Teams t
    WHERE t.yearID = m.yearID AND t.teamID = m.teamID AND t.lgID = m.lgID
);
;
/****** Object:  View vw_Orphan_Team_TeamsHalf    Script Date: 2/26/2026 10:12:25 PM ******/
;
;
-- TeamsHalf (self-consistency with Teams)
CREATE   VIEW vw_Orphan_Team_TeamsHalf AS
SELECT DISTINCT 'TeamsHalf' AS table_name, th.yearID, th.lgID, th.teamID
FROM TeamsHalf th
WHERE NOT EXISTS (
    SELECT 1 FROM Teams t
    WHERE t.yearID = th.yearID AND t.teamID = th.teamID AND t.lgID = th.lgID
);
;
/****** Object:  View vw_Orphan_Team_Salaries    Script Date: 2/26/2026 10:12:25 PM ******/
;
;
-- Salaries
CREATE   VIEW vw_Orphan_Team_Salaries AS
SELECT DISTINCT 'Salaries' AS table_name, s.yearID, s.lgID, s.teamID
FROM Salaries s
WHERE NOT EXISTS (
    SELECT 1 FROM Teams t
    WHERE t.yearID = s.yearID AND t.teamID = s.teamID AND t.lgID = s.lgID
);
;
/****** Object:  View vw_Orphan_Team_HomeGames    Script Date: 2/26/2026 10:12:25 PM ******/
;
;
-- HomeGames (maps *key columns to Teams)
CREATE   VIEW vw_Orphan_Team_HomeGames AS
SELECT DISTINCT 'HomeGames' AS table_name,
       h.yearkey AS yearID, h.leaguekey AS lgID, h.teamkey AS teamID
FROM HomeGames h
WHERE NOT EXISTS (
    SELECT 1 FROM Teams t
    WHERE t.yearID = h.yearkey AND t.teamID = h.teamkey AND t.lgID = h.leaguekey
);
;
/****** Object:  View vw_Orphan_Team_SeriesPost    Script Date: 2/26/2026 10:12:25 PM ******/
;
;
-- SeriesPost (winner and loser must both exist in Teams)
CREATE   VIEW vw_Orphan_Team_SeriesPost AS
SELECT DISTINCT 'SeriesPost (winner)' AS table_name, s.yearID, s.lgIDwinner AS lgID, s.teamIDwinner AS teamID
FROM SeriesPost s
WHERE NOT EXISTS (
    SELECT 1 FROM Teams t
    WHERE t.yearID = s.yearID AND t.teamID = s.teamIDwinner AND t.lgID = s.lgIDwinner
)
UNION ALL
SELECT DISTINCT 'SeriesPost (loser)', s.yearID, s.lgIDloser, s.teamIDloser
FROM SeriesPost s
WHERE NOT EXISTS (
    SELECT 1 FROM Teams t
    WHERE t.yearID = s.yearID AND t.teamID = s.teamIDloser AND t.lgID = s.lgIDloser
);
;
/****** Object:  View vw_Orphan_Team_All    Script Date: 2/26/2026 10:12:25 PM ******/
;
;
-- MASTER: all team orphans
CREATE   VIEW vw_Orphan_Team_All AS
SELECT * FROM vw_Orphan_Team_Batting UNION ALL
SELECT * FROM vw_Orphan_Team_Pitching UNION ALL
SELECT * FROM vw_Orphan_Team_Fielding UNION ALL
SELECT * FROM vw_Orphan_Team_FieldingOFsplit UNION ALL
SELECT * FROM vw_Orphan_Team_Appearances UNION ALL
SELECT * FROM vw_Orphan_Team_Managers UNION ALL
SELECT * FROM vw_Orphan_Team_AllStarFull UNION ALL
SELECT * FROM vw_Orphan_Team_BattingPost UNION ALL
SELECT * FROM vw_Orphan_Team_PitchingPost UNION ALL
SELECT * FROM vw_Orphan_Team_FieldingPost UNION ALL
SELECT * FROM vw_Orphan_Team_ManagersHalf UNION ALL
SELECT * FROM vw_Orphan_Team_TeamsHalf UNION ALL
SELECT * FROM vw_Orphan_Team_Salaries UNION ALL
SELECT * FROM vw_Orphan_Team_HomeGames UNION ALL
SELECT * FROM vw_Orphan_Team_SeriesPost;
;
/****** Object:  View vw_DataQuality_Summary    Script Date: 2/26/2026 10:12:25 PM ******/
;
;
CREATE     VIEW vw_DataQuality_Summary AS
SELECT 'Orphan_People' AS check_group, COUNT(*) AS issue_count, 'SELECT * FROM vw_Orphan_Player_All' AS query FROM vw_Orphan_Player_All
UNION ALL
SELECT 'Orphan_Teams', COUNT(*), 'SELECT * FROM vw_Orphan_Team_All' FROM vw_Orphan_Team_All
UNION ALL
SELECT 'Duplicate_Keys', SUM(dup_groups), 'SELECT * FROM vw_Duplicate_All' FROM vw_Duplicate_All
UNION ALL
SELECT 'Chronological', SUM(issue_count), 'SELECT * FROM vw_Errors_Chrono' FROM vw_Errors_Chrono
UNION ALL
SELECT 'Statistical', SUM(issue_count), 'SELECT * FROM vw_Errors_Stats' FROM vw_Errors_Stats
UNION ALL
SELECT 'Coverage', SUM(issue_count), 'SELECT * FROM vw_Errors_Missing' FROM vw_Errors_Missing
;
/****** Object:  View vw_standardized_city    Script Date: 2/26/2026 10:12:25 PM ******/
;
;
CREATE   VIEW vw_standardized_city AS
WITH country AS (
SELECT
	 country
	,country_no_diacritics
	,COUNT(*) AS count
	,ROW_NUMBER() OVER(PARTITION BY country_no_diacritics ORDER BY COUNT(*) DESC) AS rank
FROM (
SELECT
	 birthCountry AS country
	,LOWER(TRANSLATE(birthCountry,'ÁÀÂÄÃÅáàâäãåÉÈÊËéèêëÍÌÎÏíìîïÓÒÔÖÕØóòôöõøÚÙÛÜúùûüÑñÇç','AAAAAAaaaaaaEEEEeeeeIIIIiiiiOOOOOOooooooUUUUuuuuNnCc')) AS country_no_diacritics
FROM People 
UNION ALL 
SELECT
	 deathCountry AS country
	,LOWER(TRANSLATE(deathCountry,'ÁÀÂÄÃÅáàâäãåÉÈÊËéèêëÍÌÎÏíìîïÓÒÔÖÕØóòôöõøÚÙÛÜúùûüÑñÇç','AAAAAAaaaaaaEEEEeeeeIIIIiiiiOOOOOOooooooUUUUuuuuNnCc')) AS country_no_diacritics
FROM People
) x
WHERE country IS NOT NULL
GROUP BY 
	 country
	,country_no_diacritics
), state AS (

SELECT
	 state
	,country
	,state_no_diacritics
	,country_no_diacritics
	,COUNT(*) AS count
	,ROW_NUMBER() OVER(PARTITION BY state_no_diacritics,country_no_diacritics ORDER BY COUNT(*) DESC) AS rank
FROM (
SELECT
	 birthState AS state
	,birthCountry AS country
	,LOWER(TRANSLATE(birthState,'ÁÀÂÄÃÅáàâäãåÉÈÊËéèêëÍÌÎÏíìîïÓÒÔÖÕØóòôöõøÚÙÛÜúùûüÑñÇç','AAAAAAaaaaaaEEEEeeeeIIIIiiiiOOOOOOooooooUUUUuuuuNnCc')) AS state_no_diacritics
	,LOWER(TRANSLATE(birthCountry,'ÁÀÂÄÃÅáàâäãåÉÈÊËéèêëÍÌÎÏíìîïÓÒÔÖÕØóòôöõøÚÙÛÜúùûüÑñÇç','AAAAAAaaaaaaEEEEeeeeIIIIiiiiOOOOOOooooooUUUUuuuuNnCc')) AS country_no_diacritics
FROM People 
UNION ALL 
SELECT
	 deathState AS state
	,deathCountry AS country
	,LOWER(TRANSLATE(deathState,'ÁÀÂÄÃÅáàâäãåÉÈÊËéèêëÍÌÎÏíìîïÓÒÔÖÕØóòôöõøÚÙÛÜúùûüÑñÇç','AAAAAAaaaaaaEEEEeeeeIIIIiiiiOOOOOOooooooUUUUuuuuNnCc')) AS state_no_diacritics
	,LOWER(TRANSLATE(deathCountry,'ÁÀÂÄÃÅáàâäãåÉÈÊËéèêëÍÌÎÏíìîïÓÒÔÖÕØóòôöõøÚÙÛÜúùûüÑñÇç','AAAAAAaaaaaaEEEEeeeeIIIIiiiiOOOOOOooooooUUUUuuuuNnCc')) AS country_no_diacritics
FROM People
) x
WHERE state IS NOT NULL
GROUP BY 
	 state
	,country
	,state_no_diacritics
	,country_no_diacritics
), city AS (
SELECT
	 city
	,state
	,country
	,city_no_diacritics
	,state_no_diacritics
	,country_no_diacritics
	,COUNT(*) AS count
	,ROW_NUMBER() OVER(PARTITION BY city_no_diacritics,state_no_diacritics,country_no_diacritics ORDER BY COUNT(*) DESC) AS rank
FROM (
SELECT
	 birthCity AS city
	,birthState AS state
	,birthCountry AS country
	,LOWER(TRANSLATE(birthCity,'ÁÀÂÄÃÅáàâäãåÉÈÊËéèêëÍÌÎÏíìîïÓÒÔÖÕØóòôöõøÚÙÛÜúùûüÑñÇç','AAAAAAaaaaaaEEEEeeeeIIIIiiiiOOOOOOooooooUUUUuuuuNnCc')) AS city_no_diacritics
	,LOWER(TRANSLATE(birthState,'ÁÀÂÄÃÅáàâäãåÉÈÊËéèêëÍÌÎÏíìîïÓÒÔÖÕØóòôöõøÚÙÛÜúùûüÑñÇç','AAAAAAaaaaaaEEEEeeeeIIIIiiiiOOOOOOooooooUUUUuuuuNnCc')) AS state_no_diacritics
	,LOWER(TRANSLATE(birthCountry,'ÁÀÂÄÃÅáàâäãåÉÈÊËéèêëÍÌÎÏíìîïÓÒÔÖÕØóòôöõøÚÙÛÜúùûüÑñÇç','AAAAAAaaaaaaEEEEeeeeIIIIiiiiOOOOOOooooooUUUUuuuuNnCc')) AS country_no_diacritics
FROM People 
UNION ALL 
SELECT
	 deathCity AS city
	,deathState AS state
	,deathCountry AS country
	,LOWER(TRANSLATE(deathCity,'ÁÀÂÄÃÅáàâäãåÉÈÊËéèêëÍÌÎÏíìîïÓÒÔÖÕØóòôöõøÚÙÛÜúùûüÑñÇç','AAAAAAaaaaaaEEEEeeeeIIIIiiiiOOOOOOooooooUUUUuuuuNnCc')) AS city_no_diacritics
	,LOWER(TRANSLATE(deathState,'ÁÀÂÄÃÅáàâäãåÉÈÊËéèêëÍÌÎÏíìîïÓÒÔÖÕØóòôöõøÚÙÛÜúùûüÑñÇç','AAAAAAaaaaaaEEEEeeeeIIIIiiiiOOOOOOooooooUUUUuuuuNnCc')) AS state_no_diacritics
	,LOWER(TRANSLATE(deathCountry,'ÁÀÂÄÃÅáàâäãåÉÈÊËéèêëÍÌÎÏíìîïÓÒÔÖÕØóòôöõøÚÙÛÜúùûüÑñÇç','AAAAAAaaaaaaEEEEeeeeIIIIiiiiOOOOOOooooooUUUUuuuuNnCc')) AS country_no_diacritics
FROM People
) x
WHERE city IS NOT NULL
GROUP BY 
	 city
	,state
	,country
	,city_no_diacritics
	,state_no_diacritics
	,country_no_diacritics
) SELECT DISTINCT
c.city_no_diacritics
,s.state_no_diacritics
,ct.country_no_diacritics
,c.city
,c.state
,ct.country
,c.count
,c.rank
FROM (SELECT * FROM city WHERE RANK = 1) c LEFT JOIN (SELECT * FROM state WHERE RANK = 1) s ON c.state_no_diacritics = s.state_no_diacritics LEFT JOIN (SELECT * FROM country WHERE RANK = 1) ct ON ct.country_no_diacritics = c.country_no_diacritics
ORDER BY
c.city_no_diacritics
,s.state_no_diacritics
,ct.country_no_diacritics

LIMIT 100000;
/****** Object:  View vw_standardized_state    Script Date: 2/26/2026 10:12:25 PM ******/
;
;
CREATE   VIEW vw_standardized_state AS
WITH country AS (
SELECT
	 country
	,country_no_diacritics
	,COUNT(*) AS count
	,ROW_NUMBER() OVER(PARTITION BY country_no_diacritics ORDER BY COUNT(*) DESC) AS rank
FROM (
SELECT
	 birthCountry AS country
	,LOWER(TRANSLATE(birthCountry,'ÁÀÂÄÃÅáàâäãåÉÈÊËéèêëÍÌÎÏíìîïÓÒÔÖÕØóòôöõøÚÙÛÜúùûüÑñÇç','AAAAAAaaaaaaEEEEeeeeIIIIiiiiOOOOOOooooooUUUUuuuuNnCc')) AS country_no_diacritics
FROM People 
UNION ALL 
SELECT
	 deathCountry AS country
	,LOWER(TRANSLATE(deathCountry,'ÁÀÂÄÃÅáàâäãåÉÈÊËéèêëÍÌÎÏíìîïÓÒÔÖÕØóòôöõøÚÙÛÜúùûüÑñÇç','AAAAAAaaaaaaEEEEeeeeIIIIiiiiOOOOOOooooooUUUUuuuuNnCc')) AS country_no_diacritics
FROM People
) x
WHERE country IS NOT NULL
GROUP BY 
	 country
	,country_no_diacritics
), state AS (

SELECT
	 state
	,country
	,state_no_diacritics
	,country_no_diacritics
	,COUNT(*) AS count
	,ROW_NUMBER() OVER(PARTITION BY state_no_diacritics,country_no_diacritics ORDER BY COUNT(*) DESC) AS rank
FROM (
SELECT
	 birthState AS state
	,birthCountry AS country
	,LOWER(TRANSLATE(birthState,'ÁÀÂÄÃÅáàâäãåÉÈÊËéèêëÍÌÎÏíìîïÓÒÔÖÕØóòôöõøÚÙÛÜúùûüÑñÇç','AAAAAAaaaaaaEEEEeeeeIIIIiiiiOOOOOOooooooUUUUuuuuNnCc')) AS state_no_diacritics
	,LOWER(TRANSLATE(birthCountry,'ÁÀÂÄÃÅáàâäãåÉÈÊËéèêëÍÌÎÏíìîïÓÒÔÖÕØóòôöõøÚÙÛÜúùûüÑñÇç','AAAAAAaaaaaaEEEEeeeeIIIIiiiiOOOOOOooooooUUUUuuuuNnCc')) AS country_no_diacritics
FROM People 
UNION ALL 
SELECT
	 deathState AS state
	,deathCountry AS country
	,LOWER(TRANSLATE(deathState,'ÁÀÂÄÃÅáàâäãåÉÈÊËéèêëÍÌÎÏíìîïÓÒÔÖÕØóòôöõøÚÙÛÜúùûüÑñÇç','AAAAAAaaaaaaEEEEeeeeIIIIiiiiOOOOOOooooooUUUUuuuuNnCc')) AS state_no_diacritics
	,LOWER(TRANSLATE(deathCountry,'ÁÀÂÄÃÅáàâäãåÉÈÊËéèêëÍÌÎÏíìîïÓÒÔÖÕØóòôöõøÚÙÛÜúùûüÑñÇç','AAAAAAaaaaaaEEEEeeeeIIIIiiiiOOOOOOooooooUUUUuuuuNnCc')) AS country_no_diacritics
FROM People
) x
WHERE state IS NOT NULL
GROUP BY 
	 state
	,country
	,state_no_diacritics
	,country_no_diacritics
) SELECT DISTINCT
 s.state_no_diacritics
,ct.country_no_diacritics
,s.state
,ct.country
,s.count
,s.rank
FROM (SELECT * FROM state WHERE RANK = 1) s LEFT JOIN (SELECT * FROM country WHERE RANK = 1) ct ON ct.country_no_diacritics = s.country_no_diacritics
ORDER BY
 s.state_no_diacritics
,ct.country_no_diacritics

LIMIT 100000;
/****** Object:  View vw_standardized_country    Script Date: 2/26/2026 10:12:25 PM ******/
;
;
CREATE   VIEW vw_standardized_country AS
WITH country AS (
SELECT
	 country
	,country_no_diacritics
	,COUNT(*) AS count
	,ROW_NUMBER() OVER(PARTITION BY country_no_diacritics ORDER BY COUNT(*) DESC) AS rank
FROM (
SELECT
	 birthCountry AS country
	,LOWER(TRANSLATE(birthCountry,'ÁÀÂÄÃÅáàâäãåÉÈÊËéèêëÍÌÎÏíìîïÓÒÔÖÕØóòôöõøÚÙÛÜúùûüÑñÇç','AAAAAAaaaaaaEEEEeeeeIIIIiiiiOOOOOOooooooUUUUuuuuNnCc')) AS country_no_diacritics
FROM People 
UNION ALL 
SELECT
	 deathCountry AS country
	,LOWER(TRANSLATE(deathCountry,'ÁÀÂÄÃÅáàâäãåÉÈÊËéèêëÍÌÎÏíìîïÓÒÔÖÕØóòôöõøÚÙÛÜúùûüÑñÇç','AAAAAAaaaaaaEEEEeeeeIIIIiiiiOOOOOOooooooUUUUuuuuNnCc')) AS country_no_diacritics
FROM People
) x
WHERE country IS NOT NULL
GROUP BY 
	 country
	,country_no_diacritics
) SELECT DISTINCT
 ct.country_no_diacritics
,ct.country
,ct.count
,ct.rank
FROM (SELECT * FROM country WHERE RANK = 1) ct
ORDER BY
 ct.country_no_diacritics

LIMIT 100000;
/****** Object:  View vw_Orphan_Player_Counts    Script Date: 2/26/2026 10:12:25 PM ******/
;
;
-- Quick counts
CREATE   VIEW vw_Orphan_Player_Counts AS
SELECT table_name, COUNT(*) AS orphan_rows
FROM vw_Orphan_Player_All
GROUP BY table_name
;
/****** Object:  View vw_Orphan_Team_Counts    Script Date: 2/26/2026 10:12:25 PM ******/
;
;
-- Quick counts
CREATE   VIEW vw_Orphan_Team_Counts AS
SELECT table_name, COUNT(*) AS orphan_rows
FROM vw_Orphan_Team_All
GROUP BY table_name
;
/****** Object:  View vw_Orphan_All_Counts    Script Date: 2/26/2026 10:12:25 PM ******/
;
;
CREATE   VIEW vw_Orphan_All_Counts AS
SELECT 'People' AS fk_target, table_name, orphan_rows
FROM vw_Orphan_Player_Counts
UNION ALL
SELECT 'Teams', table_name, orphan_rows
FROM vw_Orphan_Team_Counts
;
/****** Object:  Table TeamsFranchises    Script Date: 2/26/2026 10:12:25 PM ******/
;
;
CREATE TABLE TeamsFranchises(
	franchID varchar(4) NOT NULL,
	franchName varchar(100) NULL,
	active varchar(2) NULL,
	NAassoc varchar(4) NULL
)
;
;
/****** Object:  Index CX_TeamsFranchises_franchID    Script Date: 2/26/2026 10:12:25 PM ******/
CREATE INDEX CX_TeamsFranchises_franchID ON TeamsFranchises
(
	franchID ASC
)
;
/****** Object:  View vw_Duplicate_TeamsFranchises    Script Date: 2/26/2026 10:12:25 PM ******/
;
;
-- TeamFranchises: franchID
CREATE   VIEW vw_Duplicate_TeamsFranchises AS
SELECT franchID, COUNT(*) AS dup_count
FROM TeamsFranchises
GROUP BY franchID
HAVING COUNT(*) > 1;
;
/****** Object:  View vw_Duplicate_Parks    Script Date: 2/26/2026 10:12:25 PM ******/
;
;
-- Parks: parkkey
CREATE   VIEW vw_Duplicate_Parks AS
SELECT parkkey, COUNT(*) AS dup_count
FROM Parks
GROUP BY parkkey
HAVING COUNT(*) > 1;
;
;
/****** Object:  Index IX_AllstarFull_year_game    Script Date: 2/26/2026 10:12:25 PM ******/
CREATE INDEX IX_AllstarFull_year_game ON AllstarFull
(
	yearID ASC,
	gameID ASC
)
INCLUDE(playerID,teamID,lgID,GP,startingPos)
;
;
/****** Object:  Index IX_Appearances_team_year    Script Date: 2/26/2026 10:12:25 PM ******/
CREATE INDEX IX_Appearances_team_year ON Appearances
(
	teamID ASC,
	yearID ASC
)
INCLUDE(playerID,G_all,GS,G_p,G_c,G_1b,G_2b,G_3b,G_ss,G_lf,G_cf,G_rf,G_of,G_dh)
;
;
/****** Object:  Index IX_AwardsManagers_award_year    Script Date: 2/26/2026 10:12:25 PM ******/
CREATE INDEX IX_AwardsManagers_award_year ON AwardsManagers
(
	awardID ASC,
	yearID ASC
)
INCLUDE(playerID,lgID)
;
;
/****** Object:  Index IX_AwardsPlayers_award_year    Script Date: 2/26/2026 10:12:25 PM ******/
CREATE INDEX IX_AwardsPlayers_award_year ON AwardsPlayers
(
	awardID ASC,
	yearID ASC
)
INCLUDE(playerID,lgID)
;
;
/****** Object:  Index IX_AwardsShareManagers_award_year    Script Date: 2/26/2026 10:12:25 PM ******/
CREATE INDEX IX_AwardsShareManagers_award_year ON AwardsShareManagers
(
	awardID ASC,
	yearID ASC
)
INCLUDE(lgID,pointsWon,pointsMax,votesFirst)
;
;
/****** Object:  Index IX_AwardsSharePlayers_award_year    Script Date: 2/26/2026 10:12:25 PM ******/
CREATE INDEX IX_AwardsSharePlayers_award_year ON AwardsSharePlayers
(
	awardID ASC,
	yearID ASC
)
INCLUDE(lgID,pointsWon,pointsMax,votesFirst)
;
;
/****** Object:  Index IX_Batting_team_year    Script Date: 2/26/2026 10:12:25 PM ******/
CREATE INDEX IX_Batting_team_year ON Batting
(
	teamID ASC,
	yearID ASC
)
INCLUDE(playerID,G,AB,H,HR,BB,SO,R,RBI)
;
;
/****** Object:  Index IX_Batting_year_team    Script Date: 2/26/2026 10:12:25 PM ******/
CREATE INDEX IX_Batting_year_team ON Batting
(
	yearID ASC,
	teamID ASC
)
INCLUDE(playerID,G,AB,H,HR,BB,SO,R,RBI)
;
;
/****** Object:  Index IX_BattingPost_team_year    Script Date: 2/26/2026 10:12:25 PM ******/
CREATE INDEX IX_BattingPost_team_year ON BattingPost
(
	teamID ASC,
	yearID ASC
)
INCLUDE(playerID,G,AB,H,HR,RBI)
;
;
/****** Object:  Index IX_CollegePlaying_school    Script Date: 2/26/2026 10:12:25 PM ******/
CREATE INDEX IX_CollegePlaying_school ON CollegePlaying
(
	schoolID ASC
)
INCLUDE(playerID,yearID)
;
;
/****** Object:  Index IX_Fielding_team_year    Script Date: 2/26/2026 10:12:25 PM ******/
CREATE INDEX IX_Fielding_team_year ON Fielding
(
	teamID ASC,
	yearID ASC
)
INCLUDE(playerID,POS,G,GS,InnOuts,PO,A,E,DP,ZR)
;
;
/****** Object:  Index IX_Fielding_year_pos    Script Date: 2/26/2026 10:12:25 PM ******/
CREATE INDEX IX_Fielding_year_pos ON Fielding
(
	yearID ASC,
	POS ASC
)
INCLUDE(playerID,teamID,G,GS,PO,A,E)
;
;
/****** Object:  Index IX_FieldingOFsplit_team_year    Script Date: 2/26/2026 10:12:25 PM ******/
CREATE INDEX IX_FieldingOFsplit_team_year ON FieldingOFsplit
(
	teamID ASC,
	yearID ASC
)
INCLUDE(playerID,POS,G,GS)
;
;
/****** Object:  Index IX_FieldingPost_team_year    Script Date: 2/26/2026 10:12:25 PM ******/
CREATE INDEX IX_FieldingPost_team_year ON FieldingPost
(
	teamID ASC,
	yearID ASC
)
INCLUDE(playerID,POS,G,GS,PO,A,E)
;
/****** Object:  Index IX_HallOfFame_year    Script Date: 2/26/2026 10:12:25 PM ******/
CREATE INDEX IX_HallOfFame_year ON HallOfFame
(
	yearid ASC
)
INCLUDE(playerID,inducted,category,votes,ballots)
;
;
/****** Object:  Index IX_HomeGames_park    Script Date: 2/26/2026 10:12:25 PM ******/
CREATE INDEX IX_HomeGames_park ON HomeGames
(
	parkkey ASC
)
INCLUDE(yearkey,teamkey,games,attendance)
;
;
/****** Object:  Index IX_Managers_player    Script Date: 2/26/2026 10:12:25 PM ******/
CREATE INDEX IX_Managers_player ON Managers
(
	playerID ASC
)
INCLUDE(yearID,teamID,W,L,rank)
;
;
/****** Object:  Index IX_ManagersHalf_player    Script Date: 2/26/2026 10:12:25 PM ******/
CREATE INDEX IX_ManagersHalf_player ON ManagersHalf
(
	playerID ASC
)
INCLUDE(yearID,teamID,W,L,rank)
;
;
/****** Object:  Index IX_Parks_city_state    Script Date: 2/26/2026 10:12:25 PM ******/
CREATE INDEX IX_Parks_city_state ON Parks
(
	city ASC,
	state ASC
)
;
;
/****** Object:  Index IX_Parks_parkkey    Script Date: 2/26/2026 10:12:25 PM ******/
CREATE INDEX IX_Parks_parkkey ON Parks
(
	parkkey ASC
)
;
;
/****** Object:  Index IX_Parks_parkname    Script Date: 2/26/2026 10:12:25 PM ******/
CREATE INDEX IX_Parks_parkname ON Parks
(
	parkname ASC
)
;
;
/****** Object:  Index IX_People_bbrefID    Script Date: 2/26/2026 10:12:25 PM ******/
CREATE INDEX IX_People_bbrefID ON People
(
	bbrefID ASC
)
;
;
/****** Object:  Index IX_People_retroID    Script Date: 2/26/2026 10:12:25 PM ******/
CREATE INDEX IX_People_retroID ON People
(
	retroID ASC
)
;
;
/****** Object:  Index IX_Pitching_team_year    Script Date: 2/26/2026 10:12:25 PM ******/
CREATE INDEX IX_Pitching_team_year ON Pitching
(
	teamID ASC,
	yearID ASC
)
INCLUDE(playerID,G,GS,SV,ERA,IPouts,H,ER,HR,BB,SO)
;
;
/****** Object:  Index IX_Pitching_year_team    Script Date: 2/26/2026 10:12:25 PM ******/
CREATE INDEX IX_Pitching_year_team ON Pitching
(
	yearID ASC,
	teamID ASC
)
INCLUDE(playerID,G,GS,SV,ERA,IPouts,H,ER,HR,BB,SO)
;
;
/****** Object:  Index IX_PitchingPost_team_year    Script Date: 2/26/2026 10:12:25 PM ******/
CREATE INDEX IX_PitchingPost_team_year ON PitchingPost
(
	teamID ASC,
	yearID ASC
)
INCLUDE(playerID,G,GS,SV,IPouts,H,ER,HR,BB,SO)
;
;
/****** Object:  Index IX_Salaries_team_year    Script Date: 2/26/2026 10:12:25 PM ******/
CREATE INDEX IX_Salaries_team_year ON Salaries
(
	teamID ASC,
	yearID ASC
)
INCLUDE(playerID,salary)
;
/****** Object:  Index IX_Salaries_year    Script Date: 2/26/2026 10:12:25 PM ******/
CREATE INDEX IX_Salaries_year ON Salaries
(
	yearID ASC
)
INCLUDE(teamID,playerID,salary)
;
;
/****** Object:  Index IX_SeriesPost_loser    Script Date: 2/26/2026 10:12:25 PM ******/
CREATE INDEX IX_SeriesPost_loser ON SeriesPost
(
	teamIDloser ASC,
	yearID ASC
)
INCLUDE(lgIDloser,wins,losses)
;
;
/****** Object:  Index IX_SeriesPost_winner    Script Date: 2/26/2026 10:12:25 PM ******/
CREATE INDEX IX_SeriesPost_winner ON SeriesPost
(
	teamIDwinner ASC,
	yearID ASC
)
INCLUDE(lgIDwinner,wins,losses)
;
;
/****** Object:  Index IX_Teams_lg_year    Script Date: 2/26/2026 10:12:25 PM ******/
CREATE INDEX IX_Teams_lg_year ON Teams
(
	lgID ASC,
	yearID ASC
)
INCLUDE(teamID,W,L,R,RA,HR,BB,SO,ERA,attendance)
;
;
/****** Object:  Index IX_Teams_team    Script Date: 2/26/2026 10:12:25 PM ******/
CREATE INDEX IX_Teams_team ON Teams
(
	teamID ASC
)
INCLUDE(yearID,name,lgID,W,L)
;
;
/****** Object:  Index IX_TeamsHalf_lg_year    Script Date: 2/26/2026 10:12:25 PM ******/
CREATE INDEX IX_TeamsHalf_lg_year ON TeamsHalf
(
	lgID ASC,
	yearID ASC
)
INCLUDE(teamID,W,L,Rank)
;