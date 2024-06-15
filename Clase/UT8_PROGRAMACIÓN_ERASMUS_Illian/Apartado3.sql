/*
- Una rutina almacenada, trigger o evento que permita automatizar la decisión de APTO o NO APTO
en la participación del proyecto. De manera que una vez un alumno ha superado las pruebas de inglés
y entrevista, se indique con un campo si el alumno es apto o no lo es.
*/
USE Erasmus;
ALTER TABLE Alumno ADD COLUMN apto ENUM('Apto', 'No apto') DEFAULT 'No apto';

DELIMITER $$

/*
DROP TRIGGER IF EXISTS apto_noApto $$
CREATE TRIGGER apto_noApto AFTER INSERT ON Realiza_entrevista FOR EACH ROW
BEGIN
    IF NEW.Calificacion >= 5 THEN
		UPDATE Alumno SET apto = 'Apto' WHERE DNI like NEW.Alumno_DNI;
    END IF;
END $$
*/
DROP TRIGGER IF EXISTS apto_noApto $$
CREATE TRIGGER apto_noApto AFTER INSERT ON Realiza_entrevista FOR EACH ROW
BEGIN
    IF NEW.Alumno_DNI like (SELECT Alumno_DNI FROM Realiza_prueba INNER JOIN Prueba
        ON Realiza_prueba.Prueba_idPrueba = Prueba.idPrueba) 
        
        THEN
		UPDATE Alumno SET apto = 'Apto';
    END IF;
END $$

DELIMITER ;
DELETE from Alumno;