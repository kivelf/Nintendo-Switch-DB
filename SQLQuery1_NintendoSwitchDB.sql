USE NintendoSwitchDB;

-- in this file we're creating and populating the tables that our Nintendo Switch DB consists of

-- clear tables (if needed)

DROP TABLE IF EXISTS Publisher;
DROP TABLE IF EXISTS Developer;
DROP TABLE IF EXISTS Game;
DROP TABLE IF EXISTS Player;
DROP TABLE IF EXISTS Plays;


CREATE TABLE Publisher (
	publisher_id INT IDENTITY (1, 1) PRIMARY KEY,	/* auto-incremented id used as PK */
	name VARCHAR(50) NOT NULL,	/* not unique bc we can have the same publisher in different regions/ countries */
	country VARCHAR(50)
);

CREATE TABLE Developer (
	dev_id INT IDENTITY (1, 1) PRIMARY KEY,
	name VARCHAR(50) NOT NULL UNIQUE,
	founding_date DATE,
	country VARCHAR(50)
);

CREATE TABLE Game (
	game_id INT IDENTITY (1, 1) PRIMARY KEY,
	name VARCHAR(100) NOT NULL UNIQUE,
	release_date DATE,
	genre VARCHAR(25),
	switch_only BIT NOT NULL,	/* is the game Switch-exclusive? */
	retail_price DECIMAL(5,2),	/* in Euro */
	total_sales DECIMAL(5,2),	/* in millions */
	fk_dev_id INT,
	fk_publisher_id INT,
	FOREIGN KEY (fk_dev_id) REFERENCES Developer(dev_id) ON DELETE SET NULL,	/* we're ok with not having data about the dev... */
	FOREIGN KEY (fk_publisher_id) REFERENCES Publisher(publisher_id) ON DELETE CASCADE	/* ...but not having a publisher is no bueno */
);

CREATE TABLE Player (
	player_id INT IDENTITY (1, 1) PRIMARY KEY,
	username VARCHAR(50) NOT NULL,
	email VARCHAR(100) NOT NULL UNIQUE,	/* only 1 account per email yes thank */
	join_date DATE DEFAULT GETDATE(),
	nso_subscription BIT NOT NULL,	/* are they a member of the NSO service? */
	age INT CHECK (age >= 12),	/* minimum age to create an acc is 12 */
	gender CHAR(1) DEFAULT 'O',	/* M for male, F for female, O for other */
	fk_fav_game INT,
	FOREIGN KEY (fk_fav_game) REFERENCES Game(game_id) ON DELETE SET NULL,	/* it's ok not to have a fav game */
);

CREATE TABLE Plays (
	fk_player_id INT,
	fk_game_id INT,
	play_time INT,	/* in hours */
	last_played DATE,
	PRIMARY KEY(fk_player_id, fk_game_id),	/* composite PK consisting of two FKs */
	FOREIGN KEY(fk_player_id) REFERENCES player(player_id) ON DELETE CASCADE,	/* entry gets deleted if player gets deleted */
	FOREIGN KEY(fk_game_id) REFERENCES game(game_id) ON DELETE CASCADE	/* entry gets deleted if game gets deleted */
);



-- POPULATING THE TABLES WITH DATA
-- insert data into the Publisher table
INSERT INTO Publisher (name, country)
	VALUES ('Nintendo', 'Japan');
INSERT INTO Publisher (name, country)
	VALUES ('The Pokemon Company', 'Japan');
INSERT INTO Publisher (name, country)
	VALUES ('Capcom', 'Japan');
INSERT INTO Publisher (name, country)
	VALUES ('Xbox Game Studios', 'USA');
INSERT INTO Publisher (name, country)
	VALUES ('Konami', 'Japan');
INSERT INTO Publisher (name, country)
	VALUES ('Innersloth', 'USA');
INSERT INTO Publisher (name, country)
	VALUES ('Ubisoft', 'France');
INSERT INTO Publisher (name, country)
	VALUES ('Bandai Namco Entertainment', 'Japan');
INSERT INTO Publisher (name, country)
	VALUES ('Square Enix', 'Japan');
INSERT INTO Publisher (name, country)
	VALUES ('Sega', 'Japan');


-- insert data into the Developer table
INSERT INTO Developer (name, founding_date, country)
	VALUES ('Nintendo EPD', '2015-09-16', 'Japan');
INSERT INTO Developer (name, founding_date, country)
	VALUES ('Bandai Namco Studios', '2012-04-02', 'Japan');
INSERT INTO Developer (name, founding_date, country)
	VALUES ('Game Freak', '1989-04-26', 'Japan');
INSERT INTO Developer (name, founding_date, country)
	VALUES ('Next Level Games', '2002-10-01', 'Canada');
INSERT INTO Developer (name, founding_date, country)
	VALUES ('NDcube', '2000-03-01', 'Japan');
INSERT INTO Developer (name, founding_date, country)
	VALUES ('Nintendo', '1889-09-23', 'Japan');
INSERT INTO Developer (name, founding_date, country)
	VALUES ('Capcom', '1979-05-30', 'Japan');
INSERT INTO Developer (name, founding_date, country)
	VALUES ('HAL Laboratory', '1980-02-21', 'Japan');
INSERT INTO Developer (name, founding_date, country)
	VALUES ('Grezzo', '2006-12-01', 'Japan');
INSERT INTO Developer (name, founding_date, country)
	VALUES ('Mojang Studios', '2009-01-01', 'Sweden');
INSERT INTO Developer (name, founding_date, country)
	VALUES ('Retro Studios', '1998-09-21', 'USA');
INSERT INTO Developer (name, founding_date, country)
	VALUES ('Camelot Software Planning', '1994-04-04', 'Japan');
INSERT INTO Developer (name, founding_date, country)
	VALUES ('Tantalus Media', '1994-01-01', 'Australia');
INSERT INTO Developer (name, founding_date, country)
	VALUES ('Intelligent Systems', '1986-12-01', 'Japan');
INSERT INTO Developer (name, founding_date, country)
	VALUES ('Omega Force', '1996-01-01', 'Japan');
INSERT INTO Developer (name, founding_date, country)
	VALUES ('Konami', '1969-03-21', 'Japan');
INSERT INTO Developer (name, founding_date, country)
	VALUES ('Good-Feel', '2005-10-03', 'Japan');
INSERT INTO Developer (name, founding_date, country)
	VALUES ('ArtePiazza', '1989-11-01', 'Japan');
INSERT INTO Developer (name, founding_date, country)
	VALUES ('Ubisoft', '1986-03-28', 'France');
INSERT INTO Developer (name, founding_date, country)
	VALUES ('Innersloth', '2015-01-01', 'USA');
INSERT INTO Developer (name, founding_date, country)
	VALUES ('Monolith Soft', '1999-10-01', 'Japan');
INSERT INTO Developer (name, founding_date, country)
	VALUES ('Arc System Works', '1988-05-12', 'Japan');
INSERT INTO Developer (name, founding_date, country)
	VALUES ('Eighting', '1993-03-15', 'Japan');
INSERT INTO Developer (name, founding_date, country)
	VALUES ('Square Enix', '2003-04-01', 'Japan');
INSERT INTO Developer (name, founding_date, country)
	VALUES ('Spike Chunsoft', '1984-04-09', 'Japan');
INSERT INTO Developer (name, founding_date, country)
	VALUES ('Dimps', '2000-03-06', 'Japan');
INSERT INTO Developer (name, founding_date, country)
	VALUES ('Velan Studios', '2016-11-01', 'USA');
INSERT INTO Developer (name, founding_date, country)
	VALUES ('CyberConnect2', '1996-02-16', 'Japan');
INSERT INTO Developer (name, founding_date, country)
	VALUES ('Team Ninja', '1995-01-01', 'Japan');
INSERT INTO Developer (name, founding_date, country)
	VALUES ('PlatinumGames', '2007-10-01', 'Japan');
INSERT INTO Developer (name, founding_date, country)
	VALUES ('FromSoftware', '1986-11-01', 'Japan');
INSERT INTO Developer (name, founding_date, country)
	VALUES ('Nintendo Software Technology', '1998-01-01', 'USA');
INSERT INTO Developer (name, founding_date, country)
	VALUES ('Atlus', '1986-04-07', 'Japan');
INSERT INTO Developer (name, founding_date, country)
	VALUES ('Sega', '1960-06-03', 'Japan');
INSERT INTO Developer (name, founding_date, country)
	VALUES ('Tose', '1979-11-01', 'Japan');
INSERT INTO Developer (name, founding_date, country)
	VALUES ('Imagineer', '1986-01-27', 'Japan');


-- insert data into the Game table
-- values as of 15/08/2024
INSERT INTO Game (name, release_date, genre, switch_only, retail_price, total_sales, fk_dev_id, fk_publisher_id)
	VALUES ('1-2-Switch', '2017-03-03', 'Party', 1, 49.99, 3.74, 1, 1);
INSERT INTO Game (name, release_date, genre, switch_only, retail_price, total_sales, fk_dev_id, fk_publisher_id)
	VALUES ('Among Us', '2020-12-15', 'Party', 0, 4.29, 3.20, 20, 6);
INSERT INTO Game (name, release_date, genre, switch_only, retail_price, total_sales, fk_dev_id, fk_publisher_id)
	VALUES ('Animal Crossing: New Horizons', '2020-03-20', 'Social simulation', 1, 59.99, 45.85, 1, 1);
INSERT INTO Game (name, release_date, genre, switch_only, retail_price, total_sales, fk_dev_id, fk_publisher_id)
	VALUES ('Arms', '2017-06-16', 'Fighting', 1, 59.99, 2.72, 1, 1);
INSERT INTO Game (name, release_date, genre, switch_only, retail_price, total_sales, fk_dev_id, fk_publisher_id)
	VALUES ('Astral Chain', '2019-08-30', 'Action-adventure', 1, 59.99, 1.33, 30, 1);
INSERT INTO Game (name, release_date, genre, switch_only, retail_price, total_sales, fk_dev_id, fk_publisher_id)
	VALUES ('Bayonetta', '2018-02-16', 'Action-adventure', 0, 29.99, 1.24, 30, 1);
INSERT INTO Game (name, release_date, genre, switch_only, retail_price, total_sales, fk_dev_id, fk_publisher_id)
	VALUES ('Bayonetta 2', '2018-02-16', 'Action-adventure', 0, 49.99, 1.23, 30, 1);
INSERT INTO Game (name, release_date, genre, switch_only, retail_price, total_sales, fk_dev_id, fk_publisher_id)
	VALUES ('Bayonetta 3', '2022-10-28', 'Action-adventure', 1, 59.99, 1.07, 30, 1);
INSERT INTO Game (name, release_date, genre, switch_only, retail_price, total_sales, fk_dev_id, fk_publisher_id)
	VALUES ('Big Brain Academy: Brain vs. Brain', '2021-12-03', 'Puzzle', 1, 29.99, 1.94, 1, 1);
INSERT INTO Game (name, release_date, genre, switch_only, retail_price, total_sales, fk_dev_id, fk_publisher_id)
	VALUES ('Captain Toad: Treasure Tracker', '2018-07-13', 'Action puzzle', 0, 39.99, 2.35, 1, 1);
INSERT INTO Game (name, release_date, genre, switch_only, retail_price, total_sales, fk_dev_id, fk_publisher_id)
	VALUES ('Clubhouse Games: 51 Worldwide Classics', '2020-06-05', 'Tabletop game', 1, 39.99, 4.64, 5, 1);
INSERT INTO Game (name, release_date, genre, switch_only, retail_price, total_sales, fk_dev_id, fk_publisher_id)
	VALUES ('Dark Souls Remastered', '2018-10-19', 'Action RPG', 0, 39.99, 1.15, 31, 8);
INSERT INTO Game (name, release_date, genre, switch_only, retail_price, total_sales, fk_dev_id, fk_publisher_id)
	VALUES ('Donkey Kong Country: Tropical Freeze', '2018-05-04', 'Platformer', 0, 59.99, 4.62, 11, 1);
INSERT INTO Game (name, release_date, genre, switch_only, retail_price, total_sales, fk_dev_id, fk_publisher_id)
	VALUES ('Dr Kawashima''s Brain Training for Nintendo Switch', '2019-12-27', 'Puzzle', 1, 26.99, 1.27, 1, 1);
INSERT INTO Game (name, release_date, genre, switch_only, retail_price, total_sales, fk_dev_id, fk_publisher_id)
	VALUES ('Dragon Ball FighterZ', '2018-09-27', 'Fighting', 0, 59.99, 2.43, 22, 8);
INSERT INTO Game (name, release_date, genre, switch_only, retail_price, total_sales, fk_dev_id, fk_publisher_id)
	VALUES ('Dragon Ball Xenoverse 2', '2017-09-07', 'Fighting', 0, 19.99, 1.82, 26, 8);
INSERT INTO Game (name, release_date, genre, switch_only, retail_price, total_sales, fk_dev_id, fk_publisher_id)
	VALUES ('Dragon Quest Monsters: The Dark Prince', '2023-12-01', 'RPG', 1, 59.99, 1.0, 35, 9);
INSERT INTO Game (name, release_date, genre, switch_only, retail_price, total_sales, fk_dev_id, fk_publisher_id)
	VALUES ('Dragon''s Dogma: Dark Arisen', '2019-04-23', 'RPG', 0, 29.99, 1.10, 7, 3);
INSERT INTO Game (name, release_date, genre, switch_only, retail_price, total_sales, fk_dev_id, fk_publisher_id)
	VALUES ('Fire Emblem Engage', '2023-01-20', 'Tactical RPG', 1, 59.99, 1.61, 14, 1);
INSERT INTO Game (name, release_date, genre, switch_only, retail_price, total_sales, fk_dev_id, fk_publisher_id)
	VALUES ('Fire Emblem Warriors: Three Hopes', '2022-06-24', 'Hack and slash', 1, 59.99, 1.0, 15, 1);
INSERT INTO Game (name, release_date, genre, switch_only, retail_price, total_sales, fk_dev_id, fk_publisher_id)
	VALUES ('Fire Emblem: Three Houses', '2019-07-26', 'Tactical RPG', 1, 59.99, 4.12, 14, 1);
INSERT INTO Game (name, release_date, genre, switch_only, retail_price, total_sales, fk_dev_id, fk_publisher_id)
	VALUES ('Fitness Boxing', '2018-12-20', 'Exergame', 1, 29.99, 1.0, 36, 1);
INSERT INTO Game (name, release_date, genre, switch_only, retail_price, total_sales, fk_dev_id, fk_publisher_id)
	VALUES ('Fitness Boxing 2: Rhythm and Exercise', '2020-12-04', 'Exergame', 1, 49.99, 1.0, 36, 1);
INSERT INTO Game (name, release_date, genre, switch_only, retail_price, total_sales, fk_dev_id, fk_publisher_id)
	VALUES ('Game Builder Garage', '2021-06-11', 'Programming', 1, 29.99, 1.15, 1, 1);
INSERT INTO Game (name, release_date, genre, switch_only, retail_price, total_sales, fk_dev_id, fk_publisher_id)
	VALUES ('Hyrule Warriors: Age of Calamity', '2020-11-20', 'Hack and slash', 1, 59.99, 4.0, 15, 1);
INSERT INTO Game (name, release_date, genre, switch_only, retail_price, total_sales, fk_dev_id, fk_publisher_id)
	VALUES ('Kirby and the Forgotten Land', '2022-03-31', 'Platformer', 1, 59.99, 7.52, 8, 1);
INSERT INTO Game (name, release_date, genre, switch_only, retail_price, total_sales, fk_dev_id, fk_publisher_id)
	VALUES ('Kirby Star Allies', '2018-03-16', 'Platformer', 1, 59.99, 4.38, 8, 1);
INSERT INTO Game (name, release_date, genre, switch_only, retail_price, total_sales, fk_dev_id, fk_publisher_id)
	VALUES ('Kirby''s Return to Dream Land Deluxe', '2018-03-16', 'Platformer', 0, 59.99, 1.46, 8, 1);
INSERT INTO Game (name, release_date, genre, switch_only, retail_price, total_sales, fk_dev_id, fk_publisher_id)
	VALUES ('Luigi''s Mansion 2 HD', '2024-06-27', 'Action-adventure', 0, 59.99, 1.19, 4, 1);
INSERT INTO Game (name, release_date, genre, switch_only, retail_price, total_sales, fk_dev_id, fk_publisher_id)
	VALUES ('Luigi''s Mansion 3', '2019-10-31', 'Action-adventure', 1, 59.99, 14.25, 4, 1);
INSERT INTO Game (name, release_date, genre, switch_only, retail_price, total_sales, fk_dev_id, fk_publisher_id)
	VALUES ('Mario & Sonic at the Olympic Games Tokyo 2020', '2019-11-01', 'Sports', 1, 59.99, 1.02, 34, 10);
INSERT INTO Game (name, release_date, genre, switch_only, retail_price, total_sales, fk_dev_id, fk_publisher_id)
	VALUES ('Mario + Rabbids Kingdom Battle', '2017-08-29', 'Tactical RPG', 1, 39.99, 2.0, 19, 7);
INSERT INTO Game (name, release_date, genre, switch_only, retail_price, total_sales, fk_dev_id, fk_publisher_id)
	VALUES ('Mario + Rabbids Sparks of Hope', '2022-10-20', 'Tactical RPG', 1, 59.99, 3.0, 19, 7);
INSERT INTO Game (name, release_date, genre, switch_only, retail_price, total_sales, fk_dev_id, fk_publisher_id)
	VALUES ('Mario Golf: Super Rush', '2021-06-25', 'Sports', 1, 59.99, 2.48, 12, 1);
INSERT INTO Game (name, release_date, genre, switch_only, retail_price, total_sales, fk_dev_id, fk_publisher_id)
	VALUES ('Mario Kart 8 Deluxe', '2017-04-28', 'Kart racing', 1, 59.99, 62.90, 1, 1);
INSERT INTO Game (name, release_date, genre, switch_only, retail_price, total_sales, fk_dev_id, fk_publisher_id)
	VALUES ('Mario Kart Live: Home Circuit', '2020-10-16', 'Kart racing', 1, 0.99, 1.73, 27, 1);
INSERT INTO Game (name, release_date, genre, switch_only, retail_price, total_sales, fk_dev_id, fk_publisher_id)
	VALUES ('Mario Party Superstars', '2021-10-29', 'Party', 1, 59.99, 12.89, 5, 1);
INSERT INTO Game (name, release_date, genre, switch_only, retail_price, total_sales, fk_dev_id, fk_publisher_id)
	VALUES ('Mario Strikers: Battle League', '2022-06-10', 'Sports', 1, 59.99, 2.54, 4, 1);
INSERT INTO Game (name, release_date, genre, switch_only, retail_price, total_sales, fk_dev_id, fk_publisher_id)
	VALUES ('Mario Tennis Aces', '2018-06-22', 'Sports', 1, 59.99, 4.50, 12, 1);
INSERT INTO Game (name, release_date, genre, switch_only, retail_price, total_sales, fk_dev_id, fk_publisher_id)
	VALUES ('Mario vs. Donkey Kong', '2024-02-16', 'Puzzle-platform', 0, 49.99, 1.12, 32, 1);
INSERT INTO Game (name, release_date, genre, switch_only, retail_price, total_sales, fk_dev_id, fk_publisher_id)
	VALUES ('Marvel Ultimate Alliance 3: The Black Order', '2019-07-19', 'Action RPG', 1, 49.99, 1.60, 29, 1);
INSERT INTO Game (name, release_date, genre, switch_only, retail_price, total_sales, fk_dev_id, fk_publisher_id)
	VALUES ('Metroid Dread', '2021-10-08', 'Action-adventure', 1, 59.99, 3.07, 1, 1);
INSERT INTO Game (name, release_date, genre, switch_only, retail_price, total_sales, fk_dev_id, fk_publisher_id)
	VALUES ('Metroid Prime Remastered', '2023-02-08', 'Action-adventure', 1, 39.99, 1.09, 11, 1);
INSERT INTO Game (name, release_date, genre, switch_only, retail_price, total_sales, fk_dev_id, fk_publisher_id)
	VALUES ('Miitopia', '2021-05-21', 'RPG', 0, 49.99, 1.79, 9, 1);
INSERT INTO Game (name, release_date, genre, switch_only, retail_price, total_sales, fk_dev_id, fk_publisher_id)
	VALUES ('Minecraft', '2017-05-11', 'Sandbox', 0, 29.99, 5.67, 10, 4);
INSERT INTO Game (name, release_date, genre, switch_only, retail_price, total_sales, fk_dev_id, fk_publisher_id)
	VALUES ('Momotaro Dentetsu World', '2023-11-16', 'Board game', 1, 49.99, 1.0, 16, 5);
INSERT INTO Game (name, release_date, genre, switch_only, retail_price, total_sales, fk_dev_id, fk_publisher_id)
	VALUES ('Momotaro Dentetsu', '2020-11-19', 'Board game', 1, 39.99, 4.0, 16, 5);
INSERT INTO Game (name, release_date, genre, switch_only, retail_price, total_sales, fk_dev_id, fk_publisher_id)
	VALUES ('Monster Hunter Rise', '2021-03-26', 'Action RPG', 0, 39.99, 8.02, 7, 3);
INSERT INTO Game (name, release_date, genre, switch_only, retail_price, total_sales, fk_dev_id, fk_publisher_id)
	VALUES ('Naruto Shippudden: Ultimate Ninja Storm Trilogy', '2017-07-27', 'Fighting', 0, 49.99, 1.73, 28, 8);
INSERT INTO Game (name, release_date, genre, switch_only, retail_price, total_sales, fk_dev_id, fk_publisher_id)
	VALUES ('New Pokémon Snap', '2021-04-30', 'Photography', 1, 59.99, 2.74, 2, 2);
INSERT INTO Game (name, release_date, genre, switch_only, retail_price, total_sales, fk_dev_id, fk_publisher_id)
	VALUES ('New Super Mario Bros. U Deluxe', '2019-01-11', 'Platformer', 0, 59.99, 17.61, 1, 1);
INSERT INTO Game (name, release_date, genre, switch_only, retail_price, total_sales, fk_dev_id, fk_publisher_id)
	VALUES ('Nintendo Labo Toy-Con 01: Variety Kit', '2018-04-20', 'Construction kit', 1, 69.99, 1.42, 1, 1);
INSERT INTO Game (name, release_date, genre, switch_only, retail_price, total_sales, fk_dev_id, fk_publisher_id)
	VALUES ('Nintendo Switch Sports', '2022-04-29', 'Sports', 1, 39.99, 13.11, 1, 1);
INSERT INTO Game (name, release_date, genre, switch_only, retail_price, total_sales, fk_dev_id, fk_publisher_id)
	VALUES ('Octopath Traveler', '2018-07-13', 'RPG', 0, 59.99, 2.16, 24, 9);
INSERT INTO Game (name, release_date, genre, switch_only, retail_price, total_sales, fk_dev_id, fk_publisher_id)
	VALUES ('Paper Mario: The Origami King', '2020-07-17', 'RPG', 1, 59.99, 3.47, 14, 1);
INSERT INTO Game (name, release_date, genre, switch_only, retail_price, total_sales, fk_dev_id, fk_publisher_id)
	VALUES ('Paper Mario: The Thousand-Year Door', '2024-05-23', 'RPG', 0, 59.99, 1.76, 14, 1);
INSERT INTO Game (name, release_date, genre, switch_only, retail_price, total_sales, fk_dev_id, fk_publisher_id)
	VALUES ('Pikmin 3 Deluxe', '2020-10-30', 'RTS', 0, 59.99, 2.40, 23, 1);
INSERT INTO Game (name, release_date, genre, switch_only, retail_price, total_sales, fk_dev_id, fk_publisher_id)
	VALUES ('Pikmin 4', '2023-07-21', 'RTS', 1, 59.99, 3.48, 1, 1);
INSERT INTO Game (name, release_date, genre, switch_only, retail_price, total_sales, fk_dev_id, fk_publisher_id)
	VALUES ('Pokémon Brilliant Diamond and Shining Pearl', '2021-11-19', 'RPG', 1, 59.99, 15.06, 6, 2);
INSERT INTO Game (name, release_date, genre, switch_only, retail_price, total_sales, fk_dev_id, fk_publisher_id)
	VALUES ('Pokémon Legends: Arceus', '2022-01-28', 'Action RPG', 1, 59.99, 14.83, 3, 2);
INSERT INTO Game (name, release_date, genre, switch_only, retail_price, total_sales, fk_dev_id, fk_publisher_id)
	VALUES ('Pokémon Mystery Dungeon: Rescue Team DX', '2020-03-06', 'Roguelike', 1, 59.99, 1.99, 25, 1);
INSERT INTO Game (name, release_date, genre, switch_only, retail_price, total_sales, fk_dev_id, fk_publisher_id)
	VALUES ('Pokémon Scarlet and Violet', '2022-11-18', 'RPG', 1, 59.99, 25.29, 3, 2);
INSERT INTO Game (name, release_date, genre, switch_only, retail_price, total_sales, fk_dev_id, fk_publisher_id)
	VALUES ('Pokémon Sword and Shield', '2019-11-15', 'RPG', 1, 59.99, 26.35, 3, 2);
INSERT INTO Game (name, release_date, genre, switch_only, retail_price, total_sales, fk_dev_id, fk_publisher_id)
	VALUES ('Pokémon: Let''s Go, Pikachu! and Let''s Go, Eevee!', '2018-11-16', 'RPG', 1, 59.99, 15.07, 3, 2);
INSERT INTO Game (name, release_date, genre, switch_only, retail_price, total_sales, fk_dev_id, fk_publisher_id)
	VALUES ('Pokkén Tournament DX', '2017-09-22', 'Fighting', 0, 59.99, 1.54, 2, 2);
INSERT INTO Game (name, release_date, genre, switch_only, retail_price, total_sales, fk_dev_id, fk_publisher_id)
	VALUES ('Princess Peach: Showtime!', '2024-03-22', 'Action-adventure', 1, 59.99, 1.30, 17, 1);
INSERT INTO Game (name, release_date, genre, switch_only, retail_price, total_sales, fk_dev_id, fk_publisher_id)
	VALUES ('Resident Evil 6', '2019-10-29', 'Survival horror', 0, 19.99, 1.0, 7, 3);
INSERT INTO Game (name, release_date, genre, switch_only, retail_price, total_sales, fk_dev_id, fk_publisher_id)
	VALUES ('Resident Evil: Revelations Collection', '2017-11-27', 'Survival horror', 0, 29.99, 1.50, 7, 3);
INSERT INTO Game (name, release_date, genre, switch_only, retail_price, total_sales, fk_dev_id, fk_publisher_id)
	VALUES ('Ring Fit Adventure', '2019-10-18', 'Exergame', 1, 79.99, 15.38, 1, 1);
INSERT INTO Game (name, release_date, genre, switch_only, retail_price, total_sales, fk_dev_id, fk_publisher_id)
	VALUES ('Shin Megami Tensei V', '2021-11-11', 'RPG', 0, 59.99, 1.10, 33, 10);
INSERT INTO Game (name, release_date, genre, switch_only, retail_price, total_sales, fk_dev_id, fk_publisher_id)
	VALUES ('Splatoon 2', '2017-07-21', 'Third-person shooter', 1, 59.99, 13.60, 1, 1);
INSERT INTO Game (name, release_date, genre, switch_only, retail_price, total_sales, fk_dev_id, fk_publisher_id)
	VALUES ('Splatoon 3', '2022-09-09', 'Third-person shooter', 1, 59.99, 11.96, 1, 1);
INSERT INTO Game (name, release_date, genre, switch_only, retail_price, total_sales, fk_dev_id, fk_publisher_id)
	VALUES ('Super Mario 3D All-Stars', '2020-09-18', 'Platformer', 1, 59.99, 9.07, 6, 1);
INSERT INTO Game (name, release_date, genre, switch_only, retail_price, total_sales, fk_dev_id, fk_publisher_id)
	VALUES ('Super Mario 3D World + Bowser''s Fury', '2021-02-12', 'Platformer', 0, 59.99, 13.47, 1, 1);
INSERT INTO Game (name, release_date, genre, switch_only, retail_price, total_sales, fk_dev_id, fk_publisher_id)
	VALUES ('Super Mario Bros. Wonder', '2023-10-20', 'Platformer', 1, 59.99, 13.44, 1, 1);
INSERT INTO Game (name, release_date, genre, switch_only, retail_price, total_sales, fk_dev_id, fk_publisher_id)
	VALUES ('Super Mario Maker 2', '2019-06-28', 'Platformer', 1, 59.99, 8.42, 1, 1);
INSERT INTO Game (name, release_date, genre, switch_only, retail_price, total_sales, fk_dev_id, fk_publisher_id)
	VALUES ('Super Mario Odyssey', '2017-10-27', 'Platformer', 1, 59.99, 28.21, 1, 1);
INSERT INTO Game (name, release_date, genre, switch_only, retail_price, total_sales, fk_dev_id, fk_publisher_id)
	VALUES ('Super Mario Party', '2018-10-05', 'Party', 1, 59.99, 20.84, 5, 1);
INSERT INTO Game (name, release_date, genre, switch_only, retail_price, total_sales, fk_dev_id, fk_publisher_id)
	VALUES ('Super Mario RPG', '2023-11-17', 'RPG', 1, 59.99, 3.31, 18, 1);
INSERT INTO Game (name, release_date, genre, switch_only, retail_price, total_sales, fk_dev_id, fk_publisher_id)
	VALUES ('Super Smash Bros. Ultimate', '2018-12-07', 'Fighting', 1, 69.99, 34.66, 2, 1);
INSERT INTO Game (name, release_date, genre, switch_only, retail_price, total_sales, fk_dev_id, fk_publisher_id)
	VALUES ('Taiko no Tatsujin: Drum ''n'' Fun!', '2018-07-19', 'Rhythm', 1, 49.99, 2.24, 2, 8);
INSERT INTO Game (name, release_date, genre, switch_only, retail_price, total_sales, fk_dev_id, fk_publisher_id)
	VALUES ('The Legend of Zelda: Breath of the Wild', '2017-03-03', 'Action-adventure', 0, 69.99, 32.05, 1, 1);
INSERT INTO Game (name, release_date, genre, switch_only, retail_price, total_sales, fk_dev_id, fk_publisher_id)
	VALUES ('The Legend of Zelda: Link''s Awakening', '2019-09-20', 'Action-adventure', 1, 59.99, 6.46, 9, 1);
INSERT INTO Game (name, release_date, genre, switch_only, retail_price, total_sales, fk_dev_id, fk_publisher_id)
	VALUES ('The Legend of Zelda: Skyward Sword HD', '2021-07-16', 'Action-adventure', 0, 59.99, 4.15, 13, 1);
INSERT INTO Game (name, release_date, genre, switch_only, retail_price, total_sales, fk_dev_id, fk_publisher_id)
	VALUES ('The Legend of Zelda: Tears of the Kingdom', '2023-05-12', 'Action-adventure', 1, 69.99, 20.80, 1, 1);
INSERT INTO Game (name, release_date, genre, switch_only, retail_price, total_sales, fk_dev_id, fk_publisher_id)
	VALUES ('WarioWare: Get It Together!', '2021-09-10', 'Party', 1, 49.99, 1.34, 14, 1);
INSERT INTO Game (name, release_date, genre, switch_only, retail_price, total_sales, fk_dev_id, fk_publisher_id)
	VALUES ('Xenoblade Chronicles 2', '2017-12-01', 'Action RPG', 1, 59.99, 2.70, 21, 1);
INSERT INTO Game (name, release_date, genre, switch_only, retail_price, total_sales, fk_dev_id, fk_publisher_id)
	VALUES ('Xenoblade Chronicles 3', '2022-07-29', 'Action RPG', 1, 59.99, 1.86, 21, 1);
INSERT INTO Game (name, release_date, genre, switch_only, retail_price, total_sales, fk_dev_id, fk_publisher_id)
	VALUES ('Xenoblade Chronicles: Definitive Edition', '2020-05-29', 'Action RPG', 0, 59.99, 1.88, 21, 1);
INSERT INTO Game (name, release_date, genre, switch_only, retail_price, total_sales, fk_dev_id, fk_publisher_id)
	VALUES ('Yoshi''s Crafted World', '2019-03-29', 'Platformer', 1, 59.99, 3.35, 17, 1);