# Hecho por: Illian Santiago Ortega Posso
# 1.8.8 Triggers

-- Crear la base de datos
DROP DATABASE IF EXISTS test;
CREATE DATABASE test;
USE test;

CREATE TABLE alumnos (
    id INT UNSIGNED AUTO_INCREMENT PRIMARY KEY,
    nombre VARCHAR(50) NOT NULL,
    apellido1 VARCHAR(50) NOT NULL,
    apellido2 VARCHAR(50), 
    nota FLOAT
);

-- Triggers
DELIMITER $$
DROP TRIGGER IF EXISTS trigger_check_nota_before_insert$$
CREATE TRIGGER trigger_check_nota_before_insert
BEFORE INSERT
ON alumnos FOR EACH ROW
BEGIN
  IF NEW.nota < 0 THEN
    set NEW.nota = 0;
  ELSEIF NEW.nota > 10 THEN
    set NEW.nota = 10;
  END IF;
END $$

DELIMITER $$
DROP TRIGGER IF EXISTS trigger_check_nota_before_update$$
CREATE TRIGGER trigger_check_nota_before_update
BEFORE UPDATE
ON alumnos FOR EACH ROW
BEGIN
  IF NEW.nota < 0 THEN
    set NEW.nota = 0;
  ELSEIF NEW.nota > 10 THEN
    set NEW.nota = 10;
  END IF;
END $$

-- Inserciones
DELIMITER ;
INSERT INTO alumnos VALUES (1, 'Pepe', 'López', 'López', -1);
INSERT INTO alumnos VALUES (2, 'María', 'Sánchez', 'Sánchez', 11);
INSERT INTO alumnos VALUES (3, 'Juan', 'Pérez', 'Pérez', 8.5);
-- DELETE FROM alumnos;

-- Actualizaciones
UPDATE alumnos SET nota = -4 WHERE id = 3;
UPDATE alumnos SET nota = 14 WHERE id = 3;
UPDATE alumnos SET nota = 9.5 WHERE id = 3;

-- DELETE FROM alumnos;

-- Segunda parte
DELIMITER $$

DROP PROCEDURE IF EXISTS crear_email $$
CREATE PROCEDURE crear_email (IN nombre VARCHAR(50), IN apellido1 VARCHAR(50), IN apellido2 VARCHAR(50), IN dominio VARCHAR(50), OUT correo VARCHAR(50))
BEGIN
	SET nombre = (SELECT LEFT(nombre, 1));
    SET apellido1 = (SELECT LEFT(apellido1, 3));
    SET apellido2 = (SELECT LEFT(apellido2, 3));
    SET dominio = CONCAT(dominio, '.com');
    SET correo = LOWER( CONCAT(nombre, apellido1, apellido2, '@', dominio));
END $$

DELIMITER ;
CALL crear_email('Illian','Ortega', 'Posso', 'gmail', @correo);
-- SELECT @correo;

DELIMITER $$
DROP FUNCTION eliminar_acentos $$
CREATE FUNCTION eliminar_acentos (cadena VARCHAR(50))
RETURNS VARCHAR(50)
DETERMINISTIC
BEGIN

END $$