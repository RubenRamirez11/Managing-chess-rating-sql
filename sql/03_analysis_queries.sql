-- Analisis de jugadores después de las partidas

-- Ranking por elo despues de las partidas
Select * from usuarios order by elo desc 

-- Frecuencia de nacionalidades dentro de los usuarios
select nacionalidad as nationality, count(*) as N°_users from usuarios group by nacionalidad order by N°_users desc limit 5

-- Jugadores con más partidas de blancas
SELECT u.id_usuario as User_ID, u.nombre_usuario as Nickname, COUNT(*) AS games_as_white
FROM partidas p JOIN usuarios u ON p.id_blancas = u.id_usuario
GROUP BY u.id_usuario, u.nombre_usuario ORDER BY games_as_white DESC LIMIT 10;


-- Jugadores con más partidas de negras
SELECT u.id_usuario as User_ID, u.nombre_usuario as Nickname, COUNT(*) AS games_as_black
FROM partidas p JOIN usuarios u ON p.id_negras = u.id_usuario
GROUP BY u.id_usuario, u.nombre_usuario ORDER BY games_as_black DESC LIMIT 10;

-- Jugadores con más partidas
SELECT u.id_usuario as User_ID, u.nombre_usuario as Nickname, COUNT(p.id_partida) AS total_games
FROM usuarios u LEFT JOIN partidas p ON u.id_usuario = p.id_blancas OR u.id_usuario = p.id_negras
GROUP BY u.id_usuario, u.nombre_usuario ORDER BY total_games DESC limit 10;

-- Número de partidas en las que ganan blancas
Select count(*) from partidas where id_blancas = ganador -- 6 victorias de las blancas

-- Número de partidas en las que ganan negras
Select count(*) from partidas where id_negras = ganador -- 27 victorias de las negras

-- Número de partidas en las que hay empate
Select count(*) from partidas where ganador is null -- 7 empates

-- Jugadores con más victorias como blancas
select u.id_usuario as user_id, u.nombre_usuario as nickname, count(*) as Wins_With_White
from partidas p join usuarios u on p.id_blancas = u.id_usuario  
where p.id_blancas = p.ganador group by u.id_usuario, u.nombre_usuario order by Wins_With_White desc 

-- Jugadores con más victorias como negras
select u.id_usuario as user_id, u.nombre_usuario as nickname, count(*) as Wins_With_Black
from partidas p join usuarios u on p.id_negras = u.id_usuario  
where p.id_negras = p.ganador group by u.id_usuario, u.nombre_usuario order by Wins_With_Black desc limit 8



--Winrate por jugadores
SELECT 
    u.id_usuario as user_id,
    u.nombre_usuario as nickname,
    u.elo,
    COUNT(p.id_partida) AS games_played,
    COUNT(CASE WHEN p.ganador = u.id_usuario THEN 1 END) AS wins,
    ROUND(
        COUNT(CASE WHEN p.ganador = u.id_usuario THEN 1 END)::numeric
        / COUNT(p.id_partida),
        2
    ) AS win_rate
FROM usuarios u
LEFT JOIN partidas p
    ON u.id_usuario = p.id_blancas
    OR u.id_usuario = p.id_negras
GROUP BY u.id_usuario, u.nombre_usuario
HAVING COUNT(p.id_partida) > 0
ORDER BY win_rate DESC;
