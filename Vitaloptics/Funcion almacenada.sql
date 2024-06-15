# Hecho por: Illian Santiago Ortega Posso
USE vitaloptics;

-- Al menos una función almacenada que a partir de algunos parámetros de entrada retorne un valor.

DELIMITER $$
DROP FUNCTION IF EXISTS esimpar $$
CREATE FUNCTION esimpar(numero int) RETURNS int DETERMINISTIC
BEGIN
END; $$

DELIMITER ;
SELECT esimpar(42);
SET @x=esimpar(42);
SELECT @x;