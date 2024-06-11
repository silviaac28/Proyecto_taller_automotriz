INSERT INTO ciudad (nombre) VALUES 
('Bogotá'),
('Medellín'),
('Cali'),
('Barranquilla'),
('Cartagena'),
('Bucaramanga'),
('Cúcuta'),
('Santa Marta'),
('Pereira'),
('Ibagué'),
('Pasto'),
('Manizales'),
('Neiva'),
('Villavicencio'),
('Montería'),
('Valledupar'),
('Armenia'),
('Sincelejo'),
('Popayán'),
('Tunja');

INSERT INTO telefono_cliente (telefono, email) VALUES
('3001234567', 'juan.perez@example.com'),
('3002345678', 'maria.gomez@example.com'),
('3003456789', 'pedro.rodriguez@example.com'),
('3004567890', 'ana.martinez@example.com'),
('3005678901', 'luis.garcia@example.com'),
('3006789012', 'carlos.moreno@example.com'),
('3007890123', 'diana.lopez@example.com'),
('3008901234', 'jorge.martin@example.com'),
('3009012345', 'laura.fernandez@example.com'),
('3000123456', 'miguel.ramirez@example.com');

INSERT INTO cliente (tipo_documento, documento, nombre, apellido, direccion, ciudad_id, telefono_cliente_id) VALUES 
('CC', '123456789', 'Juan', 'Pérez', 'Calle 123', 1, 1),
('NIT', '1234567890-1', 'María', 'López', 'Carrera 456', 2, 2),
('CC', '234567890', 'Pedro', 'Gómez', 'Avenida 789', 3, 3),
('CC', '345678901', 'Ana', 'Martínez', 'Calle 456', 4, 4),
('NIT', '2345678901-2', 'Luis', 'Rodríguez', 'Carrera 789', 11, 5),
('CC', '456789012', 'Laura', 'García', 'Avenida 123', 6, 6),
('CC', '567890123', 'Carlos', 'Hernández', 'Calle 789', 17, 7),
('NIT', '3456789012-3', 'Sofía', 'Díaz', 'Carrera 123', 8, 8),
('CC', '678901234', 'Andrés', 'Sánchez', 'Avenida 456', 18, 9),
('CC', '789012345', 'Paola', 'Ramírez', 'Calle 789', 10, 10);

INSERT INTO marca (nombre) VALUES
('Toyota'),
('Nissan'),
('Ford'),
('Chevrolet'),
('Honda'),
('Mazda'),
('Hyundai'),
('Kia'),
('Volkswagen'),
('Renault');

INSERT INTO modelo (nombre, marca_id) VALUES
('Corolla', 1),
('Sentra', 2),
('Focus', 3),
('Cruze', 4),
('Civic', 5),
('Mazda3', 6),
('Elantra', 7),
('Rio', 8),
('Golf', 9),
('Duster', 10);

INSERT INTO vehiculo (placa, modelo_id, año, cliente_id, kilometraje) VALUES
('ABC123', 1, '2018-01-01', 1, 45000),
('DEF456', 2, '2019-01-01', 2, 30000),
('GHI789', 3, '2017-01-01', 3, 60000),
('JKL012', 4, '2020-01-01', 4, 10000),
('MNO345', 5, '2016-01-01', 5, 120000),
('PQR678', 6, '2018-01-01', 6, 45000),
('STU901', 7, '2019-01-01', 7, 30000),
('VWX234', 8, '2017-01-01', 8, 60000),
('YZA567', 9, '2020-01-01', 9, 10000),
('BCD890', 10, '2016-01-01', 10, 120000),
('CWR582', 9, '2022-01-01', 9, 22000);


INSERT INTO telefono_empleado (telefono, email) VALUES
('3001112233', 'carlos.mendez@example.com'),
('3002223344', 'ana.suarez@example.com'),
('3003334455', 'luis.perez@example.com'),
('3004445566', 'maria.lopez@example.com'),
('3005556677', 'jose.martinez@example.com'),
('3006667788', 'sandra.rodriguez@example.com'),
('3007778899', 'david.gonzalez@example.com'),
('3008889900', 'laura.hernandez@example.com'),
('3009990011', 'miguel.ramirez@example.com'),
('3000001122', 'sofia.garcia@example.com');

INSERT INTO empleado (nombre, apellido, direccion, telefono_empleado_id) VALUES
('Carlos', 'Mendez', 'Calle 45', 1),
('Ana', 'Suarez', 'Carrera 67', 2),
('Luis', 'Perez', 'Avenida 89', 3),
('Maria', 'Lopez', 'Calle 21', 4),
('Jose', 'Martinez', 'Carrera 34', 5),
('Sandra', 'Rodriguez', 'Avenida 56', 6),
('David', 'Gonzalez', 'Calle 78', 7),
('Laura', 'Hernandez', 'Carrera 90', 8),
('Miguel', 'Ramirez', 'Avenida 12', 9),
('Sofia', 'Garcia', 'Calle 34', 10);


INSERT INTO servicio (nombre, descripcion, costo) VALUES
('Cambio de aceite', 'Cambio de aceite y filtro', 50000),
('Alineación', 'Alineación de las cuatro ruedas', 80000),
('Balanceo', 'Balanceo de las cuatro ruedas', 60000),
('Revisión de frenos', 'Revisión y ajuste de frenos', 70000),
('Revisión de suspensión', 'Revisión y ajuste de suspensión', 90000),
('Cambio de pastillas de freno', 'Cambio de pastillas de freno delanteras y traseras', 120000),
('Cambio de bujías', 'Cambio de bujías del motor', 40000),
('Revisión de motor', 'Revisión completa del motor', 150000),
('Cambio de filtro de aire', 'Cambio de filtro de aire del motor', 30000),
('Revisión eléctrica', 'Revisión y ajuste del sistema eléctrico', 100000);

INSERT INTO reparaciones (fecha, vehiculo_id, empleado_id, servicio_id, costo_total, descripcion, duracion) VALUES
('2023-05-01', 1, 1, 1, 44000, 'Cambio de aceite y filtro', '01:00:00'),
('2023-05-02', 2, 2, 2, 68000, 'Alineación de las ruedas', '02:00:00'),
('2023-05-03', 3, 3, 3, 52000, 'Balanceo de las ruedas', '01:30:00'),
('2023-05-04', 4, 4, 4, 60000, 'Revisión y ajuste de frenos', '01:45:00'),
('2023-05-05', 5, 5, 5, 76000, 'Revisión y ajuste de suspensión', '02:30:00'),
('2023-05-06', 6, 6, 6, 100000, 'Cambio de pastillas de freno', '02:15:00'),
('2023-05-07', 7, 7, 7, 36000, 'Cambio de bujías del motor', '01:15:00'),
('2023-05-08', 8, 8, 8, 124000, 'Revisión completa del motor', '03:00:00'),
('2023-05-09', 9, 9, 9, 28000, 'Cambio de filtro de aire del motor', '00:45:00'),
('2023-05-10', 10, 10, 10, 84000, 'Revisión y ajuste del sistema eléctrico', '02:45:00'),
('2023-08-18', 2, 3, 6, 100000, 'Cambio periodico pastillas de freno', '01:30:00'),
('2024-01-08', 4, 8, 7, 85000, 'cambio mantenimiento bujías', '01:30:00'),
('2023-07-25', 6, 9, 10, 130000, 'Mantenimiento periodico sistema electrico', '01:30:00'),
('2023-12-02', 9, 5, 10, 56000, 'Revisión sistema eléctrico', '01:15:00'),
('2023-08-18', 7, 4, 5, 89000, 'Revisión suspensión', '01:15:00'),
('2023-09-09', 8, 9, 10, 110000, 'Revisión sistema eléctrico', '02:25:00'),
('2023-05-20', 1, 1, 1, 20000, 'Cambio de aceite', '00:30:00');


INSERT INTO telefono_proveedor (telefono, email) VALUES
('3011112233', 'carlos.ramos@proveedor1.com'),
('3012223344', 'ana.torres@proveedor2.com'),
('3013334455', 'luis.gomez@proveedor3.com'),
('3014445566', 'maria.martinez@proveedor4.com'),
('3015556677', 'jose.garcia@proveedor5.com'),
('3016667788', 'sandra.perez@proveedor6.com'),
('3017778899', 'david.lopez@proveedor7.com'),
('3018889900', 'laura.hernandez@proveedor8.com'),
('3019990011', 'fernando.ramirez@proveedor9.com'),
('3010001122', 's.garcia@proveedor10.com');


INSERT INTO proveedor (nombre_proveedor, nombre_contacto, apellido_contacto, telefono_contacto, telefono_proveedor_id) VALUES
('Proveedor1', 'Carlos', 'Ramos', '3011112233', 1),
('Proveedor2', 'Ana', 'Torres', '3012223344', 2),
('Proveedor3', 'Luis', 'Gomez', '3013334455', 3),
('Proveedor4', 'Maria', 'Martinez', '3014445566', 4),
('Proveedor5', 'Jose', 'Garcia', '3015556677', 5),
('Proveedor6', 'Sandra', 'Perez', '3016667788', 6),
('Proveedor7', 'David', 'Lopez', '3017778899', 7),
('Proveedor8', 'Laura', 'Hernandez', '3018889900', 8),
('Proveedor9', 'Fernando', 'Ramirez', '3019990011', 9),
('Proveedor10', 'Sofia', 'Garcia', '3010001122', 10);


INSERT INTO piezas (nombre, descripcion, precio, proveedor_id) VALUES
('Aceite', 'Aceite para motor 10W-30', 20000, 1),
('Filtro de aceite', 'Filtro de aceite para motor', 15000, 2),
('Filtro de aire', 'Filtro de aire para motor', 10000, 3),
('Bujías', 'Juego de bujías para motor', 50000, 4),
('Pastillas de freno', 'Juego de pastillas de freno', 70000, 5),
('Amortiguadores', 'Juego de amortiguadores', 120000, 6),
('Batería', 'Batería para automóvil', 300000, 7),
('Llanta', 'Llanta 195/65 R15', 250000, 8),
('Espejo retrovisor', 'Espejo retrovisor lateral', 45000, 9),
('Luz delantera', 'Luz delantera para automóvil', 90000, 10);


INSERT INTO ubicacion (nombre) VALUES
('Taller principal'),
('Área de pintura'),
('Zona de servicio'),
('Almacén de repuestos'),
('Área de diagnóstico'),
('Zona de lavado'),
('Zona de espera'),
('Oficinas administrativas'),
('Área de montaje'),
('Estacionamiento');


INSERT INTO inventario (pieza_id, cantidad, stock_minimo, ubicacion_id, stock_inicial) VALUES
(1, 50, 30, 1, 50),
(2, 30, 30, 1, 30),
(3, 20, 40, 2, 20),
(4, 15, 40, 2, 15),
(5, 40, 50, 3, 40),
(6, 52, 50, 3, 52),
(7, 60, 50, 4, 60),
(8, 55, 60, 4, 55),
(9, 42, 50, 5, 42),
(10, 38, 40, 5, 38);


INSERT INTO facturacion (fecha, cliente_id, total) VALUES
('2023-05-01', 1, 55000),
('2023-05-02', 2, 85000),
('2023-05-03', 3, 65000),
('2023-05-04', 4, 75000),
('2023-05-05', 5, 95000),
('2023-05-06', 6, 125000),
('2023-05-07', 7, 45000),
('2023-05-08', 8, 155000),
('2023-05-09', 9, 35000),
('2023-05-10', 10, 105000);

INSERT INTO factura_detalle (factura_id, reparacion_id, cantidad, precio) VALUES
(1, 1, 1, 55000),
(2, 2, 1, 85000),
(3, 3, 1, 65000),
(4, 4, 1, 75000),
(5, 5, 1, 95000),
(6, 6, 1, 125000),
(7, 7, 1, 45000),
(8, 8, 1, 155000),
(9, 9, 1, 35000),
(10, 10, 1, 105000);


INSERT INTO reparacion_piezas (reparacion_id, pieza_id, cantidad) VALUES
(1, 1, 1),
(2, 2, 1),
(3, 3, 1),
(4, 4, 1),
(5, 5, 1),
(6, 6, 1),
(7, 7, 1),
(8, 8, 1),
(9, 9, 1),
(10, 10, 1),
(11, 5, 1),
(12, 4, 1),
(13, 10, 1),
(14, 7, 1),
(15, 10, 1),
(16, 10, 1),
(17, 1, 1);


INSERT INTO orden_compra (fecha, proveedor_id, empleado_id, total) VALUES
('2024-06-01', 1, 1, 500000),
('2024-06-02', 2, 2, 700000),
('2024-06-03', 3, 3, 600000),
('2024-06-04', 4, 4, 800000),
('2024-06-05', 5, 5, 900000),
('2024-06-06', 6, 6, 1200000),
('2024-06-07', 7, 7, 400000),
('2024-06-08', 8, 8, 1300000),
('2024-06-09', 9, 9, 300000),
('2024-06-10', 10, 10, 1100000);

INSERT INTO orden_detalle (orden_id, pieza_id, cantidad, precio_unitario) VALUES
(1, 1, 10, 20000),
(1, 2, 10, 30000),
(2, 3, 10, 30000),
(2, 4, 10, 40000),
(3, 5, 5, 60000),
(3, 6, 10, 30000),
(4, 7, 5, 100000),
(4, 8, 2, 150000),
(5, 9, 10, 45000),
(5, 10, 5, 90000),
(6, 1, 10, 50000),
(6, 2, 10, 70000),
(7, 3, 5, 40000),
(7, 4, 10, 20000),
(8, 5, 5, 100000),
(8, 6, 5, 160000),
(9, 7, 4, 50000),
(9, 8, 4, 25000),
(10, 9, 10, 65000),
(10, 10, 5, 90000);


INSERT INTO cita (fecha_hora, cliente_id, vehiculo_id, servicio_id) VALUES
('2024-06-01 09:00:00', 1, 1, 1),
('2024-06-02 10:00:00', 2, 2, 2),
('2024-06-03 11:00:00', 3, 3, 3),
('2024-06-04 12:00:00', 4, 4, 4),
('2024-06-05 13:00:00', 5, 5, 5),
('2024-06-06 14:00:00', 6, 6, 6),
('2024-06-07 15:00:00', 7, 7, 7),
('2024-06-08 16:00:00', 8, 8, 8),
('2024-06-09 17:00:00', 9, 9, 9),
('2024-06-10 18:00:00', 10, 10, 10),
('2024-06-10 10:00:00', 2, 2, 10);
