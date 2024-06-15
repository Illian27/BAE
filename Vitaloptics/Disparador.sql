# Hecho por: Illian Santiago Ortega Posso
USE vitaloptics;

-- Al menos un disparador que tenga como propósito por ejemplo :
-- - El control de valores de entrada (control del check)
-- - El mantenimiento de campos derivados
-- - Obtener las estadísticas de la base de datos

DELIMITER $$
DROP TRIGGER IF EXISTS nombre_disparador $$
CREATE TRIGGER nombre_disparador (BEFORE|AFTER) (INSERT|UPDATE|DELETE) ON nombre_tabla FOR EACH ROW
BEGIN 
END $$

DELIMITER ;