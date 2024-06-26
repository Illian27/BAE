# Hecho por: Illian Santiago n Ortega Posso
USE vitaloptics;

-- Inserciones
INSERT INTO cliente(nombre, telefono, apellido1, apellido2) VALUES
('Juan', '555-1234', 'Perez', 'Gomez'),
('Maria', '555-5678', 'Rodriguez', 'Lopez'),
('Carlos', '555-8765', 'Sanchez', 'Martinez');

INSERT INTO registrado (DNI, correo, nombre_usuario, contraseña, codigo_postal, direccion, cliente_id) VALUES
('12345678A', 'juan@example.com', 'juan123', 'password1', '28001', 'Calle Mayor 1', 1),
('23456789B', 'maria@example.com', 'maria456', 'password2', '28002', 'Calle Menor 2', 2),
('34567890C', 'carlos@example.com', 'carlos789', 'password3', '28003', 'Calle Central 3', 3);

INSERT INTO no_registrado (cliente_id) VALUES
(1),
(2),
(3);

INSERT INTO trabajador (nombre, apellido1, apellido2) VALUES
('Juan', 'Perez', 'Gomez'),
('Maria', 'Rodriguez', 'Lopez'),
('Carlos', 'Sanchez', 'Martinez');

INSERT INTO interno(trabajador_id, DNI, telefono, correo, num_cuenta) VALUES
(1, '12345678A', '555-1234', 'juan@example.com', 'ES7620770024003102575766'),
(2, '23456789B', '555-5678', 'maria@example.com', 'ES7620770024003102575767'),
(3, '34567890C', '555-8765', 'carlos@example.com', 'ES7620770024003102575768');

INSERT INTO externo(trabajador_id, profesion, empresa) VALUES
(1, 'Consultor', 'ABC Consulting'),
(2, 'Ingeniero', 'XYZ Engineering'),
(3, 'Analista', 'Data Solutions');

INSERT INTO pago(num_tarjeta, fecha, total) VALUES
('1234-5678-9012-3456', '2024-06-01', 100.50),
('2345-6789-0123-4567', '2024-06-02', 200.75),
('3456-7890-1234-5678', '2024-06-03', 150.00);

INSERT INTO factura(nombre_trabajador, fecha, direccion, idcliente, nombre_cliente, total, pago_id) VALUES
('Juan Perez', '2024-06-01', 'Calle Mayor 1', 1, 'Carlos Martinez', 100.50, 1),
('Maria Rodriguez', '2024-06-02', 'Calle Menor 2', 2, 'Ana Lopez', 200.75, 2),
('Carlos Sanchez', '2024-06-03', 'Calle Central 3', 3, 'Luis Gomez', 150.00, 3);

INSERT INTO producto(nombre, precio, color, dimenciones, stock) VALUES
('Silla', 49.99, 'Rojo', '40x40x90 cm', 10),
('Mesa', 89.99, 'Blanco', '120x60x75 cm', 5),
('Lámpara', 29.99, 'Azul', '30x30x50 cm', 20);

INSERT INTO servicio(nombre, precio, detalles, tipo) VALUES
('Limpieza', 25.00, 'Limpieza general', 'Óptica'),
('Mantenimiento', 50.00, 'Revisión y reparación de audifonos', 'Audiología'),
('Consultoría', 100.00, 'Asesoría en audioción', 'Audiología');

INSERT INTO interno_habilidades(interno_trabajador_id, habilidad) VALUES
(1, 'Comprensión'),
(2, 'Paciencia'),
(3, 'Tacto');

INSERT INTO es_jefe_de(trabajador_id, jefe_id) VALUES
(2, 1),
(3, 1),
(3, 2);

INSERT INTO promociona(registrado_cliente_id, cliente_id, codigo) VALUES
(1, 2, 'AB123'),
(2, 3, 'DE456'),
(3, 1, 'GH789');

INSERT INTO realiza(registrado_cliente_id, pago_id, oferta) VALUES
(1, 1, '10'),
(2, 2, '50'),
(3, 3, '100');

INSERT INTO hace(no_registrado_cliente_id, pago_id) VALUES
(1, 1),
(2, 2),
(3, 3);

INSERT INTO tramita(trabajador_id, cliente_id, factura_id, factura_pago_id) VALUES
(1, 1, 1, 1),
(2, 2, 2, 2),
(3, 3, 3, 3);

INSERT INTO tiene(factura_id, factura_pago_id, producto_id) VALUES
(1, 1, 1),
(2, 2, 2),
(3, 3, 3);

INSERT INTO contiene(factura_id, factura_pago_id, servicio_id) VALUES
(1, 1, 1),
(2, 2, 2),
(3, 3, 3);