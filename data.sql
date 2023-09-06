CREATE DATABASE leaguemgmt;

CREATE TABLE admin_users (
    admin_email VARCHAR (255) PRIMARY KEY,
    hashed_password VARCHAR(255));

INSERT INTO admin_users  (admin_email, hashed_password) VALUES('alerojasmal@gmail.com', '$2b$10$GAJMhAmO7U5QcucFZuL29.3UXZPlHBKRVAbInqX2eTiQ/sNYiAQim');



CREATE TABLE leagues (
    id SERIAL PRIMARY KEY,
    league_name VARCHAR(40),
    starting_date VARCHAR(10),
    midway_point VARCHAR(10),
    end_date VARCHAR(10),
    isFinished BOOLEAN DEFAULT false);

INSERT INTO leagues(league_name, starting_date, midway_point, end_date) VALUES ('WOMENS DOUBLES', '2023-08-01', '2023-08-15', '2023-08-29');


CREATE TABLE players (
    player_id SERIAL PRIMARY KEY,
    player_firstname VARCHAR(40),
    player_lastname VARCHAR(40),
    player_phonenumber VARCHAR(14),
    player_email VARCHAR(40));

CREATE TABLE teams (
    team_id SERIAL PRIMARY KEY,
    player1_id INTEGER REFERENCES players(player_id),
    player2_id INTEGER REFERENCES players(player_id), 
    CHECK (player1_id <> player2_id));

-- Create a functional index for the unique constraint
-- Preventing duplicated teams in different order
CREATE UNIQUE INDEX unique_player_order_idx ON teams (LEAST(player1_id, player2_id), GREATEST(player1_id, player2_id));

CREATE TABLE events (
    league_id INTEGER REFERENCES leagues(id) ON DELETE CASCADE,
    event_id SERIAL PRIMARY KEY,
    event_name VARCHAR(40));

CREATE TABLE event_teams (
    event_id integer REFERENCES events(event_id) ON DELETE CASCADE,
    team_id integer REFERENCES teams(team_id),
    team_points integer,
    team_bonuspoints integer,
    team_withdrawn boolean DEFAULT false,
    CONSTRAINT event_teams_pkey PRIMARY KEY (event_id, team_id));

CREATE TABLE matches (
    event_id INTEGER REFERENCES events(event_id),
    match_id SERIAL PRIMARY KEY,
    team1_id INTEGER REFERENCES teams(team_id),
    team2_id INTEGER REFERENCES teams(team_id),
    isFinished BOOLEAN,
    withdrawal BOOLEAN,
    match_date DATE,
    winner_id INTEGER REFERENCES teams(team_id),
    winner_score VARCHAR(40),
    team1_sets INTEGER,
    team2_sets INTEGER);

INSERT INTO matches (event_id, team1_id, team2_id) VALUES ($1, $2, $3)



DROP TABLE named;

('SELECT * FROM leagues WHERE user_email = $1', [user_email])

ALTER TABLE players
ALTER COLUMN player_phonenumber TYPE VARCHAR(14);


SELECT e.event_id, e.event_name, e.participating_teams
FROM events e
JOIN leagues l ON e.league_id = l.id
WHERE l.id = 1;