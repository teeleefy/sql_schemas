-- **Part Three: Soccer League**
-- Design a schema for a simple sports league. Your schema should keep track of
-- - All of the teams in the league
-- - All of the goals scored by every player for each game
-- - All of the players in the league and their corresponding teams
-- - All of the referees who have been part of each game
-- - All of the matches played between teams
-- - All of the start and end dates for season that a league has
-- - The standings/rankings of each team in the league (This doesn’t have to be its own table if the data can be captured somehow).



-- from the terminal run:
-- psql < soccer.sql

DROP DATABASE IF EXISTS soccer;

CREATE DATABASE soccer;
\c soccer

CREATE TABLE teams (
    id SERIAL PRIMARY KEY,
    name TEXT NOT NULL
);

CREATE TABLE referees (
    id SERIAL PRIMARY KEY,
    name TEXT NOT NULL
);

CREATE TABLE seasons (
    id SERIAL PRIMARY KEY,
    season_start DATE NOT NULL,
    season_end DATE NOT NULL
);

CREATE TABLE players (
    id SERIAL PRIMARY KEY,
    name TEXT NOT NULL,
    team INTEGER REFERENCES teams ON DELETE SET NULL
);

CREATE TABLE games (
    id SERIAL PRIMARY KEY,
    team1 INTEGER REFERENCES teams ON DELETE CASCADE ,
    team2 INTEGER REFERENCES teams ON DELETE CASCADE,
    referee INTEGER REFERENCES referees ON DELETE SET NULL,
    season INTEGER REFERENCES seasons ON DELETE CASCADE,
    UNIQUE(team1, team2, season)
);

CREATE TABLE goals (
    id SERIAL PRIMARY KEY,
    player INTEGER REFERENCES players ON DELETE SET NULL,
    match INTEGER REFERENCES games ON DELETE CASCADE, 
    team INTEGER REFERENCES teams ON DELETE CASCADE
);

CREATE TABLE results (
    id SERIAL PRIMARY KEY,
    match INTEGER REFERENCES games ON DELETE CASCADE,
    team INTEGER REFERENCES teams ON DELETE CASCADE,
    result TEXT NOT NULL
);

CREATE TABLE lineup (
    id SERIAL PRIMARY KEY,
    player INTEGER REFERENCES players ON DELETE CASCADE,
    match INTEGER REFERENCES games ON DELETE CASCADE,
    team INTEGER REFERENCES teams ON DELETE CASCADE
);


INSERT INTO teams
(name) VALUES 
('Blue Jays'),
('Red Arrows'),
('Black Ice'),
('Royal Rooks'),
('Gold Giants'),
('Mean Green'),
('Silver Sleuths');

INSERT INTO referees
(name) VALUES 
('Blake'),
('Reddington'),
('Ian'),
('Raymond'),
('Gordan'),
('Malcolm');


INSERT INTO seasons
(season_start, season_end) VALUES 
('2022-09-06', '2023-01-18'),
('2021-09-01', '2022-01-14'),
('2020-09-04', '2021-01-12')
;

INSERT INTO players
(name, team) VALUES 
('Katz', 1),
('Moore', 2),
('Patel', 3),
('Kam', 4),
('Mason', 5),
('Paul', 6),
('Lance', 7),
('Jason', 2),
('Peter', 1),
('Craig', 3);


INSERT INTO games
(team1, team2, referee, season) VALUES 
(1, 4, 1, 1),
(1, 6, 2, 1),
(2, 3, 3, 1),
(2, 5, 4, 1),
(4, 7, 5, 1),
(1, 4, 1, 2),
(1, 6, 2, 2),
(2, 3, 3, 2),
(2, 5, 4, 2),
(4, 7, 5, 2),
(1, 4, 1, 3);

INSERT INTO goals
(player, match) VALUES
(1, 1),
(9, 1),
(4, 1),
(2, 3),
(3, 3),
(8, 3);

INSERT INTO lineup
(player, match, team) VALUES
(1, 1, 1),
(9, 1, 1),
(4, 1, 4);



INSERT INTO results
(match, team, result) VALUES
( 1, 1, 'Win'),
( 1, 4, 'Lose');

\x auto;

 SELECT games.id, team_1.name, team_2.name, seasons.season_start, seasons.season_end, referees.name FROM games JOIN teams AS team_1 ON team_1.id = games.team1 JOIN teams AS team_2 ON team_2.id = games.team2 JOIN seasons ON games.season = seasons.id JOIN referees ON referees.id = games.referee;

 SELECT results.match, teams.name, results.result FROM results JOIN teams ON results.team = teams.id JOIN games ON results.match = games.id JOIN games t1 ON t1.id = games.id JOIN games t2 ON t2.id=games.id;