-- Tabla de usuarios/jugadores

CREATE TABLE USUARIOS(ID_USUARIO bigserial PRIMARY KEY, nombre_usuario varchar(100), EDAD INT, FECHA_REGISTRO DATE, NACIONALIDAD VARCHAR(50), ELO INT)

insert into USUARIOS(nombre_usuario, edad, fecha_registro, nacionalidad, elo) values ('BENANO97', 28, '11-02-2026', 'Peru', 1423), 
('Conejuno1', 28, '11-02-2026', 'Perú', 1000), ('KnightMaster', 32, '2026-02-11', 'USA', 1850),
('QueenGambit', 25, '2026-02-11', 'Spain', 1720),
('PawnStorm', 19, '2026-02-11', 'Mexico', 1200),
('RookAttack', 41, '2026-02-11', 'Argentina', 1650),
('BishopPair', 35, '2026-02-11', 'Chile', 1580),
('EndgamePro', 29, '2026-02-11', 'Brazil', 2100),
('TacticLover', 22, '2026-02-11', 'Colombia', 1450),
('BlitzKing', 27, '2026-02-11', 'Peru', 1780),
('SlowThinker', 38, '2026-02-11', 'Germany', 1950),
('OpeningNerd', 24, '2026-02-11', 'France', 1680),
('CheckmateHunter', 31, '2026-02-11', 'Italy', 1820),
('PositionalMind', 44, '2026-02-11', 'UK', 2050),
('RapidPlayer', 21, '2026-02-11', 'Ecuador', 1300),
('StrategicSoul', 36, '2026-02-11', 'Uruguay', 1600),
('ChessAddict', 28, '2026-02-11', 'Peru', 1500),
('BulletMonster', 23, '2026-02-11', 'USA', 1700),
('ClassicPlayer', 40, '2026-02-11', 'Canada', 1900),
('FutureGM', 18, '2026-02-11', 'India', 2200);

select * from usuarios order by elo desc

CREATE TABLE PARTIDAS (
    id_partida BIGSERIAL PRIMARY KEY,
    id_blancas BIGINT REFERENCES usuarios(id_usuario),
    id_negras BIGINT REFERENCES usuarios(id_usuario),
    ganador BIGINT REFERENCES usuarios(id_usuario), -- ID del ganador (NULL si empate)
    fecha_partida TIMESTAMP DEFAULT CURRENT_TIMESTAMP
);

INSERT INTO PARTIDAS (id_blancas, id_negras, ganador, fecha_partida)
VALUES
-- Partidas cercanas
(1, 2, 1, '2026-02-01'),
(2, 3, NULL, '2026-02-01'),  -- empate
(3, 4, 3, '2026-02-02'),
(4, 5, 5, '2026-02-02'),
(5, 6, NULL, '2026-02-03'),  -- empate
(6, 7, 6, '2026-02-03'),
(7, 8, 8, '2026-02-04'),
(8, 9, NULL, '2026-02-04'),  -- empate
(9, 10, 10, '2026-02-05'),
(10, 11, 11, '2026-02-05'),

-- Diferencias mayores
(1, 10, 10, '2026-02-06'),
(2, 12, 12, '2026-02-06'),
(3, 15, 3, '2026-02-06'),   -- sorpresa
(4, 18, 18, '2026-02-07'),
(5, 20, 20, '2026-02-07'),

-- Jugadores fuertes
(15, 16, NULL, '2026-02-08'), -- empate
(16, 17, 17, '2026-02-08'),
(17, 18, 17, '2026-02-08'),
(18, 19, 19, '2026-02-09'),
(19, 20, 20, '2026-02-09'),

-- Actividad general
(1, 5, 5, '2026-02-09'),
(2, 6, 2, '2026-02-09'),
(3, 7, NULL, '2026-02-10'), -- empate
(4, 8, 8, '2026-02-10'),
(5, 9, 9, '2026-02-10'),
(6, 10, 10, '2026-02-10'),
(7, 11, 11, '2026-02-10'),
(8, 12, 12, '2026-02-10'),
(9, 13, 13, '2026-02-11'),
(10, 14, NULL, '2026-02-11'), -- empate

-- Sorpresas (underdog gana)
(15, 5, 5, '2026-02-11'),
(18, 6, 6, '2026-02-11'),
(20, 8, 8, '2026-02-11'),
(14, 3, 3, '2026-02-11'),
(13, 2, 2, '2026-02-11'),

-- Últimas partidas
(11, 16, 16, '2026-02-12'),
(12, 17, 17, '2026-02-12'),
(13, 18, NULL, '2026-02-12'), -- empate
(14, 19, 19, '2026-02-12'),
(15, 20, 20, '2026-02-12');

SELECT COUNT(*) 
FROM PARTIDAS


SELECT COUNT(*) 
FROM PARTIDAS
WHERE ganador IS NULL;
