USE NintendoSwitchDB;

-- in this file we're creating the tables that our Nintendo SWitch DB consists of

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
	retail_price DECIMAL(5,2),
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