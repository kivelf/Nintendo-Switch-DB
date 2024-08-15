# a script that generates 500 users for our DB

import random
import datetime

# define the countries
countries = [
    'USA', 'Japan', 'UK', 'Germany', 'France', 'Canada', 'Australia',
    'Spain', 'Italy', 'Netherlands', 'Brazil', 'Mexico', 'South Korea',
    'China', 'Sweden', 'Russia', 'India', 'Denmark', 'Bulgaria', 'Greece'
]

# sample games and their IDs from the Game table (with a slight bias towards higher-selling games)
game_ids = [
    3, 27, 40, 19, 9, 45, 25, 13, 22, 11, 34, 2, 20, 7, 28, 5, 15, 8, 32, 1
]
# higher sales games have multiple entries for a higher chance of being selected
biased_game_ids = game_ids + [3, 3, 3, 27, 27, 40, 40]


# function to generate random email
def generate_email(username):
    domains = ["gmail.com", "yahoo.com", "hotmail.com", "nintendo.com", "outlook.com"]
    return f"{username.lower()}@{random.choice(domains)}"


# generate 500 players
players = []
for i in range(1000, 1501):
    username = f"user{i}"
    email = generate_email(username)
    join_date = datetime.date(2017, 3, 3) + datetime.timedelta(days=random.randint(0, 2555))
    country = random.choice(countries)
    nso_subscription = random.choice([0, 1])
    age = random.randint(12, 60)
    gender = random.choices(['M', 'F', 'O'], weights=[47, 47, 6])[0]
    fk_fav_game = random.choice(biased_game_ids)

    player_entry = f"INSERT INTO Player (username, email, join_date, country, nso_subscription, age, gender, fk_fav_game) VALUES ('{username}', '{email}', '{join_date}', '{country}', {nso_subscription}, {age}, '{gender}', {fk_fav_game});"

    players.append(player_entry)

# print out the SQL insert statements for all the players
for player in players:
    print(player)
