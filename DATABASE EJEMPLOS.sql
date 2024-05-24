CREATE DATABASE IF NOT EXISTS test;
USE test;

CREATE TABLE IF NOT EXISTS alumnos(
	id INT UNSIGNED PRIMARY KEY,
	nombre VARCHAR(25),
	apellido1 VARCHAR(25),
	apellido2 VARCHAR(25),
	fecha_nacimiento DATE
);

INSERT INTO alumnos VALUES ('1', 'Illian', 'Ortega', 'Posso', '2024-01-01');
INSERT INTO alumnos VALUES ('2', 'Elvis', 'SI', 'SI', '2024-02-02');
INSERT INTO alumnos VALUES ('3', 'Oscar', 'No', 'No', '2024-03-03');
INSERT INTO alumnos VALUES ('4', 'Razuk', 'SI', 'No', '2024-04-04');

ALTER TABLE alumnos ADD edad INT;