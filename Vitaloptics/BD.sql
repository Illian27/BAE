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
INSERT INTO cliente(nombre, telefono, apellido1, apellido2) VALUES
('Juan', '555-1234', 'Perez', 'Gomez'),
('Maria', '555-5678', 'Rodriguez', 'Lopez'),
('Carlos', '555-8765', 'Sanchez', 'Martinez');


CREATE TABLE registrado (
  DNI CHAR(9) PRIMARY KEY NOT NULL,
  correo VARCHAR(30) NOT NULL,
  nombre_usuario VARCHAR(15) NOT NULL,
  contraseña VARCHAR(30) NOT NULL,
  codigo_postal INT UNSIGNED NOT NULL,
  direccion VARCHAR(50) NOT NULL,
  cliente_id INT UNSIGNED NOT NULL UNIQUE,
  CONSTRAINT fk_registrado_cliente1 FOREIGN KEY(cliente_id) REFERENCES cliente(id) ON DELETE CASCADE ON UPDATE CASCADE
);
INSERT INTO registrado (DNI, correo, nombre_usuario, contraseña, codigo_postal, direccion, cliente_id) VALUES
('12345678A', 'juan@example.com', 'juan123', 'password1', '28001', 'Calle Mayor 1', 1),
('23456789B', 'maria@example.com', 'maria456', 'password2', '28002', 'Calle Menor 2', 2),
('34567890C', 'carlos@example.com', 'carlos789', 'password3', '28003', 'Calle Central 3', 3);

CREATE TABLE no_registrado (
  cliente_id INT UNSIGNED PRIMARY KEY NOT NULL,
  CONSTRAINT fk_no_registrado_cliente1 FOREIGN KEY(cliente_id) REFERENCES cliente(id) ON DELETE CASCADE ON UPDATE CASCADE
);
INSERT INTO no_registrado (cliente_id) VALUES
(1),
(2),
(3);

CREATE TABLE trabajador (
  id INT UNSIGNED PRIMARY KEY AUTO_INCREMENT NOT NULL,
  nombre VARCHAR(15) NOT NULL,
  apellido1 VARCHAR(25) NOT NULL,
  apellido2 VARCHAR(25) NOT NULL
);
INSERT INTO trabajador (nombre, apellido1, apellido2) VALUES
('Juan', 'Perez', 'Gomez'),
('Maria', 'Rodriguez', 'Lopez'),
('Carlos', 'Sanchez', 'Martinez');

CREATE TABLE interno (
  trabajador_id INT UNSIGNED PRIMARY KEY NOT NULL,
  DNI CHAR(9) NOT NULL,
  telefono VARCHAR(12) NULL,
  correo VARCHAR(30) NOT NULL,
  num_cuenta CHAR(24) NOT NULL,
  CONSTRAINT fk_interno_trabajador1 FOREIGN KEY(trabajador_id) REFERENCES trabajador(id) ON DELETE CASCADE ON UPDATE CASCADE
);
INSERT INTO interno(trabajador_id, DNI, telefono, correo, num_cuenta) VALUES
(1, '12345678A', '555-1234', 'juan@example.com', 'ES7620770024003102575766'),
(2, '23456789B', '555-5678', 'maria@example.com', 'ES7620770024003102575767'),
(3, '34567890C', '555-8765', 'carlos@example.com', 'ES7620770024003102575768');

CREATE TABLE externo (
  trabajador_id INT UNSIGNED PRIMARY KEY NOT NULL,
  profesion VARCHAR(30) NOT NULL,
  empresa VARCHAR(30) NOT NULL,
  CONSTRAINT fk_externo_trabajador1 FOREIGN KEY(trabajador_id) REFERENCES trabajador(id) ON DELETE CASCADE ON UPDATE CASCADE
);
INSERT INTO externo(trabajador_id, profesion, empresa) VALUES
(1, 'Consultor', 'ABC Consulting'),
(2, 'Ingeniero', 'XYZ Engineering'),
(3, 'Analista', 'Data Solutions');

CREATE TABLE pago (
  id INT UNSIGNED PRIMARY KEY AUTO_INCREMENT NOT NULL,
  num_tarjeta VARCHAR(19) NOT NULL,
  fecha DATETIME NOT NULL,
  total FLOAT4 NOT NULL
);
INSERT INTO pago(num_tarjeta, fecha, total) VALUES
('1234-5678-9012-3456', '2024-06-01', 100.50),
('2345-6789-0123-4567', '2024-06-02', 200.75),
('3456-7890-1234-5678', '2024-06-03', 150.00);

CREATE TABLE factura (
  id INT UNSIGNED AUTO_INCREMENT NOT NULL,
  nombre_trabajador VARCHAR(15) NOT NULL,
  fecha DATETIME NOT NULL,
  direccion VARCHAR(50) NOT NULL,
  idcliente INT UNSIGNED NOT NULL,
  nombre_cliente VARCHAR(15),
  total INT UNSIGNED NOT NULL,
  pago_id INT UNSIGNED NOT NULL,
  CONSTRAINT fk_factura_pago FOREIGN KEY(pago_id) REFERENCES pago(id) ON DELETE RESTRICT ON UPDATE CASCADE,
PRIMARY KEY (id, pago_id));
INSERT INTO factura(nombre_trabajador, fecha, direccion, idcliente, nombre_cliente, total, pago_id) VALUES
('Juan Perez', '2024-06-01', 'Calle Mayor 1', 1, 'Carlos Martinez', 100.50, 1),
('Maria Rodriguez', '2024-06-02', 'Calle Menor 2', 2, 'Ana Lopez', 200.75, 2),
('Carlos Sanchez', '2024-06-03', 'Calle Central 3', 3, 'Luis Gomez', 150.00, 3);

CREATE TABLE producto (
  id INT UNSIGNED PRIMARY KEY AUTO_INCREMENT NOT NULL,
  nombre VARCHAR(15) NOT NULL,
  precio FLOAT4 UNSIGNED NOT NULL,
  color VARCHAR(12) NOT NULL,
  dimenciones VARCHAR(50) NOT NULL,
  stock INT NOT NULL
);
INSERT INTO producto(nombre, precio, color, dimenciones, stock) VALUES
('Silla', 49.99, 'Rojo', '40x40x90 cm', 10),
('Mesa', 89.99, 'Blanco', '120x60x75 cm', 5),
('Lámpara', 29.99, 'Azul', '30x30x50 cm', 20);

CREATE TABLE servicio (
  id INT UNSIGNED PRIMARY KEY AUTO_INCREMENT NOT NULL,
  nombre VARCHAR(15) NOT NULL,
  precio FLOAT4 NOT NULL,
  detalles TEXT NOT NULL,
  tipo ENUM('Óptica', 'Audiología') NOT NULL
);
INSERT INTO servicio(nombre, precio, detalles, tipo) VALUES
('Limpieza', 25.00, 'Limpieza general', 'Óptica'),
('Mantenimiento', 50.00, 'Revisión y reparación de audifonos', 'Audiología'),
('Consultoría', 100.00, 'Asesoría en audioción', 'Audiología');

-- Tablas de normalizaciones
CREATE TABLE interno_habilidades (
  interno_trabajador_id INT UNSIGNED PRIMARY KEY NOT NULL,
  habilidad VARCHAR(20) NOT NULL,
  CONSTRAINT fk_interno_habilidades_interno1 FOREIGN KEY(interno_trabajador_id) REFERENCES interno(trabajador_id) ON DELETE CASCADE ON UPDATE CASCADE
);
INSERT INTO interno_habilidades(interno_trabajador_id, habilidad) VALUES
(1, 'Comprensión'),
(2, 'Paciencia'),
(3, 'Tacto');

-- Tablas de relaciones
CREATE TABLE es_jefe_de (
  trabajador_id INT UNSIGNED NOT NULL,
  jefe_id INT UNSIGNED NOT NULL,
  CONSTRAINT fk_jefe FOREIGN KEY(jefe_id) REFERENCES trabajador(id) ON DELETE CASCADE ON UPDATE CASCADE,
  CONSTRAINT fk_es_jefe_de_trabajador1 FOREIGN KEY(trabajador_id) REFERENCES trabajador(id) ON DELETE CASCADE ON UPDATE RESTRICT,
PRIMARY KEY(trabajador_id, jefe_id));
INSERT INTO es_jefe_de(trabajador_id, jefe_id) VALUES
(1, 2),
(2, 3),
(3, 1);

CREATE TABLE promociona (
  registrado_cliente_id INT UNSIGNED NOT NULL,
  cliente_id INT UNSIGNED NOT NULL,
  codigo CHAR(5) NOT NULL,
  CONSTRAINT fk_registrado_has_cliente_registrado1 FOREIGN KEY(registrado_cliente_id) REFERENCES registrado(cliente_id) ON DELETE RESTRICT ON UPDATE RESTRICT,
  CONSTRAINT fk_registrado_has_cliente_cliente1 FOREIGN KEY(cliente_id) REFERENCES cliente(id) ON DELETE CASCADE ON UPDATE CASCADE,
PRIMARY KEY (registrado_cliente_id, cliente_id));
INSERT INTO promociona(registrado_cliente_id, cliente_id, codigo) VALUES
(1, 2, 'AB123'),
(2, 3, 'DE456'),
(3, 1, 'GH789');

CREATE TABLE realiza (
  registrado_cliente_id INT UNSIGNED NOT NULL,
  pago_id INT UNSIGNED NOT NULL,
  oferta INT NULL,
  CONSTRAINT fk_realiza_registrado1 FOREIGN KEY(registrado_cliente_id) REFERENCES registrado(cliente_id) ON DELETE CASCADE ON UPDATE CASCADE,
  CONSTRAINT fk_realiza_pago1 FOREIGN KEY(pago_id) REFERENCES pago(id) ON DELETE RESTRICT ON UPDATE CASCADE,
PRIMARY KEY (registrado_cliente_id, pago_id));
INSERT INTO realiza(registrado_cliente_id, pago_id, oferta) VALUES
(1, 1, '10'),
(2, 2, '50'),
(3, 3, '100');

CREATE TABLE hace (
  no_registrado_cliente_id INT UNSIGNED NOT NULL,
  pago_id INT UNSIGNED NOT NULL,
  CONSTRAINT fk_hace_no_registrado1 FOREIGN KEY(no_registrado_cliente_id) REFERENCES no_registrado(cliente_id) ON DELETE CASCADE ON UPDATE CASCADE,
  CONSTRAINT fk_hace_pago1 FOREIGN KEY(pago_id) REFERENCES pago(id) ON DELETE CASCADE ON UPDATE CASCADE,
PRIMARY KEY (no_registrado_cliente_id, pago_id));
INSERT INTO hace(no_registrado_cliente_id, pago_id) VALUES
(1, 1),
(2, 2),
(3, 3);

CREATE TABLE tramita (
  trabajador_id INT UNSIGNED NOT NULL,
  cliente_id INT UNSIGNED NOT NULL,
  factura_id INT UNSIGNED NOT NULL,
  factura_pago_id INT UNSIGNED NOT NULL,
  CONSTRAINT fk_tramita_trabajador1 FOREIGN KEY(trabajador_id) REFERENCES trabajador(id) ON DELETE CASCADE ON UPDATE CASCADE,
  CONSTRAINT fk_tramita_cliente1 FOREIGN KEY(cliente_id) REFERENCES cliente(id) ON DELETE CASCADE ON UPDATE CASCADE,
  CONSTRAINT fk_tramita_factura1 FOREIGN KEY(factura_id , factura_pago_id) REFERENCES factura(id , pago_id) ON DELETE RESTRICT ON UPDATE RESTRICT,
PRIMARY KEY (trabajador_id, cliente_id));
INSERT INTO tramita(trabajador_id, cliente_id, factura_id, factura_pago_id) VALUES
(1, 1, 1, 1),
(2, 2, 2, 2),
(3, 3, 3, 3);

CREATE TABLE tiene (
  factura_id INT UNSIGNED NOT NULL,
  factura_pago_id INT UNSIGNED NOT NULL,
  producto_id INT UNSIGNED NOT NULL,
  CONSTRAINT fk_factura_has_producto_factura1 FOREIGN KEY(factura_id , factura_pago_id) REFERENCES factura(id , pago_id) ON DELETE CASCADE ON UPDATE CASCADE,
  CONSTRAINT fk_factura_has_producto_producto1 FOREIGN KEY(producto_id) REFERENCES producto(id) ON DELETE RESTRICT ON UPDATE RESTRICT,
PRIMARY KEY (factura_id, factura_pago_id, producto_id));
INSERT INTO tiene(factura_id, factura_pago_id, producto_id) VALUES
(1, 1, 1),
(2, 2, 2),
(3, 3, 3);

CREATE TABLE contiene (
  factura_id INT UNSIGNED NOT NULL,
  factura_pago_id INT UNSIGNED NOT NULL,
  servicio_id INT UNSIGNED NOT NULL,
  CONSTRAINT fk_factura_has_servicio_factura1 FOREIGN KEY(factura_id , factura_pago_id) REFERENCES factura(id , pago_id) ON DELETE CASCADE ON UPDATE CASCADE,
  CONSTRAINT fk_factura_has_servicio_servicio1 FOREIGN KEY(servicio_id) REFERENCES servicio(id) ON DELETE RESTRICT ON UPDATE CASCADE,
PRIMARY KEY (factura_id, factura_pago_id, servicio_id));
INSERT INTO contiene(factura_id, factura_pago_id, servicio_id) VALUES
(1, 1, 1),
(2, 2, 2),
(3, 3, 3);