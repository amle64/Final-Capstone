BEGIN TRANSACTION;

INSERT INTO win_condition (name) values ('MIN');
INSERT INTO win_condition (name) values ('MAX');

--Testing data PW is the usernames
INSERT INTO users (username,password_hash,role) VALUES ('user','$2a$08$UkVvwpULis18S19S5pZFn.YHPZt3oaqHZnDwqbCW9pft6uFtkXKDC','ROLE_USER');
INSERT INTO users (username,password_hash,role) VALUES ('admin','$2a$08$UkVvwpULis18S19S5pZFn.YHPZt3oaqHZnDwqbCW9pft6uFtkXKDC','ROLE_ADMIN');
INSERT INTO users (username,password_hash,role) VALUES ('andrew500', '$2a$10$VPhB5.Tv16s02uul4lAJ6uahtkdP6M.QUnN0uI06A26IXrETFlzBy', 'ROLE_USER');
INSERT INTO users (username,password_hash,role) VALUES ('andrew501', '$2a$10$CWafZTSVTpRp6.5tpUJgN.0.jEjKIZhQvlZwjaNvlZKjugvIMOShS', 'ROLE_USER');
INSERT INTO users (username,password_hash,role) VALUES ('ale200', '$2a$10$svmq0rFHa4fJK3m.g3fYFOC/vcHrKM.9PNw7Ngz9bXR5sFMuQ7iKC', 'ROLE_USER');
INSERT INTO users (username,password_hash,role) VALUES ('user2', '$2a$10$/67qk31UotdsiEAqPRq4wumVN2y1dVC4kz8gF60R/VuJyEKUG8Jc6', 'ROLE_USER');
INSERT INTO users (username,password_hash,role) VALUES ('user4', '$2a$10$P7bOg1bC0aeTUFAdrM34TeF6BEosqqWwqHPv3pOXSD6Jys4YviCMK', 'ROLE_USER');
INSERT INTO users (username,password_hash,role) VALUES ('user5', '$2a$10$8VvMnODnlWlGL0w6RvekaOlHLqlXjI5JOerJMLY13ewQWVloCbhYS', 'ROLE_USER');
INSERT INTO users (username,password_hash,role) VALUES ('bob', '$2a$10$sAIk.gDXQ9Sfte43sAIyFeUCAHiBs5MGR219FpUiFOQ5NzROLXZha', 'ROLE_USER');


INSERT INTO user_details(user_id, display_name, elo_rating, is_staff) VALUES (
    1,
    'user',
    1150,
    FALSE
);

INSERT INTO user_details(user_id, display_name, elo_rating, is_staff) VALUES (
    2,
    'admin',
    1100,
    TRUE
);

INSERT INTO user_details(user_id, display_name, elo_rating, is_staff) VALUES (
    3,
    'Andrew',
    1200,
    FALSE
);
INSERT INTO user_details(user_id, display_name, elo_rating, is_staff) VALUES (
    4,
    'Drew',
    1100,
    TRUE
);
INSERT INTO user_details(user_id, display_name, elo_rating, is_staff) VALUES (
    5,
    'A-Andrew',
    1200,
    TRUE
);

INSERT INTO user_details(user_id, display_name, elo_rating, is_staff) VALUES (
    6,
    'user2',
    900,
    TRUE
);
INSERT INTO user_details(user_id, display_name, elo_rating, is_staff) VALUES (
    7,
    'Glitter Badger',
    1250,
    TRUE
);

INSERT INTO user_details(user_id, display_name, elo_rating, is_staff) VALUES (
    8,
    'FalconX',
    1300,
    FALSE
);

INSERT INTO user_details(user_id, display_name, elo_rating, is_staff) VALUES (
    9,
    'Bob',
    1250,
    FALSE
);

INSERT INTO team (owner_id, name, create_date) VALUES(
    (SELECT user_id FROM users WHERE username = 'user'),
    'Wicked Tuna',
    CURRENT_DATE

INSERT INTO team (owner_id, name, create_date) VALUES(
    (SELECT user_id FROM users WHERE username = 'Drew'),
    'Team I Chow',
    CURRENT_DATE

INSERT INTO team (owner_id, name, create_date) VALUES(
    (SELECT user_id FROM users WHERE username = 'A-Andrew'),
    'Olympic E-Sports',
    CURRENT_DATE

INSERT INTO team (owner_id, name, create_date) VALUES(
    (SELECT user_id FROM users WHERE username = 'andrew500'),
    'Struggle Bus E-sports',
    CURRENT_DATE
);
INSERT INTO team (owner_id, name, create_date) VALUES(
    (SELECT user_id FROM users WHERE username = 'andrew501'),
    'Golfing Masters',
    CURRENT_DATE
);
INSERT INTO game (name, description, win_type) values (
    'Chess',
    'A game of wits',
    (SELECT condition_id FROM win_condition WHERE name = 'MAX')
);
INSERT INTO game (name, description, win_type) values (
    'Soccer',
    'Kick the ball',
    (SELECT condition_id FROM win_condition WHERE name = 'MAX')
);
INSERT INTO game (name, description, win_type) values (
    'Golf',
    'Surprisingly frustrating and calming',
    (SELECT condition_id FROM win_condition WHERE name = 'MIN')
);
INSERT INTO game (name, description, win_type) values (
    'CS2',
    'The bomb has been planted',
    (SELECT condition_id FROM win_condition WHERE name = 'MAX')
);
INSERT INTO game (name, description, win_type) values (
    'War',
    'A game of luck',
    (SELECT condition_id FROM win_condition WHERE name = 'MAX')

INSERT INTO game (name, description, win_type) values (
    'Basketball',
    'Agility and precision',
    (SELECT condition_id FROM win_condition WHERE name = 'MAX')

INSERT INTO game (name, description, win_type) values (
    'Minecraft',
    'How does one win?',
    (SELECT condition_id FROM win_condition WHERE name = 'MAX')



INSERT INTO match (game_id, round_count, is_scrim) VALUES (
    (SELECT game_id FROM game WHERE name = 'Golf'),
    3,
    FALSE
);

INSERT INTO match (game_id, round_count, is_scrim) VALUES (
    (SELECT game_id FROM game WHERE name = 'Golf'),
    3,
    FALSE
);

INSERT INTO bracket (parent_bracket, match_id, name) VALUES (
    NULL,
    1,
    'First bracket'
);

INSERT INTO bracket (parent_bracket, match_id, name) VALUES (
    NULL,
    2,
    'Second bracket'
);





INSERT INTO address (building_number, street, city, province, country) VALUES (
    1200,
    'Smith Street',
    'Los Angeles',
    'California',
    'USA'
);

INSERT INTO address (building_number, street, city, province, country) VALUES (
    1801,
    'Hawkins Rd',
    'Annapolis',
    'Maryland',
    'USA'
);
INSERT INTO address (building_number, street, city, province, country) VALUES (
    120,
    'Kings Xing',
    'Lewes',
    'Deleware',
    'USA'
);



INSERT INTO tournament (game_id, bracket_id, creator_id, name, is_scrim, is_online, location, start_date, end_date) VALUES (
    (SELECT game_id FROM game WHERE name = 'Golf'),
    1,
    3,
    'Golf Tournament',
    FALSE,
    TRUE,
    1,
    CURRENT_DATE,
    NULL
);

INSERT INTO tournament (game_id, bracket_id, creator_id, name, is_scrim, is_online, location, start_date, end_date) VALUES (
    (SELECT game_id FROM game WHERE name = 'Golf'),
    2,
    3,
    'Golf Tournament',
    TRUE,
    FALSE,
    NULL,
    CURRENT_DATE,
    NULL
);

-- BRIDGE TABLES
INSERT INTO team_players (user_id, team_id) VALUES(
    (SELECT user_id FROM users WHERE username = 'andrew501'),
    (SELECT team_id FROM team WHERE name = 'Struggle Bus E-sports')
);
INSERT INTO team_players (user_id, team_id) VALUES(
    (SELECT user_id FROM users WHERE username = 'andrew501'),
    (SELECT team_id FROM team WHERE name = 'Golfing Masters')
);
INSERT INTO team_players (user_id, team_id) VALUES(
    (SELECT user_id FROM users WHERE username = 'andrew500'),
    (SELECT team_id FROM team WHERE name = 'Struggle Bus E-sports')
);
INSERT INTO team_players (user_id, team_id) VALUES(
    (SELECT user_id FROM users WHERE username = 'andrew500'),
    (SELECT team_id FROM team WHERE name = 'Golfing Masters')
);
INSERT INTO team_players (user_id, team_id) VALUES(
    (SELECT user_id FROM users WHERE username = 'ale200'),
    (SELECT team_id FROM team WHERE name = 'Struggle Bus E-sports')
);
INSERT INTO team_games (team_id, game_id) VALUES (
    (SELECT team_id FROM team WHERE name = 'Struggle Bus E-sports'),
    (SELECT game_id FROM game WHERE name = 'CS2')
);
INSERT INTO team_games (team_id, game_id) VALUES (
    (SELECT team_id FROM team WHERE name = 'Struggle Bus E-sports'),
    (SELECT game_id FROM game WHERE name = 'Golf')
);
INSERT INTO team_games (team_id, game_id) VALUES (
    (SELECT team_id FROM team WHERE name = 'Golfing Masters'),
    (SELECT game_id FROM game WHERE name = 'Golf')
);

COMMIT TRANSACTION;
