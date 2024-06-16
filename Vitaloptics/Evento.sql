# Hecho por: Illian Santiago Ortega Posso
USE vitaloptics;
SET GLOBAL event_scheduler=ON;

DELIMITER $$

-- Elimina aquellos pagos que se hicieron hace tres años
DROP EVENT IF EXISTS eliminaPagos $$
CREATE EVENT eliminaPagos ON SCHEDULE EVERY 1 YEAR ENABLE DO
BEGIN
	DELETE FROM pago WHERE YEAR(fecha) < YEAR(CURRENT_TIMESTAMP) - 3;
END $$