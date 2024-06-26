DROP DATABASE IF EXISTS vitaloptics;
CREATE DATABASE IF NOT EXISTS vitaloptics CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_as_Cs;
USE vitaloptics;

-- Tablas de entidades principales
CREATE TABLE cliente (
  id INT UNSIGNED PRIMARY KEY AUTO_INCREMENT NOT NULL,
  nombre VARCHAR(15) NOT NULL,
  telefono VARCHAR(12) NOT NULL,
  apellido1 VARCHAR(25) NOT NULL,
  apellido2 VARCHAR(25) NOT NULL
);

CREATE TABLE registrado (
  DNI CHAR(9) PRIMARY KEY NOT NULL,
  correo VARCHAR(30) NOT NULL,
  nombre_usuario VARCHAR(15) NOT NULL,
  contraseña VARCHAR(30) NOT NULL,
  codigo_postal INT UNSIGNED NOT NULL,
  direccion VARCHAR(50) NOT NULL,
  cliente_id INT UNSIGNED NOT NULL UNIQUE,
  CONSTRAINT fk_registrado_cliente1 FOREIGN KEY(cliente_id) REFERENCES cliente(id) ON DELETE  CASCADE ON UPDATE CASCADE
);

CREATE TABLE no_registrado (
  cliente_id INT UNSIGNED PRIMARY KEY NOT NULL,
  CONSTRAINT fk_no_registrado_cliente1 FOREIGN KEY(cliente_id) REFERENCES cliente(id) ON DELETE  CASCADE ON UPDATE CASCADE
);

CREATE TABLE trabajador (
  id INT UNSIGNED PRIMARY KEY AUTO_INCREMENT NOT NULL,
  nombre VARCHAR(15) NOT NULL,
  apellido1 VARCHAR(25) NOT NULL,
  apellido2 VARCHAR(25) NOT NULL
);

CREATE TABLE interno (
  trabajador_id INT UNSIGNED PRIMARY KEY NOT NULL,
  DNI CHAR(9) NOT NULL,
  telefono VARCHAR(12) NULL,
  correo VARCHAR(30) NOT NULL,
  num_cuenta CHAR(24) NOT NULL,
  CONSTRAINT fk_interno_trabajador1 FOREIGN KEY(trabajador_id) REFERENCES trabajador(id) ON DELETE  CASCADE ON UPDATE CASCADE
);

CREATE TABLE externo (
  trabajador_id INT UNSIGNED PRIMARY KEY NOT NULL,
  profesion VARCHAR(30) NOT NULL,
  empresa VARCHAR(30) NOT NULL,
  CONSTRAINT fk_externo_trabajador1 FOREIGN KEY(trabajador_id) REFERENCES trabajador(id) ON DELETE  CASCADE ON UPDATE CASCADE
);

CREATE TABLE pago (
  id INT UNSIGNED PRIMARY KEY AUTO_INCREMENT NOT NULL,
  num_tarjeta VARCHAR(19) NOT NULL,
  fecha DATETIME NOT NULL,
  total FLOAT4 NOT NULL
);

CREATE TABLE factura (
  id INT UNSIGNED AUTO_INCREMENT NOT NULL,
  nombre_trabajador VARCHAR(15) NOT NULL,
  fecha DATETIME NOT NULL,
  direccion VARCHAR(50) NOT NULL,
  idcliente INT UNSIGNED NOT NULL,
  nombre_cliente VARCHAR(15),
  total INT UNSIGNED NOT NULL,
  pago_id INT UNSIGNED NOT NULL,
  CONSTRAINT fk_factura_pago FOREIGN KEY(pago_id) REFERENCES pago(id) ON DELETE  RESTRICT ON UPDATE CASCADE,
PRIMARY KEY (id, pago_id));

CREATE TABLE producto (
  id INT UNSIGNED PRIMARY KEY AUTO_INCREMENT NOT NULL,
  nombre VARCHAR(15) NOT NULL,
  precio FLOAT4 UNSIGNED NOT NULL,
  color VARCHAR(12) NOT NULL,
  dimenciones VARCHAR(50) NOT NULL,
  stock INT NOT NULL
);

CREATE TABLE servicio (
  id INT UNSIGNED PRIMARY KEY AUTO_INCREMENT NOT NULL,
  nombre VARCHAR(15) NOT NULL,
  precio FLOAT4 NOT NULL,
  detalles TEXT NOT NULL,
  tipo ENUM('Óptica', 'Audiología') NOT NULL
);

-- Tablas de normalizaciones
CREATE TABLE interno_habilidades (
  interno_trabajador_id INT UNSIGNED PRIMARY KEY NOT NULL,
  habilidad VARCHAR(20) NOT NULL,
  CONSTRAINT fk_interno_habilidades_interno1 FOREIGN KEY(interno_trabajador_id) REFERENCES interno(trabajador_id) ON DELETE  CASCADE ON UPDATE CASCADE
);

-- Tablas de relaciones
CREATE TABLE es_jefe_de (
  trabajador_id INT UNSIGNED NOT NULL,
  jefe_id INT UNSIGNED NOT NULL,
  CONSTRAINT fk_jefe FOREIGN KEY(jefe_id) REFERENCES trabajador(id) ON DELETE  CASCADE ON UPDATE CASCADE,
  CONSTRAINT fk_es_jefe_de_trabajador1 FOREIGN KEY(trabajador_id) REFERENCES trabajador(id) ON DELETE  CASCADE ON UPDATE RESTRICT,
PRIMARY KEY(trabajador_id, jefe_id));

CREATE TABLE promociona (
  registrado_cliente_id INT UNSIGNED NOT NULL,
  cliente_id INT UNSIGNED NOT NULL,
  codigo CHAR(5) NOT NULL,
  CONSTRAINT fk_registrado_has_cliente_registrado1 FOREIGN KEY(registrado_cliente_id) REFERENCES registrado(cliente_id) ON DELETE  RESTRICT ON UPDATE RESTRICT,
  CONSTRAINT fk_registrado_has_cliente_cliente1 FOREIGN KEY(cliente_id) REFERENCES cliente(id) ON DELETE  CASCADE ON UPDATE CASCADE,
PRIMARY KEY (registrado_cliente_id, cliente_id));

CREATE TABLE realiza (
  registrado_cliente_id INT UNSIGNED NOT NULL,
  pago_id INT UNSIGNED NOT NULL,
  oferta INT NULL,
  CONSTRAINT fk_realiza_registrado1 FOREIGN KEY(registrado_cliente_id) REFERENCES registrado(cliente_id) ON DELETE  CASCADE ON UPDATE CASCADE,
  CONSTRAINT fk_realiza_pago1 FOREIGN KEY(pago_id) REFERENCES pago(id) ON DELETE  RESTRICT ON UPDATE CASCADE,
PRIMARY KEY (registrado_cliente_id, pago_id));

CREATE TABLE hace (
  no_registrado_cliente_id INT UNSIGNED NOT NULL,
  pago_id INT UNSIGNED NOT NULL,
  CONSTRAINT fk_hace_no_registrado1 FOREIGN KEY(no_registrado_cliente_id) REFERENCES no_registrado(cliente_id) ON DELETE  CASCADE ON UPDATE CASCADE,
  CONSTRAINT fk_hace_pago1 FOREIGN KEY(pago_id) REFERENCES pago(id) ON DELETE  CASCADE ON UPDATE CASCADE,
PRIMARY KEY (no_registrado_cliente_id, pago_id));

CREATE TABLE tramita (
  trabajador_id INT UNSIGNED NOT NULL,
  cliente_id INT UNSIGNED NOT NULL,
  factura_id INT UNSIGNED NOT NULL,
  factura_pago_id INT UNSIGNED NOT NULL,
  CONSTRAINT fk_tramita_trabajador1 FOREIGN KEY(trabajador_id) REFERENCES trabajador(id) ON DELETE  CASCADE ON UPDATE CASCADE,
  CONSTRAINT fk_tramita_cliente1 FOREIGN KEY(cliente_id) REFERENCES cliente(id) ON DELETE  CASCADE ON UPDATE CASCADE,
  CONSTRAINT fk_tramita_factura1 FOREIGN KEY(factura_id , factura_pago_id) REFERENCES factura(id , pago_id) ON DELETE  RESTRICT ON UPDATE RESTRICT,
PRIMARY KEY (trabajador_id, cliente_id));

CREATE TABLE tiene (
  factura_id INT UNSIGNED NOT NULL,
  factura_pago_id INT UNSIGNED NOT NULL,
  producto_id INT UNSIGNED NOT NULL,
  CONSTRAINT fk_factura_has_producto_factura1 FOREIGN KEY(factura_id , factura_pago_id) REFERENCES factura(id , pago_id) ON DELETE  CASCADE ON UPDATE CASCADE,
  CONSTRAINT fk_factura_has_producto_producto1 FOREIGN KEY(producto_id) REFERENCES producto(id) ON DELETE  RESTRICT ON UPDATE RESTRICT,
PRIMARY KEY (factura_id, factura_pago_id, producto_id));

CREATE TABLE contiene (
  factura_id INT UNSIGNED NOT NULL,
  factura_pago_id INT UNSIGNED NOT NULL,
  servicio_id INT UNSIGNED NOT NULL,
  CONSTRAINT fk_factura_has_servicio_factura1 FOREIGN KEY(factura_id , factura_pago_id) REFERENCES factura(id , pago_id) ON DELETE  CASCADE ON UPDATE CASCADE,
  CONSTRAINT fk_factura_has_servicio_servicio1 FOREIGN KEY(servicio_id) REFERENCES servicio(id) ON DELETE  RESTRICT ON UPDATE CASCADE,
PRIMARY KEY (factura_id, factura_pago_id, servicio_id));