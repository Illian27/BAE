# Hecho por: Illian Santiago Ortega Posso
DROP DATABASE IF EXISTS centro;
CREATE DATABASE IF NOT EXISTS centro;
USE centro;

CREATE TABLE comunidad (
    id INT AUTO_INCREMENT NOT NULL PRIMARY KEY,
    nombre VARCHAR(35) NOT NULL,
    apellido1 VARCHAR(35) NOT NULL,
    apellido2 VARCHAR (35) NOT NULL,
    fecha_nacimiento DATE NOT NULL,
    tipo ENUM('profesor', 'alumnos', 'otros')
);

INSERT INTO comunidad (nombre, apellido1, apellido2, fecha_nacimiento, tipo)
VALUES
  ('Juan', 'Pérez', 'López', '1980-01-01', 'profesor'),
  ('María', 'Gómez', 'García', '1990-02-02', 'alumnos'),
  ('Pedro', 'Rodríguez', 'Sánchez', '2000-03-03', 'profesor'),
  ('Ana', 'Martínez', 'Fernández', '2010-04-04', 'alumnos'),
  ('Luis', 'López', 'Pérez', '2020-05-05', 'otros'),
  ('Laura', 'Gómez', 'García', '2030-06-06', 'alumnos');
  
ALTER TABLE comunidad ADD COLUMN edad INT NOT NULL AFTER tipo;

DELIMiTER $$
DROP FUNCTION IF EXISTS calcular_edad $$
CREATE FUNCTION calcular_edad (fecha DATE)
RETURNS INT
READS SQL DATA
BEGIN
	DECLARE num_años INT;
	SET num_años = TIMESTAMPDIFF(YEAR, fecha, current_date());
	RETURN num_años;
END $$

SELECT calcular_edad('2004-01-01');

DROP PROCEDURE IF EXISTS actualizar_columna_edad $$
CREATE PROCEDURE actulizar_columna_edad ()
BEGIN
	DECLARE a INT Default 0 ;
	simple_loop: LOOP
         DECLARE id INT ;
         select a;
         
         IF id = 6 THEN
            LEAVE simple_loop;
         END IF;
         
	END LOOP simple_loop;
	
    INSERT INTO comunidad (nombre, apellido1, apellido2, fecha_nacimiento, tipo) VALUES ('Juan', 'Pérez', 'López', '1980-01-01', 'profesor');
END $$

DELIMITER ;
CALL crear_email('Illian','Ortega', 'Posso', 'gmail', @correo);