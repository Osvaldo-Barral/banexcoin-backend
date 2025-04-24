CREATE TABLE usuarios (
    id SERIAL PRIMARY KEY,
    nombre TEXT NOT NULL,
    correo TEXT UNIQUE NOT NULL
);

CREATE TABLE cuentas (
    id SERIAL PRIMARY KEY,
    id_usuario INT NOT NULL REFERENCES usuarios(id),
    saldo NUMERIC NOT NULL DEFAULT 0,
    id_referido INT REFERENCES cuentas(id)
);

CREATE TABLE transacciones (
    id SERIAL PRIMARY KEY,
    cuenta_origen INT NOT NULL REFERENCES cuentas(id),
    cuenta_destino INT NOT NULL REFERENCES cuentas(id),
    monto NUMERIC NOT NULL,
    comision NUMERIC NOT NULL,
    fecha TIMESTAMP NOT NULL DEFAULT NOW()
);

CREATE TABLE comisiones (
    id SERIAL PRIMARY KEY,
    id_transaccion INT NOT NULL REFERENCES transacciones(id),
    cuenta_beneficiaria INT NOT NULL REFERENCES cuentas(id),
    monto NUMERIC NOT NULL,
    fecha TIMESTAMP NOT NULL DEFAULT NOW()
);

INSERT INTO usuarios (nombre, correo) VALUES
('Juan Pérez López', 'juan.perez@email.com'),
('María García Sánchez', 'maria.garcia@email.com'),
('Carlos Hernández Martínez', 'carlos.hernandez@email.com'),
('Ana López Ramírez', 'ana.lopez@email.com'),
('Pedro Martínez González', 'pedro.martinez@email.com'),
('Laura Díaz Fernández', 'laura.diaz@email.com'),
('Jorge Ruiz Torres', 'jorge.ruiz@email.com'),
('Sofía Vargas Mendoza', 'sofia.vargas@email.com'),
('Ricardo Castro Ortega', 'ricardo.castro@email.com'),
('Elena Silva Romero', 'elena.silva@email.com');


INSERT INTO cuentas (id_usuario, saldo, id_referido) VALUES
(1, 1500.75, NULL),
(2, 2300.50, 1),
(3, 1800.25, 2),
(4, 3200.00, NULL),
(5, 2750.80, 3),
(6, 1900.45, NULL),
(7, 4100.90, 5),
(8, 1250.30, 4),
(9, 3600.75, NULL),
(10, 2800.20, 6);

-- Usuario 1 (5 transacciones - NO genera comisiones porque id_referido es NULL)
INSERT INTO transacciones (cuenta_origen, cuenta_destino, monto, comision, fecha) VALUES
(1, 2, 200.50, 2.005, '2023-01-05 09:15:22'),
(1, 3, 150.75, 1.5075, '2023-01-12 14:30:45'),
(1, 4, 300.25, 3.0025, '2023-01-18 11:20:33'),
(1, 5, 100.00, 1.00, '2023-01-25 16:45:12'),
(1, 6, 250.80, 2.508, '2023-02-02 10:10:10');

-- Usuario 2 (6 transacciones - genera comisiones)
INSERT INTO transacciones (cuenta_origen, cuenta_destino, monto, comision, fecha) VALUES
(2, 1, 75.30, 0.753, '2023-01-07 13:25:18'),
(2, 3, 125.45, 1.2545, '2023-01-14 15:40:22'),
(2, 4, 80.90, 0.809, '2023-01-21 17:30:45'),
(2, 5, 200.60, 2.006, '2023-01-28 12:15:33'),
(2, 7, 90.25, 0.9025, '2023-02-04 14:20:11'),
(2, 8, 110.75, 1.1075, '2023-02-11 09:45:29');

INSERT INTO comisiones (id_transaccion, cuenta_beneficiaria, monto, fecha) VALUES
(6, 1, 0.3765, '2023-01-07 13:25:18'),
(7, 1, 0.62725, '2023-01-14 15:40:22'),
(8, 1, 0.4045, '2023-01-21 17:30:45'),
(9, 1, 1.003, '2023-01-28 12:15:33'),
(10, 1, 0.45125, '2023-02-04 14:20:11'),
(11, 1, 0.55375, '2023-02-11 09:45:29');

-- Usuario 3 (7 transacciones - genera comisiones)
INSERT INTO transacciones (cuenta_origen, cuenta_destino, monto, comision, fecha) VALUES
(3, 1, 60.40, 0.604, '2023-01-09 10:30:15'),
(3, 2, 95.55, 0.9555, '2023-01-16 12:45:28'),
(3, 4, 130.70, 1.307, '2023-01-23 14:20:39'),
(3, 5, 70.85, 0.7085, '2023-01-30 16:30:47'),
(3, 6, 85.90, 0.859, '2023-02-06 11:15:22'),
(3, 7, 120.35, 1.2035, '2023-02-13 13:40:18'),
(3, 8, 55.80, 0.558, '2023-02-20 15:25:33');

INSERT INTO comisiones (id_transaccion, cuenta_beneficiaria, monto, fecha) VALUES
(12, 2, 0.302, '2023-01-09 10:30:15'),
(13, 2, 0.47775, '2023-01-16 12:45:28'),
(14, 2, 0.6535, '2023-01-23 14:20:39'),
(15, 2, 0.35425, '2023-01-30 16:30:47'),
(16, 2, 0.4295, '2023-02-06 11:15:22'),
(17, 2, 0.60175, '2023-02-13 13:40:18'),
(18, 2, 0.279, '2023-02-20 15:25:33');

-- Usuario 4 (8 transacciones - NO genera comisiones porque id_referido es NULL)
INSERT INTO transacciones (cuenta_origen, cuenta_destino, monto, comision, fecha) VALUES
(4, 1, 110.20, 1.102, '2023-01-11 11:40:25'),
(4, 2, 65.35, 0.6535, '2023-01-18 13:55:38'),
(4, 3, 140.50, 1.405, '2023-01-25 15:30:42'),
(4, 5, 90.65, 0.9065, '2023-02-01 17:45:56'),
(4, 6, 115.80, 1.158, '2023-02-08 12:30:24'),
(4, 7, 75.95, 0.7595, '2023-02-15 14:15:37'),
(4, 8, 130.10, 1.301, '2023-02-22 16:20:49'),
(4, 9, 60.25, 0.6025, '2023-03-01 10:45:12');

-- Usuario 5 (9 transacciones - genera comisiones)
INSERT INTO transacciones (cuenta_origen, cuenta_destino, monto, comision, fecha) VALUES
(5, 1, 85.30, 0.853, '2023-01-13 12:50:35'),
(5, 2, 120.45, 1.2045, '2023-01-20 14:05:48'),
(5, 3, 55.60, 0.556, '2023-01-27 16:40:51'),
(5, 4, 100.75, 1.0075, '2023-02-03 18:25:14'),
(5, 6, 65.90, 0.659, '2023-02-10 13:40:26'),
(5, 7, 110.05, 1.1005, '2023-02-17 15:25:39'),
(5, 8, 45.20, 0.452, '2023-02-24 17:10:42'),
(5, 9, 95.35, 0.9535, '2023-03-03 11:35:55'),
(5, 10, 70.50, 0.705, '2023-03-10 14:20:18');

INSERT INTO comisiones (id_transaccion, cuenta_beneficiaria, monto, fecha) VALUES
(27, 3, 0.4265, '2023-01-13 12:50:35'),
(28, 3, 0.60225, '2023-01-20 14:05:48'),
(29, 3, 0.278, '2023-01-27 16:40:51'),
(30, 3, 0.50375, '2023-02-03 18:25:14'),
(31, 3, 0.3295, '2023-02-10 13:40:26'),
(32, 3, 0.55025, '2023-02-17 15:25:39'),
(33, 3, 0.226, '2023-02-24 17:10:42'),
(34, 3, 0.47675, '2023-03-03 11:35:55'),
(35, 3, 0.3525, '2023-03-10 14:20:18');

-- Usuario 6 (10 transacciones - NO genera comisiones porque id_referido es NULL)
INSERT INTO transacciones (cuenta_origen, cuenta_destino, monto, comision, fecha) VALUES
(6, 1, 95.40, 0.954, '2023-01-15 14:00:45'),
(6, 2, 60.55, 0.6055, '2023-01-22 16:15:58'),
(6, 3, 125.70, 1.257, '2023-01-29 18:50:01'),
(6, 4, 80.85, 0.8085, '2023-02-05 10:35:24'),
(6, 5, 135.90, 1.359, '2023-02-12 12:50:36'),
(6, 7, 55.05, 0.5505, '2023-02-19 14:35:49'),
(6, 8, 100.20, 1.002, '2023-02-26 16:20:52'),
(6, 9, 45.35, 0.4535, '2023-03-05 11:45:15'),
(6, 10, 90.50, 0.905, '2023-03-12 14:30:28'),
(6, 1, 65.65, 0.6565, '2023-03-19 16:15:41');

-- Usuario 7 (7 transacciones - genera comisiones)
INSERT INTO transacciones (cuenta_origen, cuenta_destino, monto, comision, fecha) VALUES
(7, 1, 120.50, 1.205, '2023-01-17 15:10:55'),
(7, 2, 75.65, 0.7565, '2023-01-24 17:25:08'),
(7, 3, 140.80, 1.408, '2023-01-31 19:10:11'),
(7, 4, 95.95, 0.9595, '2023-02-07 11:45:34'),
(7, 5, 65.10, 0.651, '2023-02-14 13:00:46'),
(7, 8, 110.25, 1.1025, '2023-02-21 14:45:59'),
(7, 9, 45.40, 0.454, '2023-02-28 16:30:12');

INSERT INTO comisiones (id_transaccion, cuenta_beneficiaria, monto, fecha) VALUES
(46, 5, 0.6025, '2023-01-17 15:10:55'),
(47, 5, 0.37825, '2023-01-24 17:25:08'),
(48, 5, 0.704, '2023-01-31 19:10:11'),
(49, 5, 0.47975, '2023-02-07 11:45:34'),
(50, 5, 0.3255, '2023-02-14 13:00:46'),
(51, 5, 0.55125, '2023-02-21 14:45:59'),
(52, 5, 0.227, '2023-02-28 16:30:12');

-- Usuario 8 (5 transacciones - genera comisiones)
INSERT INTO transacciones (cuenta_origen, cuenta_destino, monto, comision, fecha) VALUES
(8, 1, 55.60, 0.556, '2023-01-19 16:20:05'),
(8, 2, 100.75, 1.0075, '2023-01-26 18:35:18'),
(8, 3, 45.90, 0.459, '2023-02-02 10:20:21'),
(8, 4, 90.05, 0.9005, '2023-02-09 12:35:34'),
(8, 5, 35.20, 0.352, '2023-02-16 14:20:47');

INSERT INTO comisiones (id_transaccion, cuenta_beneficiaria, monto, fecha) VALUES
(53, 4, 0.278, '2023-01-19 16:20:05'),
(54, 4, 0.50375, '2023-01-26 18:35:18'),
(55, 4, 0.2295, '2023-02-02 10:20:21'),
(56, 4, 0.45025, '2023-02-09 12:35:34'),
(57, 4, 0.176, '2023-02-16 14:20:47');

-- Usuario 9 (6 transacciones - NO genera comisiones porque id_referido es NULL)
INSERT INTO transacciones (cuenta_origen, cuenta_destino, monto, comision, fecha) VALUES
(9, 1, 100.70, 1.007, '2023-01-21 17:30:15'),
(9, 2, 55.85, 0.5585, '2023-01-28 19:45:28'),
(9, 3, 120.00, 1.200, '2023-02-04 11:30:31'),
(9, 4, 65.15, 0.6515, '2023-02-11 13:45:44'),
(9, 5, 110.30, 1.103, '2023-02-18 15:30:57'),
(9, 6, 45.45, 0.4545, '2023-02-25 17:15:10');

-- Usuario 10 (5 transacciones - genera comisiones)
INSERT INTO transacciones (cuenta_origen, cuenta_destino, monto, comision, fecha) VALUES
(10, 1, 65.80, 0.658, '2023-01-23 18:40:25'),
(10, 2, 110.95, 1.1095, '2023-01-30 10:55:38'),
(10, 3, 45.10, 0.451, '2023-02-06 12:40:41'),
(10, 4, 90.25, 0.9025, '2023-02-13 14:55:54'),
(10, 5, 35.40, 0.354, '2023-02-20 16:40:07');

INSERT INTO comisiones (id_transaccion, cuenta_beneficiaria, monto, fecha) VALUES
(64, 6, 0.329, '2023-01-23 18:40:25'),
(65, 6, 0.55475, '2023-01-30 10:55:38'),
(66, 6, 0.2255, '2023-02-06 12:40:41'),
(67, 6, 0.45125, '2023-02-13 14:55:54'),
(68, 6, 0.177, '2023-02-20 16:40:07');

