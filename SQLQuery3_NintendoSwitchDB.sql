USE NintendoSwitchDB;
-- Here are 20 queries using the Nintendo Switch DB

-- 1) find the top 10 developers by total sales
SELECT TOP 10 d.name AS Developer, SUM(g.total_sales) AS TotalSales
FROM Developer d
JOIN Game g ON d.dev_id = g.fk_dev_id
GROUP BY d.name
ORDER BY TotalSales DESC;

-- 2) find the top 25 most played games (by hours)
SELECT TOP 25 g.name AS Game, SUM(p.play_time) AS TotalPlayTime
FROM Game g
JOIN Plays p ON g.game_id = p.fk_game_id
GROUP BY g.name
ORDER BY TotalPlayTime DESC;

-- 3) find the average earnings per game per publisher
SELECT p.name AS Publisher, 
       CAST(ROUND(AVG(g.total_sales * 1000000 * g.retail_price), 2) AS DECIMAL(20, 2)) AS AvgEarnings
FROM Publisher p
JOIN Game g ON p.publisher_id = g.fk_publisher_id
GROUP BY p.name;

-- 4) find the most sold game per category/genre
WITH GenreMaxSales AS (
    SELECT genre, MAX(total_sales) AS MaxSales
    FROM Game
    GROUP BY genre
)
SELECT g.genre AS Genre, g.name AS Game, g.total_sales AS Sales
FROM Game g
JOIN GenreMaxSales ms ON g.genre = ms.genre AND g.total_sales = ms.MaxSales
ORDER BY g.genre;

-- 5) find the total earnings for all games
SELECT CAST(ROUND(SUM(g.total_sales * 1000000 * g.retail_price), 2) AS DECIMAL(20, 2)) AS TotalEarnings
FROM Game g;

-- 6) find the average price per game for all games sold
SELECT CAST(ROUND(AVG(g.retail_price), 2) AS DECIMAL(20, 2)) AS AvgPrice
FROM Game g
WHERE g.total_sales > 0;

-- 7) find all games published in the past year
SELECT g.name AS Game, g.release_date AS ReleaseDate
FROM Game g
WHERE g.release_date >= DATEADD(year, -1, GETDATE());

-- 8) find the average playtime for users grouped by country
SELECT pl.country AS Country, AVG(p.play_time) AS AvgPlayTime
FROM Player pl
JOIN Plays p ON pl.player_id = p.fk_player_id
GROUP BY pl.country
ORDER BY AvgPlayTime DESC;

-- 9) find the 10 games that haven’t been played for the longest time
SELECT TOP 10 g.name AS Game, MAX(p.last_played) AS LastPlayed
FROM Game g
JOIN Plays p ON g.game_id = p.fk_game_id
WHERE p.last_played IS NOT NULL
GROUP BY g.name
ORDER BY LastPlayed ASC;

-- 10) find the most favourited genre in each country
WITH GenreCounts AS (
    SELECT pl.country AS Country, 
           g.genre AS Genre, 
           COUNT(pl.player_id) AS PlayerCount,
           ROW_NUMBER() OVER (PARTITION BY pl.country ORDER BY COUNT(pl.player_id) DESC) AS RowNum
    FROM Player pl
    JOIN Game g ON pl.fk_fav_game = g.game_id
    GROUP BY pl.country, g.genre
)
SELECT Country, Genre, PlayerCount
FROM GenreCounts
WHERE RowNum = 1;

-- 11) find the total number of players with an active NSO subscription per country
SELECT pl.country AS Country, COUNT(pl.player_id) AS SubscribedPlayers
FROM Player pl
WHERE pl.nso_subscription = 1
GROUP BY pl.country
ORDER BY SubscribedPlayers DESC;

-- 12) find which developers have released games in the last 6 months
SELECT g.name AS Game, g.release_date AS ReleaseDate, d.name AS Developer
FROM Game g
JOIN Developer d ON g.fk_dev_id = d.dev_id
WHERE g.release_date >= DATEADD(month, -6, GETDATE());

-- 13) find the number of players who have played more than 600 hours
SELECT COUNT(*) AS PlayersOver600Hours
FROM (
    SELECT p.fk_player_id, SUM(p.play_time) AS TotalPlaytime
    FROM Plays p
    GROUP BY p.fk_player_id
    HAVING SUM(p.play_time) > 600
) AS PlayerPlaytimes;

-- 14) find all genres
SELECT DISTINCT genre
FROM Game;

-- 15) find games that are not published by specific publishers
SELECT g.name AS Game, p.name AS Publisher
FROM Game g
JOIN Publisher p ON g.fk_publisher_id = p.publisher_id
WHERE p.name NOT IN ('Nintendo', 'Bandai Namco Entertainment', 'The Pokemon Company');

-- 16) find all developers whose names start with 'N'
SELECT name
FROM Developer
WHERE name LIKE 'N%';

-- 17) find publishers with an average game price greater than EUR 50
SELECT p.name AS Publisher, AVG(g.retail_price) AS AvgPrice
FROM Publisher p
JOIN Game g ON p.publisher_id = g.fk_publisher_id
GROUP BY p.name
HAVING AVG(g.retail_price) > 50;

-- 18) check if there are any games with sales over 20 million copies by a specific developer
SELECT g.name AS Game
FROM Game g
WHERE EXISTS (
    SELECT 1
    FROM Developer d
    WHERE d.dev_id = g.fk_dev_id
    AND g.total_sales > 20.0
    AND d.name = 'Nintendo EPD'
);

-- 19) find the most played game for each gender
WITH GamePlaytime AS (
    SELECT pl.gender AS Gender, 
           g.name AS Game, 
           SUM(p.play_time) AS TotalPlaytime
    FROM Player pl
    JOIN Plays p ON pl.player_id = p.fk_player_id
    JOIN Game g ON p.fk_game_id = g.game_id
    GROUP BY pl.gender, g.name
),
RankedGames AS (
    SELECT Gender, 
           Game, 
           TotalPlaytime,
           ROW_NUMBER() OVER (PARTITION BY Gender ORDER BY TotalPlaytime DESC) AS Rank
    FROM GamePlaytime
)
SELECT Gender, 
       Game, 
       TotalPlaytime
FROM RankedGames
WHERE Rank = 1;

-- 20) find the genre with the highest total sales
SELECT TOP 1 g.genre AS Genre, 
            SUM(g.total_sales * 1000000) AS TotalSales
FROM Game g
GROUP BY g.genre
ORDER BY TotalSales DESC;
