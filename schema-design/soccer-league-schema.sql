CREATE TABLE seasons (
    id SERIAL PRIMARY KEY,
    name VARCHAR(50) NOT NULL, 
    start_date DATE NOT NULL,
    end_date DATE NOT NULL
);

CREATE TABLE teams (
    id SERIAL PRIMARY KEY,
    name VARCHAR(100) UNIQUE NOT NULL,
    city VARCHAR(100)
);

CREATE TABLE players (
    id SERIAL PRIMARY KEY,
    first_name VARCHAR(50) NOT NULL,
    last_name VARCHAR(50) NOT NULL,
    team_id INT REFERENCES teams(id) ON DELETE SET NULL
);

CREATE TABLE referees (
    id SERIAL PRIMARY KEY,
    first_name VARCHAR(50) NOT NULL,
    last_name VARCHAR(50) NOT NULL
);

CREATE TABLE matches (
    id SERIAL PRIMARY KEY,
    season_id INT NOT NULL REFERENCES seasons(id) ON DELETE CASCADE,
    home_team_id INT NOT NULL REFERENCES teams(id) ON DELETE CASCADE,
    away_team_id INT NOT NULL REFERENCES teams(id) ON DELETE CASCADE,
    match_date TIMESTAMP NOT NULL, CONSTRAINT check_different_teams CHECK (home_team_id <> away_team_id)
);

CREATE TABLE match_referees (
    match_id INT NOT NULL REFERENCES matches(id) ON DELETE CASCADE,
    referee_id INT NOT NULL REFERENCES referees(id) ON DELETE CASCADE,
    role VARCHAR(50) NOT NULL,
    PRIMARY KEY (match_id, referee_id)
);

CREATE TABLE goals (
    id SERIAL PRIMARY KEY,
    match_id INT NOT NULL REFERENCES matches(id) ON DELETE CASCADE,
    player_id INT NOT NULL REFERENCES players(id) ON DELETE CASCADE,
    time_scored INT
 );

-- SQL QUERY FOR TEAM STANGINGS
 CREATE VIEW team_standings AS
 SELECT
    t.id AS team_id,
    t.name AS team_name,
    COUNT (g.id) AS totatl_goals_scored
FROM teams t 
LEFT JOIN players p ON t.id = p.team_id
LEFT JOIN goals g ON p.id = g.player_id
GROUP BY t.id, t.name
ORDER BY totatl_goals_scored DESC;
