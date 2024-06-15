# Hecho por: Illian Santiago Ortega Posso

-- Al menos un procedimiento almacenado que haga uso de cursores y del manejo de errores mediante handler
DELIMITER $$
DROP PROCEDURE IF EXISTS hola_mundo$$
CREATE PROCEDURE test.hola_mundo()
BEGIN
	SELECT ‘hola mundo’;
END $$

CALL hola_mundo();