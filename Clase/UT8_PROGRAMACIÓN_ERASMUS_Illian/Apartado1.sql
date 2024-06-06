/* Una rutina almacenada, trigger o evento que permita crear una tabla de histórico de alumnado, por
cada curso escolar una vez finalizado éste, y en el que se registren únicamente los campos que
consideres que sean relevantes para contactar con el alumnado que ha realizado la movilidad. */
USE Erasmus;

CREATE TABLE IF NOT EXISTS log_alumnado (
		id INT UNSIGNED PRIMARY KEY AUTO_INCREMENT NOT NULL,
		Nombre varchar(15) not null,
		Apellidos varchar(35) not null,
		Calle varchar(50)
);

DELIMITER $$
DROP TRIGGER IF EXISTS guardar_alumno $$
CREATE TRIGGER guardar_alumno AFTER DELETE ON Alumno FOR EACH ROW
BEGIN
	INSERT INTO log_alumnado(Nombre, Apellidos, Calle) VALUES (OLD.Nombre, OLD.Apellidos, OLD.Calle);
END$$

DELIMITER ;
DROP TABLE Alumno;
SELECT * FROM log_alumnado;

-- Error Code: 1451. Cannot delete or update a parent row: a foreign key constraint fails 
-- (`erasmus`.`realiza_entrevista`, CONSTRAINT `FK_Alumno_DNI` FOREIGN KEY (`Alumno_DNI`) REFERENCES `alumno` (`DNI`))
