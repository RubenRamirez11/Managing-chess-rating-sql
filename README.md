# Chess ELO System – PostgreSQL (Cloud)

This project implements a simple chess rating system using **PostgreSQL** hosted in the cloud (Supabase).
The project demonstrates the use of:
- Cloud databases (Supabase)
- SQL data modeling
- PL/pgSQL procedural logic
- Time-ordered data processing

## Features

* Cloud database (PostgreSQL)
* Players table with demographic information
* Match history including wins, losses, and draws
* Custom ELO update rule
* Iterative ELO calculation using PL/pgSQL loops
* Sequential rating updates based on match date

## Database Schema

**usuarios**
- id_usuario (PK)
- nombre_usuario
- edad
- fecha_registro
- nacionalidad
- elo

**partidas**
- id_partida (PK)
- id_blancas (FK → usuarios)
- id_negras (FK → usuarios)
- ganador (FK → usuarios, NULL if draw)
- fecha_partida


## Dataset Summary

- 20 players
- 40 matches
- 7 draws
- Ratings updated sequentially based on match history

## ELO Update Logic

After each match:
* If the result is expected (higher-rated player wins):
  → ±10 points
* If the lower-rated player wins (upset):
  → max(10, 10% of rating difference)
* Draws:
  → No rating change

Matches are processed **chronologically** to simulate real rating evolution.

## Project Structure

```
sql/
│
├── 01_create_tables_and_data.sql   -- Tables and sample data
├── 02_update_elo.sql               -- Sequential ELO update procedure
└── 03_analysis_queries.sql         -- Post-update analysis

```

## Technologies

* PostgreSQL
* Supabase (cloud database)
* SQL / PLpgSQL

## Results

Key query results are shown: 

**Initial player rankings**

| id_usuario | nombre_usuario  | edad | fecha_registro | nacionalidad | elo  |
| ---------- | --------------- | ---- | -------------- | ------------ | ---- |
| 20         | FutureGM        | 18   | 2026-02-11     | India        | 2200 |
| 8          | EndgamePro      | 29   | 2026-02-11     | Brazil       | 2100 |
| 14         | PositionalMind  | 44   | 2026-02-11     | UK           | 2050 |
| 11         | SlowThinker     | 38   | 2026-02-11     | Germany      | 1950 |
| 19         | ClassicPlayer   | 40   | 2026-02-11     | Canada       | 1900 |
| 3          | KnightMaster    | 32   | 2026-02-11     | USA          | 1850 |
| 13         | CheckmateHunter | 31   | 2026-02-11     | Italy        | 1820 |
| 10         | BlitzKing       | 27   | 2026-02-11     | Peru         | 1780 |
| 4          | QueenGambit     | 25   | 2026-02-11     | Spain        | 1720 |
| 18         | BulletMonster   | 23   | 2026-02-11     | USA          | 1700 |
| 12         | OpeningNerd     | 24   | 2026-02-11     | France       | 1680 |
| 6          | RookAttack      | 41   | 2026-02-11     | Argentina    | 1650 |
| 16         | StrategicSoul   | 36   | 2026-02-11     | Uruguay      | 1600 |
| 7          | BishopPair      | 35   | 2026-02-11     | Chile        | 1580 |
| 17         | ChessAddict     | 28   | 2026-02-11     | Peru         | 1500 |
| 9          | TacticLover     | 22   | 2026-02-11     | Colombia     | 1450 |
| 1          | BENANO97        | 28   | 2026-11-02     | Peru         | 1423 |
| 15         | RapidPlayer     | 21   | 2026-02-11     | Ecuador      | 1300 |
| 5          | PawnStorm       | 19   | 2026-02-11     | Mexico       | 1200 |
| 2          | Conejuno1       | 28   | 2026-11-02     | Perú         | 1000 |


**Updated player rankings**

| id_usuario | nombre_usuario  | edad | fecha_registro | nacionalidad | elo  |
| ---------- | --------------- | ---- | -------------- | ------------ | ---- |
| 20         | FutureGM        | 18   | 2026-02-11     | India        | 2216 |
| 8          | EndgamePro      | 29   | 2026-02-11     | Brazil       | 2091 |
| 14         | PositionalMind  | 44   | 2026-02-11     | UK           | 2019 |
| 11         | SlowThinker     | 38   | 2026-02-11     | Germany      | 1932 |
| 19         | ClassicPlayer   | 40   | 2026-02-11     | Canada       | 1913 |
| 3          | KnightMaster    | 32   | 2026-02-11     | USA          | 1888 |
| 10         | BlitzKing       | 27   | 2026-02-11     | Peru         | 1800 |
| 13         | CheckmateHunter | 31   | 2026-02-11     | Italy        | 1752 |
| 12         | OpeningNerd     | 24   | 2026-02-11     | France       | 1713 |
| 18         | BulletMonster   | 23   | 2026-02-11     | USA          | 1670 |
| 4          | QueenGambit     | 25   | 2026-02-11     | Spain        | 1639 |
| 16         | StrategicSoul   | 36   | 2026-02-11     | Uruguay      | 1628 |
| 6          | RookAttack      | 41   | 2026-02-11     | Argentina    | 1592 |
| 7          | BishopPair      | 35   | 2026-02-11     | Chile        | 1550 |
| 17         | ChessAddict     | 28   | 2026-02-11     | Peru         | 1550 |
| 9          | TacticLover     | 22   | 2026-02-11     | Colombia     | 1440 |
| 1          | BENANO97        | 28   | 2026-11-02     | Peru         | 1405 |
| 15         | RapidPlayer     | 21   | 2026-02-11     | Ecuador      | 1270 |
| 5          | PawnStorm       | 19   | 2026-02-11     | Mexico       | 1259 |
| 2          | Conejuno1       | 28   | 2026-11-02     | Perú         | 1126 |

**Top 5 nationalities with the most players**
| nationality | n°_users |
| ----------- | -------- |
| Peru        | 3        |
| USA         | 2        |
| Ecuador     | 1        |
| Uruguay     | 1        |
| Italy       | 1        |

**Players with most games as White**

| user_id | nickname        | games_as_white |
| ------- | --------------- | -------------- |
| 5       | PawnStorm       | 3              |
| 2       | Conejuno1       | 3              |
| 15      | RapidPlayer     | 3              |
| 3       | KnightMaster    | 3              |
| 4       | QueenGambit     | 3              |
| 1       | BENANO97        | 3              |
| 8       | EndgamePro      | 2              |
| 18      | BulletMonster   | 2              |
| 13      | CheckmateHunter | 2              |
| 10      | BlitzKing       | 2              |

**Players with most games as Black**

| user_id | nickname      | games_as_black |
| ------- | ------------- | -------------- |
| 6       | RookAttack    | 3              |
| 20      | FutureGM      | 3              |
| 5       | PawnStorm     | 3              |
| 10      | BlitzKing     | 3              |
| 18      | BulletMonster | 3              |
| 8       | EndgamePro    | 3              |
| 12      | OpeningNerd   | 2              |
| 19      | ClassicPlayer | 2              |
| 3       | KnightMaster  | 2              |
| 17      | ChessAddict   | 2              |

**Players with most games overall**

| user_id | nickname      | total_games |
| ------- | ------------- | ----------- |
| 5       | PawnStorm     | 6           |
| 3       | KnightMaster  | 5           |
| 6       | RookAttack    | 5           |
| 18      | BulletMonster | 5           |
| 8       | EndgamePro    | 5           |
| 10      | BlitzKing     | 5           |
| 2       | Conejuno1     | 5           |
| 15      | RapidPlayer   | 4           |
| 20      | FutureGM      | 4           |
| 7       | BishopPair    | 4           |

**Players with most wins as white**

| user_id | nickname     | wins_with_white |
| ------- | ------------ | --------------- |
| 3       | KnightMaster | 2               |
| 1       | BENANO97     | 1               |
| 2       | Conejuno1    | 1               |
| 6       | RookAttack   | 1               |
| 17      | ChessAddict  | 1               |

**Players with most wins as black**

| user_id | nickname      | wins_with_black |
| ------- | ------------- | --------------- |
| 8       | EndgamePro    | 3               |
| 20      | FutureGM      | 3               |
| 5       | PawnStorm     | 3               |
| 10      | BlitzKing     | 3               |
| 11      | SlowThinker   | 2               |
| 12      | OpeningNerd   | 2               |
| 17      | ChessAddict   | 2               |
| 19      | ClassicPlayer | 2               |

**Players Winrate**

| user_id | nickname        | elo  | games_played | Wins      | win_rate |
| ------- | --------------- | ---- | ------------ | --------- | -------- |
| 17      | ChessAddict     | 1550 | 3            | 3         | 1.00     |
| 20      | FutureGM        | 2216 | 4            | 3         | 0.75     |
| 11      | SlowThinker     | 1932 | 3            | 2         | 0.67     |
| 12      | OpeningNerd     | 1713 | 3            | 2         | 0.67     |
| 19      | ClassicPlayer   | 1913 | 3            | 2         | 0.67     |
| 10      | BlitzKing       | 1800 | 5            | 3         | 0.60     |
| 8       | EndgamePro      | 2091 | 5            | 3         | 0.60     |
| 3       | KnightMaster    | 1888 | 5            | 3         | 0.60     |
| 5       | PawnStorm       | 1259 | 6            | 3         | 0.50     |
| 6       | RookAttack      | 1592 | 5            | 2         | 0.40     |
| 2       | Conejuno1       | 1126 | 5            | 2         | 0.40     |
| 1       | BENANO97        | 1405 | 3            | 1         | 0.33     |
| 13      | CheckmateHunter | 1752 | 3            | 1         | 0.33     |
| 16      | StrategicSoul   | 1628 | 3            | 1         | 0.33     |
| 9       | TacticLover     | 1440 | 4            | 1         | 0.25     |
| 18      | BulletMonster   | 1670 | 5            | 1         | 0.20     |
| 15      | RapidPlayer     | 1270 | 4            | 0         | 0.00     |
| 7       | BishopPair      | 1550 | 4            | 0         | 0.00     |
| 4       | QueenGambit     | 1639 | 4            | 0         | 0.00     |
| 14      | PositionalMind  | 2019 | 3            | 0         | 0.00     |


## How to Run

1. Run the database setup script:

```sql
sql/01_create_tables_and_data.sql
```
This script creates:
- Players table
- Matches table
- Sample data

2. Run the elo update script:

```sql
sql/02_update_elo.sql
```
This script processes matches in chronological order and updates player ratings following the proposed elo update logic.

3. Run the analysis query scripts

```sql
sql/03_analysis_queries.sql
```
This script outputs the previously shown result tables

