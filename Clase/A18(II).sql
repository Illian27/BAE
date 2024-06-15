# Hecho por: Illian Santiago Ortega Posso
DROP DATABASE clases;
CREATE DATABASE clases;
USE clases;

CREATE TABLE alumnos (
  id INT(32) UNSIGNED PRIMARY KEY AUTO_INCREMENT, 
  nombre VARCHAR(15),
  apellido1 VARCHAR(25),
  apellido2 VARCHAR(25),
  nota FLOAT
);


-- Apartado 1
DELIMITER $$
DROP TRIGGER IF EXISTS trigger_check_nota_before_insert $$
CREATE TRIGGER trigger_check_nota_before_insert BEFORE INSERT ON alumnos FOR EACH ROW
BEGIN

  IF NEW.nota < 0 THEN
    set NEW.nota = 0;
    
  ELSEIF NEW.nota > 10 THEN
    set NEW.nota = 10;
  END IF;
  
END $$

DROP TRIGGER IF EXISTS trigger_check_nota_before_update $$
CREATE TRIGGER trigger_check_nota_before_update BEFORE UPDATE ON alumnos FOR EACH ROW
BEGIN

  IF NEW.nota < 0 THEN
    set NEW.nota = 0;
    
  ELSEIF NEW.nota > 10 THEN
    set NEW.nota = 10;
  END IF;
  
END $$


-- Apartado 2
DELIMITER ;
DROP DATABASE clases;
CREATE DATABASE clases;
USE clases;

CREATE TABLE alumnos (
  id INT(32) UNSIGNED PRIMARY KEY AUTO_INCREMENT, 
  nombre VARCHAR(15),
  apellido1 VARCHAR(25),
  apellido2 VARCHAR(25),
  email VARCHAR(50)
);

DELIMITER $$
DROP PROCEDURE IF EXISTS crear_email $$
CREATE PROCEDURE crear_email (IN nombre VARCHAR(15), IN apellido1 VARCHAR(25), IN apellido2 VARCHAR(25), IN dominio VARCHAR(15), OUT correo VARCHAR(50))
BEGIN
	SET nombre = (SELECT LEFT(nombre, 1));
    SET apellido1 = (SELECT LEFT(apellido1, 3));
    SET apellido2 = (SELECT LEFT(apellido2, 3));
    SET dominio = CONCAT(dominio, '.com');
    SET correo = LOWER( CONCAT(nombre, apellido1, apellido2, '@', dominio));
END $$

DROP TRIGGER IF EXISTS trigger_crear_email_before_insert $$
CREATE TRIGGER Strigger_crear_email_before_insert BEFORE INSERT ON alumnos FOR EACH ROW
BEGIN
	IF NEW.email IS NULL THEN
        CALL crear_email('example','example', 'example', 'gmail', NEW.email);
    END IF;
END $$


-- Apartado 3
DELIMITER ;
CREATE TABLE log_cambios_email (
id INT(32) UNSIGNED PRIMARY KEY AUTO_INCREMENT NOT NULL,
id_alumno INT(32) UNSIGNED,
fecha_hora TIMESTAMP,
old_email VARCHAR(50),
new_email VARCHAR(50),
CONSTRAINT FK_id_alumno FOREIGN KEY(id_alumno) REFERENCES alumnos(id)
);

DELIMITER $$
DROP TRIGGER IF EXISTS  trigger_guardar_email_after_update $$
CREATE TRIGGER  trigger_guardar_email_after_update BEFORE UPDATE ON alumnos FOR EACH ROW
BEGIN
	INSERT INTO log_cambios_email(id_alumno, fecha_hora, old_email, new_email) VALUES(NEW.id, CURRENT_TIMESTAMP, NEW.email, OLD.email);
END$$


-- Apartado 4
DELIMITER ;
CREATE TABLE log_alumnos_eliminados (
	id INT(32) UNSIGNED PRIMARY KEY AUTO_INCREMENT NOT NULL,
	id_alumno INT(32) UNSIGNED,
	fecha_hora TIMESTAMP,
	nombre VARCHAR(15),
	apellido1 VARCHAR(25),
	apellido2 VARCHAR(25),
	email VARCHAR(50),
	CONSTRAINT FK_id_alumno_2 FOREIGN KEY(id_alumno) REFERENCES alumnos(id)
);

DELIMITER $$
DROP TRIGGER IF EXISTS  trigger_guardar_alumnos_eliminados $$
CREATE TRIGGER  trigger_guardar_alumnos_eliminados BEFORE DELETE  ON alumnos FOR EACH ROW
BEGIN
	INSERT INTO log_alumnos_eliminados(id_alumno, fecha_hora, nombre, apellido1, apellido2, email)
    VALUES(OLD.id, CURRENT_TIMESTAMP, OLD.nombre, OLD.apellido1, OLD.apellido2, OLD.email);
END$$


-- Apartado 5
DELIMITER ;
USE ebanca;
DROP TABLE IF EXISTS `nrojos`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `nrojos` (
  `fecha` date NOT NULL,
  `saldo` int(11) NOT NULL,
  `cuenta` int(11) NOT NULL,
  `cliente` int(11) NOT NULL,
  PRIMARY KEY (`cliente`, `cod_cuenta`),
) 

DELIMITER $$
DROP TRIGGER IF EXISTS crear_registro_nrojos $$
CREATE TRIGGER crear_registro_nrojos BEFORE UPDATE ON cuentas FOR EACH ROW
BEGIN
	IF saldo < 0 THEN
		INSERT INTO nrojos(fecha, saldo, cuenta, cliente) VALUES (OLD.fecha_creacion, OLD.saldo, OLD.cod_cuenta, OLD.cod_cliente);
    END IF;
END $$


-- Apartado 6
DELIMITER ;
USE nmotor;
DROP TABLE IF EXISTS `log_borrados`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `log_borrados` (
  `usuario` char(15) NOT NULL,
  `fecha_hora` datetime NOT NULL,
  `titulo` text NOT NULL,
  FULLTEXT KEY `full` (`titulo`,`usuario`)
) ENGINE=MyISAM AUTO_INCREMENT=3844 DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

DELIMITER $$
DROP TRIGGER IF EXISTS registro_log_borrados $$
CREATE TRIGGER registro_log_borrados BEFORE DELETE  ON noticias FOR EACH ROW
BEGIN
	INSERT INTO log_borrados  VALUES(OLD.autor_id, OLD.fecha_pub, OLD.titulo);
END $$

-- Apartardo 7