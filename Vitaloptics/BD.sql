DROP DATABASE IF EXISTS vitaloptics;
CREATE DATABASE IF NOT EXISTS vitaloptics CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_as_Cs;
USE vitaloptics;


CREATE TABLE IF NOT EXISTS cliente (
  id INT UNSIGNED PRIMARY KEY AUTO_INCREMENT NOT NULL,
  nombre VARCHAR(15) NOT NULL,
  telefono VARCHAR(12) NOT NULL,
  apellido1 VARCHAR(25) NOT NULL,
  apellido2 VARCHAR(25) NOT NULL
);

CREATE TABLE IF NOT EXISTS trabajador (
  id INT UNSIGNED PRIMARY KEY AUTO_INCREMENT NOT NULL,
  nombre VARCHAR(15) NOT NULL,
  apellido1 VARCHAR(25) NOT NULL,
  apellido2 VARCHAR(25) NOT NULL
);

CREATE TABLE IF NOT EXISTS es_jefe_de (
  trabajador_id INT UNSIGNED PRIMARY KEY NOT NULL,
  es_jefe_de_trabajador_id INT UNSIGNED NOT NULL,
  CONSTRAINT fk_trabajador_es_jefe_de1 FOREIGN KEY(es_jefe_de_trabajador_id) REFERENCES es_jefe_de(trabajador_id) ON DELETE CASCADE ON UPDATE CASCADE,
  CONSTRAINT fk_es_jefe_de_trabajador1 FOREIGN KEY(trabajador_id) REFERENCES trabajador(id) ON DELETE CASCADE ON UPDATE CASCADE
);

CREATE TABLE IF NOT EXISTS pago (
  id INT UNSIGNED PRIMARY KEY AUTO_INCREMENT NOT NULL,
  num_tarjeta VARCHAR(16) NOT NULL,
  fecha DATE NOT NULL,
  total INT NOT NULL
);

CREATE TABLE IF NOT EXISTS registrado (
  DNI CHAR(9) PRIMARY KEY NOT NULL,
  correo VARCHAR(30) NOT NULL,
  nombre_usuario VARCHAR(15) NOT NULL,
  contraseña VARCHAR(30) NOT NULL,
  codigo_postal INT UNSIGNED NOT NULL,
  direccion VARCHAR(50) NOT NULL,
  cliente_id INT UNSIGNED NOT NULL UNIQUE,
  CONSTRAINT fk_registrado_cliente1 FOREIGN KEY(cliente_id) REFERENCES cliente(id) ON DELETE CASCADE ON UPDATE CASCADE
);

CREATE TABLE IF NOT EXISTS no_registrado (
  cliente_id INT UNSIGNED PRIMARY KEY NOT NULL,
  CONSTRAINT fk_no_registrado_cliente1 FOREIGN KEY(cliente_id) REFERENCES cliente(id) ON DELETE CASCADE ON UPDATE CASCADE
);

CREATE TABLE IF NOT EXISTS externo (
  trabajador_id INT UNSIGNED PRIMARY KEY NOT NULL,
  profesion VARCHAR(30) NOT NULL,
  empresa VARCHAR(30) NOT NULL,
  CONSTRAINT fk_externo_trabajador1 FOREIGN KEY(trabajador_id) REFERENCES trabajador(id) ON DELETE CASCADE ON UPDATE CASCADE
);

CREATE TABLE IF NOT EXISTS interno (
  trabajador_id INT UNSIGNED PRIMARY KEY NOT NULL,
  DNI CHAR(9) NOT NULL,
  telefono VARCHAR(12) NULL,
  correo VARCHAR(30) NOT NULL,
  num_cuenta VARCHAR(20) NOT NULL,
  CONSTRAINT fk_interno_trabajador1 FOREIGN KEY(trabajador_id) REFERENCES trabajador(id) ON DELETE CASCADE ON UPDATE CASCADE
);

CREATE TABLE IF NOT EXISTS factura (
  id INT UNSIGNED AUTO_INCREMENT NOT NULL,
  nombre_trabajador VARCHAR(15) NOT NULL,
  fecha DATE NOT NULL,
  direccion VARCHAR(50) NOT NULL,
  idcliente INT UNSIGNED NOT NULL,
  nombre_cliente VARCHAR(15) NULL,
  total INT UNSIGNED NOT NULL,
  pago_id INT UNSIGNED NOT NULL,
  CONSTRAINT fk_factura_pago FOREIGN KEY(pago_id) REFERENCES pago(id) ON DELETE CASCADE ON UPDATE CASCADE,
PRIMARY KEY (id, pago_id));

CREATE TABLE IF NOT EXISTS producto (
  id INT UNSIGNED PRIMARY KEY AUTO_INCREMENT NOT NULL,
  nombre VARCHAR(15) NOT NULL,
  precio INT UNSIGNED NOT NULL,
  color VARCHAR(12) NOT NULL,
  dimenciones VARCHAR(50) NOT NULL,
  stock INT NOT NULL
);

CREATE TABLE IF NOT EXISTS servicio (
  id INT UNSIGNED PRIMARY KEY AUTO_INCREMENT NOT NULL,
  nombre VARCHAR(15) NOT NULL,
  precio INT NOT NULL,
  detalles TEXT NOT NULL,
  tipo ENUM('Óptica', 'Audiología') NOT NULL
);

CREATE TABLE IF NOT EXISTS registrado_has_cliente (
  registrado_cliente_id INT UNSIGNED NOT NULL,
  cliente_id INT UNSIGNED NOT NULL,
  codigo CHAR(5) NOT NULL,
  CONSTRAINT fk_registrado_has_cliente_registrado1 FOREIGN KEY(registrado_cliente_id) REFERENCES registrado(cliente_id) ON DELETE CASCADE ON UPDATE CASCADE,
  CONSTRAINT fk_registrado_has_cliente_cliente1 FOREIGN KEY(cliente_id) REFERENCES cliente(id) ON DELETE CASCADE ON UPDATE CASCADE,
PRIMARY KEY (registrado_cliente_id, cliente_id));

CREATE TABLE IF NOT EXISTS realiza (
  registrado_cliente_id INT UNSIGNED NOT NULL,
  pago_id INT UNSIGNED NOT NULL,
  oferta VARCHAR(3) NULL,
  CONSTRAINT fk_realiza_registrado1 FOREIGN KEY(registrado_cliente_id) REFERENCES registrado(cliente_id) ON DELETE CASCADE ON UPDATE CASCADE,
  CONSTRAINT fk_realiza_pago1 FOREIGN KEY(pago_id) REFERENCES pago(id) ON DELETE CASCADE ON UPDATE CASCADE,
PRIMARY KEY (registrado_cliente_id, pago_id));

CREATE TABLE IF NOT EXISTS hace (
  no_registrado_cliente_id INT UNSIGNED NOT NULL,
  pago_id INT UNSIGNED NOT NULL,
  CONSTRAINT fk_hace_no_registrado1 FOREIGN KEY(no_registrado_cliente_id) REFERENCES no_registrado(cliente_id) ON DELETE CASCADE ON UPDATE CASCADE,
  CONSTRAINT fk_hace_pago1 FOREIGN KEY(pago_id) REFERENCES pago(id) ON DELETE CASCADE ON UPDATE CASCADE,
PRIMARY KEY (no_registrado_cliente_id, pago_id));

CREATE TABLE IF NOT EXISTS tramita (
  trabajador_id INT UNSIGNED NOT NULL,
  cliente_id INT UNSIGNED NOT NULL,
  factura_id INT UNSIGNED NOT NULL,
  factura_pago_id INT UNSIGNED NOT NULL,
  CONSTRAINT fk_tramita_trabajador1 FOREIGN KEY(trabajador_id) REFERENCES trabajador(id) ON DELETE CASCADE ON UPDATE CASCADE,
  CONSTRAINT fk_tramita_cliente1 FOREIGN KEY(cliente_id) REFERENCES cliente(id) ON DELETE CASCADE ON UPDATE CASCADE,
  CONSTRAINT fk_tramita_factura1 FOREIGN KEY(factura_id , factura_pago_id) REFERENCES factura(id , pago_id) ON DELETE CASCADE ON UPDATE CASCADE,
PRIMARY KEY (trabajador_id, cliente_id));

CREATE TABLE IF NOT EXISTS tiene (
  factura_id INT UNSIGNED NOT NULL,
  factura_pago_id INT UNSIGNED NOT NULL,
  producto_id INT UNSIGNED NOT NULL,
  CONSTRAINT fk_factura_has_producto_factura1 FOREIGN KEY(factura_id , factura_pago_id) REFERENCES factura(id , pago_id) ON DELETE CASCADE ON UPDATE CASCADE,
  CONSTRAINT fk_factura_has_producto_producto1 FOREIGN KEY(producto_id) REFERENCES producto(id) ON DELETE CASCADE ON UPDATE CASCADE,
PRIMARY KEY (factura_id, factura_pago_id, producto_id));

CREATE TABLE IF NOT EXISTS contiene (
  factura_id INT UNSIGNED NOT NULL,
  factura_pago_id INT UNSIGNED NOT NULL,
  servicio_id INT UNSIGNED NOT NULL,
  CONSTRAINT fk_factura_has_servicio_factura1 FOREIGN KEY(factura_id , factura_pago_id) REFERENCES factura(id , pago_id) ON DELETE CASCADE ON UPDATE CASCADE,
  CONSTRAINT fk_factura_has_servicio_servicio1 FOREIGN KEY(servicio_id) REFERENCES servicio(id) ON DELETE CASCADE ON UPDATE CASCADE,
PRIMARY KEY (factura_id, factura_pago_id, servicio_id));

CREATE TABLE IF NOT EXISTS interno_habilidades (
  interno_trabajador_id INT UNSIGNED NOT NULL,
  habilidades VARCHAR(20) NOT NULL,
  CONSTRAINT fk_interno_habilidades_interno1 FOREIGN KEY(interno_trabajador_id) REFERENCES interno(trabajador_id) ON DELETE CASCADE ON UPDATE CASCADE
);

CREATE TABLE IF NOT EXISTS factura_nombre_compra (
  factura_id INT UNSIGNED NOT NULL,
  factura_pago_id INT UNSIGNED NOT NULL,
  nombre_compra VARCHAR(20) NOT NULL,
  CONSTRAINT fk_factura__factura1 FOREIGN KEY(factura_id , factura_pago_id) REFERENCES factura(id , pago_id) ON DELETE CASCADE ON UPDATE CASCADE,
PRIMARY KEY (factura_id, factura_pago_id));

CREATE TABLE IF NOT EXISTS factura_precio_compra (
  factura_id INT UNSIGNED NOT NULL,
  factura_pago_id INT UNSIGNED NOT NULL,
  precio_compra INT UNSIGNED NOT NULL,
  CONSTRAINT fk_factura__factura10 FOREIGN KEY(factura_id , factura_pago_id) REFERENCES factura(id , pago_id) ON DELETE CASCADE ON UPDATE CASCADE,
PRIMARY KEY (factura_id, factura_pago_id));

-- Inserciones
INSERT INTO () VALUES
(),
(),
();