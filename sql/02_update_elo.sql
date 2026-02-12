---- ACTUALIZANDO EL ELO EN BASE A PARTIDAS
DO $$
DECLARE
    partida RECORD;
    elo1 INT;
    elo2 INT;
    cambio INT;
BEGIN

    -- Recorremos las partidas en orden de fecha (más antiguas primero)
    FOR partida IN
        SELECT *
        FROM PARTIDAS
        ORDER BY fecha_partida, id_partida
    LOOP

        -- Ignorar empates
        IF partida.ganador IS NULL THEN
            CONTINUE;
        END IF;

        -- Obtener ELO actual de ambos jugadores
        SELECT elo INTO elo1
        FROM USUARIOS
        WHERE id_usuario = partida.jugador_1;

        SELECT elo INTO elo2
        FROM USUARIOS
        WHERE id_usuario = partida.jugador_2;

        -- Calcular diferencia
        cambio := GREATEST(10, ROUND(0.1 * ABS(elo1 - elo2)));

        -- Determinar si fue sorpresa (underdog ganó)
        IF partida.ganador = partida.jugador_1 THEN
            
            IF elo1 < elo2 THEN
                -- jugador_1 era underdog → cambio grande
            ELSE
                cambio := 10;
            END IF;

            -- Actualizar ganador
            UPDATE USUARIOS
            SET elo = elo + cambio
            WHERE id_usuario = partida.jugador_1;

            -- Actualizar perdedor
            UPDATE USUARIOS
            SET elo = elo - cambio
            WHERE id_usuario = partida.jugador_2;

        ELSE  -- ganador es jugador_2

            IF elo2 < elo1 THEN
                -- jugador_2 era underdog → cambio grande
            ELSE
                cambio := 10;
            END IF;

            UPDATE USUARIOS
            SET elo = elo + cambio
            WHERE id_usuario = partida.jugador_2;

            UPDATE USUARIOS
            SET elo = elo - cambio
            WHERE id_usuario = partida.jugador_1;

        END IF;

    END LOOP;

END $$;
