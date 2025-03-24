CREATE TABLE player (
    id BIGINT PRIMARY KEY,
    name VARCHAR,
    external_id VARCHAR,
    external_id_platform VARCHAR,
    date_created DATE,
    is_deleted BOOLEAN,
    date_deleted TIMESTAMP
);

CREATE TABLE fcs (
    id BIGINT PRIMARY KEY,
    player_id BIGINT REFERENCES player(id),
    fc VARCHAR,
    date_added TIMESTAMP
);

CREATE TABLE player_fc_history (
    id BIGINT PRIMARY KEY,
    fc_id BIGINT REFERENCES fcs(id),
    ip_address VARCHAR,
    geo_location VARCHAR,
    isp VARCHAR,
    hardware_id VARCHAR,
    mac_address VARCHAR,
    console_type VARCHAR,
    date_time TIMESTAMP,
    is_initial_registration BOOLEAN
);

CREATE TABLE previous_names (
    id BIGINT PRIMARY KEY,
    player_id BIGINT REFERENCES player(id),
    name VARCHAR,
    date_removed TIMESTAMP
);

CREATE TABLE streaming_platforms (
    id BIGINT PRIMARY KEY,
    player_id BIGINT REFERENCES player(id),
    season_id BIGINT REFERENCES season(id),
    url VARCHAR,
    platform_name VARCHAR
);

CREATE TABLE season (
    id BIGINT PRIMARY KEY,
    name VARCHAR,
    start_date TIMESTAMP,
    end_date TIMESTAMP
);

CREATE TABLE season_leaderboard (
    id BIGINT PRIMARY KEY,
    season_id BIGINT REFERENCES season(id),
    name VARCHAR,
    leaderboard_type VARCHAR
);

CREATE TABLE player_season_leaderboard (
    player_id BIGINT REFERENCES player(id),
    season_leaderboard_id BIGINT REFERENCES season_leaderboard(id),
    rating_one_start INTEGER,
    rating_two_start INTEGER,
    PRIMARY KEY (player_id, season_leaderboard_id)
);

CREATE TABLE event (
    id BIGINT PRIMARY KEY,
    season_leaderboard_id BIGINT REFERENCES season_leaderboard(id),
    date_submitted DATE,
    format VARCHAR,
    applied_formula_id BIGINT,
    is_deleted BOOLEAN,
    date_deleted TIMESTAMP
);

CREATE TABLE event_team (
    id BIGINT PRIMARY KEY,
    event_id BIGINT REFERENCES event(id),
    team_score INTEGER,
    team_place BIGINT
);

CREATE TABLE event_team_players (
    event_team_id BIGINT REFERENCES event_team(id),
    player_id BIGINT REFERENCES player(id),
    place INTEGER,
    score INTEGER,
    rating_one_before INTEGER,
    rating_one_after INTEGER,
    rating_two_before INTEGER,
    rating_two_after INTEGER,
    PRIMARY KEY (event_team_id, player_id)
);

CREATE TABLE player_season (
    player_id BIGINT REFERENCES player(id),
    season_id BIGINT REFERENCES season(id),
    player_picture_id BIGINT REFERENCES player_picture(id),
    country_flag_id BIGINT REFERENCES flag(id),
    controller_id BIGINT REFERENCES controller(id),
    PRIMARY KEY (player_id, season_id)
);

CREATE TABLE flag (
    id BIGINT PRIMARY KEY,
    name VARCHAR,
    country_ISO_3166_code CHAR,
    image BYTEA
);

CREATE TABLE controller (
    id BIGINT PRIMARY KEY,
    name VARCHAR,
    image BYTEA
);

CREATE TABLE player_picture (
    id BIGINT PRIMARY KEY,
    image BYTEA,
    date_added TIMESTAMP
);