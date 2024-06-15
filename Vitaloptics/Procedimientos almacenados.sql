# Hecho por: Illian Santiago Ortega Posso
USE vitaloptics;

-- Al menos un procedimiento almacenado que haga uso de cursores y del manejo de errores mediante handler
DELIMITER $$
DROP PROCEDURE IF EXISTS muestra_estado $$
CREATE PROCEDURE muestra_estado (in numero int)
BEGIN
IF  (esimpar(numero)) THEN 
	SELECT CONCAT(numero,” es impar”);
ELSE 
	 SELECT CONCAT(numero,” es par”);
END IF;
END $$

DELIMITER ;
CALL muestra_estado(42);