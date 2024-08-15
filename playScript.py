# a script that generates between 5 and 15 entries for playtime for each player (duplicates allowed)

import random
from datetime import datetime, timedelta

# define the number of players and games
user_ids = range(1000, 1501)  # users from 1000 to 1500
games = [
    (1, 50), (2, 45), (3, 40), (4, 35), (5, 30),
    (6, 25), (7, 20), (8, 15), (9, 10), (10, 5),
    (11, 30), (12, 25), (13, 40), (14, 35), (15, 45),
    (16, 20), (17, 15), (18, 10), (19, 50), (20, 45),
    (21, 40), (22, 35), (23, 30), (24, 25), (25, 20),
    (26, 15), (27, 50), (28, 45), (29, 30), (30, 20),
    (31, 40), (32, 25), (33, 10), (34, 15), (35, 5),
    (40, 60),  # popular favourite games (ID 40)
]


# function to generate a random date between two dates
def random_date(start, end):
    return start + timedelta(days=random.randint(0, int((end - start).days)))


# define the date range for play sessions
start_date = datetime(2017, 3, 3)
end_date = datetime(2024, 8, 15)

# generate SQL for Plays table
sql_statements = []

for user_id in user_ids:
    num_entries = random.randint(5, 15)  # number of play sessions per user
    fav_game_id = random.choice(games)[0]  # randomly choose a favourite game for the user

    for _ in range(num_entries):
        game_id = random.choices([game[0] for game in games], weights=[game[1] for game in games], k=1)[0]
        if random.random() < 0.15:  # 15% chance to play the favorite game
            game_id = fav_game_id

        play_time = random.randint(1, 100)  # play time in hours (between 1 and 100 hours)
        play_date = random_date(start_date, end_date).strftime('%Y-%m-%d')

        sql = f"INSERT INTO Plays (fk_player_id, fk_game_id, play_time, last_played) VALUES ({user_id}, {game_id}, {play_time}, '{play_date}');"
        sql_statements.append(sql)

# output the SQL statements
for statement in sql_statements:
    print(statement)
