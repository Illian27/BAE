# Hecho por: Illian Santiago Ortega Posso
USE vitaloptics;

-- Administrador
CREATE USER 'administrador'@'localhost' IDENTIFIED BY '1ADMIN2istr@dor3';
GRANT ALL PRIVILEGES ON vitaloptics.* TO 'administrador'@'localhost';


-- Creamos los roles
CREATE ROLE IF NOT EXISTS cliente, cliente_registrado, trabajador;


-- Cliente
GRANT INSERT ON vitaloptics.registrado TO 'cliente';

GRANT SELECT ON vitaloptics.factura TO 'cliente';
GRANT SELECT ON vitaloptics.producto TO 'cliente';
GRANT SELECT ON vitaloptics.servicio TO 'cliente';

GRANT INSERT,SELECT ON vitaloptics.pago TO 'cliente';

GRANT INSERT,SELECT,DELETE ON vitaloptics.cliente TO 'cliente';


-- Cliente_registrado
GRANT cliente ON vitaloptics.cliente TO 'cliente_registrado';

GRANT INSERT ON vitaloptics.realiza TO 'cliente_registrado';
GRANT INSERT ON vitaloptics.promociona TO 'cliente_registrado';

GRANT SELECT,INSERT,DELETE ON vitaloptics.registrado TO 'cliente_registrado';


-- Trabajador
GRANT INSERT ON vitaloptics.promociona TO 'trabajador';
GRANT INSERT ON vitaloptics.cliente TO 'trabajador';
GRANT INSERT ON vitaloptics.realiza TO 'trabajador';
GRANT INSERT ON vitaloptics.pago TO 'trabajador';
GRANT INSERT ON vitaloptics.registrado TO 'trabajador';

GRANT SELECT ON vitaloptics.es_jefe_de TO 'trabajador';
GRANT SELECT ON vitaloptics.producto TO 'trabajador';
GRANT SELECT ON vitaloptics.servicio TO 'trabajador';

GRANT INSERT,SELECT ON vitaloptics.factura TO 'trabajador';

GRANT SELECT,UPDATE ON vitaloptics.trabajador TO 'trabajador';
GRANT SELECT,UPDATE ON vitaloptics.interno TO 'trabajador';
GRANT SELECT,UPDATE ON vitaloptics.interno_habilidades TO 'trabajador';


-- Jefe
CREATE USER jefe IDENTIFIED BY '1CON2traseñ@3';

GRANT INSERT ON vitaloptics.realiza TO 'jefe';

GRANT INSERT,SELECT ON vitaloptics.registrado TO 'jefe';
GRANT INSERT,SELECT ON vitaloptics.promociona TO 'jefe';
GRANT INSERT,SELECT ON vitaloptics.cliente TO 'jefe';


GRANT INSERT,SELECT,DELETE ON vitaloptics.externo TO 'jefe';
GRANT INSERT,SELECT,DELETE ON vitaloptics.interno TO 'jefe';
GRANT INSERT,SELECT,DELETE ON vitaloptics.interno_habilidades TO 'jefe';
GRANT INSERT,SELECT,DELETE ON vitaloptics.factura TO 'jefe';
GRANT INSERT,SELECT,DELETE ON vitaloptics.trabajador TO 'jefe';

GRANT INSERT,SELECT,UPDATE,DELETE ON vitaloptics.es_jefe_de TO 'jefe';
GRANT INSERT,SELECT,UPDATE,DELETE ON vitaloptics.producto TO 'jefe';
GRANT INSERT,SELECT,UPDATE,DELETE ON vitaloptics.servicio TO 'jefe';