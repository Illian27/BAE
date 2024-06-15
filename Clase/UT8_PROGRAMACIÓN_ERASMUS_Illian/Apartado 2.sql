/*
- Una rutina almacenada, trigger o evento que permita registrar, en una tabla creada previamente, la
lista de correo de los alumnos que han participado en una movilidad, por cada curso escolar y una vez
ha finalizado éste.
*/

DELIMITER $$
CREATE PROCEDURE CrearHistorialAlumnos()
BEGIN
    DECLARE tableName VARCHAR(64);
    SET tableName = CONCAT('HistorialAlumnos_', YEAR(CURDATE()) - 1, '_', YEAR(CURDATE()));
    PREPARE stmt FROM @createTableSQL;
    EXECUTE stmt;
    DEALLOCATE PREPARE stmt;

    SET @insertDataSQL = CONCAT(
        'INSERT INTO ', tableName, ' (DNI, Nombre, Apellidos, Email, Telefono, idMovilidad, FechaInicio, FechaFin, Pais, Idioma)
        SELECT 
            a.DNI, a.Nombre, a.Apellidos, p.email, p.Telefono, ac.Movilidad_idMovilidad, ac.FechaInicio, ac.FechaFin, ap.Pais, ap.Idioma
        FROM Aceptado ac
        JOIN Alumno a ON ac.Alumno_DNI = a.DNI
        JOIN Profesor p ON ac.Alumno_DNI = a.DNI
        JOIN Aceptado_pais ap ON ac.Alumno_DNI = ap.Aceptado_Alumno_DNI;'
    );
    PREPARE stmt FROM @insertDataSQL;
    EXECUTE stmt;
    DEALLOCATE PREPARE stmt;
END $$


DELIMITER ;

DELIMITER $$
CREATE EVENT IF NOT EXISTS CrearHistorialAlumnosEvento
ON SCHEDULE EVERY 1 minute_second
STARTS TIMESTAMP(CURDATE() + INTERVAL (6 - MONTH(CURDATE())) MONTH + INTERVAL (30 - DAY(CURDATE())) DAY)
DO CALL CrearHistorialAlumnos()$$


DELIMITER ;
DELETE from tableName;