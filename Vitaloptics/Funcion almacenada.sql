# Hecho por: Illian Santiago Ortega Posso
USE vitaloptics;

DELIMITER $$

-- Transforma el nombre de un jefe en el id del mismo
DROP FUNCTION IF EXISTS devolver_id $$
CREATE FUNCTION devolver_id (nombreJefe VARCHAR(15)) RETURNS VARCHAR(15) DETERMINISTIC
BEGIN
	DECLARE idJefe INT;
    DECLARE nombresTrabajadores TEXT DEFAULT '';
    
	SET idJefe = (SELECT id FROM trabajador WHERE nombre LIKE nombreJefe);
    
    RETURN (idJefe);
END $$

DELIMITER ;
SET @idJefe=devolver_id('Juan');
SELECT @idJefe;