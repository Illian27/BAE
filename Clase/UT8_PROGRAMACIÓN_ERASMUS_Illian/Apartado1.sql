/* Una rutina almacenada, trigger o evento que permita crear una tabla de histórico de alumnado, por
cada curso escolar una vez finalizado éste, y en el que se registren únicamente los campos que
consideres que sean relevantes para contactar con el alumnado que ha realizado la movilidad. */
USE Erasmus;

SET GLOBAL event_scheduler=ON;
SHOW VARIABLES LIKE 'event_scheduler';


CREATE TABLE IF NOT EXISTS log_alumnado (
		id INT UNSIGNED PRIMARY KEY AUTO_INCREMENT NOT NULL,
		Nombre varchar(15) not null,
		Apellidos varchar(35) not null,
		Calle varchar(50)
);

DELIMITER $$
DROP TRIGGER IF EXISTS guardar_alumno $$
CREATE TRIGGER guardar_alumno AFTER DELETE  ON Alumno FOR EACH ROW
BEGIN
	INSERT INTO log_alumnado(Nombre, Apellidos, Calle) VALUES (OLD.Nombre, OLD.Apellidos, OLD.Calle);
END$$

DROP EVENT IF EXISTS borrar_Alumno $$ -- AT CURRENT_DATE + 1 INTERVALE 1 SECOND || EVERY 1 SECOND
CREATE EVENT borrar_Alumno ON SCHEDULE EVERY 1 SECOND STARTS CURRENT_TIMESTAMP ENABLE DO
BEGIN
	DELETE  FROM Alumno WHERE Nombre like 'Juan';
END $$

DELIMITER ;
DELETE  FROM Alumno WHERE Nombre like 'Juan';
DELETE FROM Alumno;
DELETE FROM log_alumnado;
SHOW EVENTS;