# Hecho por: Illian Santiago Ortega Posso
USE vitaloptics;

-- Al menos un evento que se realice únicamente en un intervalo de tiempo determinado o bien de forma periódica

DELIMITER $$
DROP EVENT IF EXISTS event_name $$
CREATE EVENT event_name ON SCHEDULE EVERY 1 SECOND STARTS CURRENT_TIMESTAMP ENABLE DO
BEGIN
END $$

DELIMITER ;
SET GLOBAL event_scheduler=ON;
SHOW VARIABLES LIKE 'event_scheduler';
SHOW PROCESSLIST;