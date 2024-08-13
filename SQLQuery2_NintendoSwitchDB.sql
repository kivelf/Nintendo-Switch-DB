USE NintendoSwitchDB
GO

-- in this file we're creating views, stored procedures and triggers for our Nintendo SWitch DB

-- VIEWS
-- view 1: top-selling games
CREATE OR ALTER VIEW TopSellingGames AS
SELECT 
    name AS GameName, 
    total_sales AS SalesInMillions,
    CASE
        WHEN total_sales > 10 THEN 'Blockbuster'
        WHEN total_sales BETWEEN 5 AND 10 THEN 'Hit'
        ELSE 'Average'
    END AS SalesCategory
FROM Game
ORDER BY total_sales DESC;
GO


-- view 2: players and their favourite games
CREATE OR ALTER VIEW PlayerFavourites AS
SELECT TOP 50 
    p.username, 
    g.name AS FavouriteGame
FROM Player p
LEFT JOIN Game g ON p.fk_fav_game = g.game_id
ORDER BY p.player_id;
GO


-- view 3: developer game list
CREATE OR ALTER VIEW DeveloperGameList AS
SELECT d.name AS DeveloperName, g.name AS GameName, g.release_date
FROM Developer d
JOIN Game g ON d.dev_id = g.fk_dev_id
ORDER BY d.name, g.release_date;
GO



-- STORED PROCEDURES
-- stored procedure 1: add new game
CREATE OR ALTER PROCEDURE AddNewGame
    @name VARCHAR(100),
    @release_date DATE,
    @genre VARCHAR(25),
    @switch_only BIT,
    @retail_price DECIMAL(5,2),
    @fk_dev_id INT,
    @fk_publisher_id INT
AS
BEGIN
    INSERT INTO Game (name, release_date, genre, switch_only, retail_price, total_sales, fk_dev_id, fk_publisher_id)
    VALUES (@name, @release_date, @genre, @switch_only, @retail_price, 0, @fk_dev_id, @fk_publisher_id);
END;
GO


-- stored procedure 2: search players (with prevention against SQL injection)
CREATE OR ALTER PROCEDURE SearchPlayerByUsername
    @username NVARCHAR(50)
AS
BEGIN
    -- using parameterised queries to prevent SQL injection
    SELECT player_id, username, email, join_date, nso_subscription, age, gender
    FROM Player
    WHERE username = @username;
END;
GO



-- TRIGGERS
-- trigger 1: preventing the deletion of a game with high sales
CREATE OR ALTER TRIGGER PreventHighSalesGameDeletion
ON Game
AFTER DELETE -- checks if the game has high sales and then rolls back the transaction if it does
-- this approach doesn't interfere with the cascading delete functionality of the table
AS
BEGIN
    IF EXISTS (SELECT * FROM deleted WHERE total_sales > 10)
    BEGIN
        RAISERROR('Cannot delete a game with more than 10 million sales!', 16, 1);
        ROLLBACK TRANSACTION;
    END
END;
GO


-- trigger 2: update a developer's country based on game release (with conditionals)
CREATE OR ALTER TRIGGER UpdateDeveloperCountry
ON Game
AFTER UPDATE
AS
BEGIN
    DECLARE @dev_id INT;
    DECLARE @release_date DATE;

    SET @dev_id = (SELECT fk_dev_id FROM inserted);
    SET @release_date = (SELECT release_date FROM inserted);

    IF @release_date < '2000-01-01'
    BEGIN
        UPDATE Developer
        SET country = 'Unknown'
        WHERE dev_id = @dev_id;
    END
    ELSE IF @release_date >= '2000-01-01' AND @release_date < '2010-01-01'
    BEGIN
        UPDATE Developer
        SET country = 'Global'
        WHERE dev_id = @dev_id;
    END
    ELSE
    BEGIN
        UPDATE Developer
        SET country = 'Modern'
        WHERE dev_id = @dev_id;
    END
END;
GO



-- TESTING VIEWS
-- test view 1: top-selling games
SELECT * FROM TopSellingGames;
GO

-- test view 2: players and their favourite games
SELECT * FROM PlayerFavourites;
GO

-- test view 3: developer game list
SELECT * FROM DeveloperGameList;
GO



-- TESTING STORED PROCEDURES
-- test stored procedure 1: add new game
EXEC AddNewGame 'New Game', '2024-01-01', 'Action', 1, 59.99, 1, 1;
GO

-- test stored procedure 2: search players
EXEC SearchPlayerByUsername 'Player123';
GO



-- TESTING TRIGGERS
-- test trigger 1: preventing the deletion of a game with high sales
-- attempts to delete a game with high sales (this should fail)
DELETE FROM Game WHERE game_id = 1;
GO

-- checks the games list to confirm that the high-sales game was not deleted
SELECT * FROM Game;
GO


-- test trigger 2: update a developer's country based on game release
UPDATE Game SET release_date = '1995-01-01' WHERE game_id = 1;
SELECT * FROM Developer WHERE dev_id = 1;
GO