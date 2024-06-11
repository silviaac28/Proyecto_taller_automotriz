# Proyecto_taller_automotriz

CONSULTAS REQUERIDAS
1. Obtener el historial de reparaciones de un vehículo específico, vehiculo ID=4

~~~mysql
SELECT vehiculo_id, fecha, reparacion_id, descripcion, costo_total
FROM reparaciones
WHERE vehiculo_id = 4;

+-------------+------------+---------------+-------------------------------------+-------------+
| vehiculo_id | fecha      | reparacion_id | descripcion                         | costo_total |
+-------------+------------+---------------+-------------------------------------+-------------+
|           4 | 2023-05-04 |             4 | Revisión y ajuste de frenos         |       60000 |
|           4 | 2024-01-08 |            12 | Cambio periodico pastillas de freno |       85000 |
+-------------+------------+---------------+-------------------------------------+-------------+
~~~

2. Calcular el costo total de todas las reparaciones realizadas por un empleado
específico en un período de tiempo, empleado Luis Perez, entre el 1 de mayo de 2023  y el 3 de diciembre del 2023
~~~mysql
SELECT SUM(re.costo_total) AS 'Costo total de reparaciones', emp.nombre AS 'Nombre empleado', emp.apellido AS 'Apellido empleado'
FROM reparaciones AS re
INNER JOIN empleado AS emp
ON re.empleado_id = emp.empleado_id
WHERE emp.nombre = 'Luis' AND emp.apellido = 'Perez'
AND re.fecha BETWEEN '2023-05-01' AND '2023-12-03';

+-----------------------------+-----------------+-------------------+
| Costo total de reparaciones | Nombre empleado | Apellido empleado |
+-----------------------------+-----------------+-------------------+
|                      152000 | Luis            | Perez             |
+-----------------------------+-----------------+-------------------+
~~~

3. Listar todos los clientes y los vehículos que poseen
~~~mysql
SELECT cl.nombre AS 'Nombre cliente', cl.apellido AS 'Apellido cliente', ve.vehiculo_id AS 'ID del vehiculo', ve.placa AS 'Placa vehiculo'
FROM vehiculo AS ve
INNER JOIN cliente AS cl
ON ve.cliente_id = cl.cliente_id;

+----------------+------------------+-----------------+----------------+
| Nombre cliente | Apellido cliente | ID del vehiculo | Placa vehiculo |
+----------------+------------------+-----------------+----------------+
| Juan           | Pérez            |               1 | ABC123         |
| María          | López            |               2 | DEF456         |
| Pedro          | Gómez            |               3 | GHI789         |
| Ana            | Martínez         |               4 | JKL012         |
| Luis           | Rodríguez        |               5 | MNO345         |
| Laura          | Jimenez          |               6 | PQR678         |
| Carlos         | Hernández        |               7 | STU901         |
| Sofía          | Díaz             |               8 | VWX234         |
| Andrés         | Sánchez          |               9 | YZA567         |
| Andrés         | Sánchez          |              11 | CWR582         |
| Paola          | Ramírez          |              10 | BCD890         |
+----------------+------------------+-----------------+----------------+
~~~

4. Obtener la cantidad de piezas en inventario para cada pieza
~~~mysql
SELECT pieza_id, SUM(cantidad) AS total_cantidad
FROM inventario
GROUP BY pieza_id;

+----------+----------------+
| pieza_id | total_cantidad |
+----------+----------------+
|        1 |             50 |
|        2 |             80 |
|        3 |             20 |
|        4 |             15 |
|        5 |             40 |
|        6 |             52 |
|        7 |             60 |
|        8 |             55 |
|        9 |             42 |
|       10 |             38 |
+----------+----------------+
~~~

5. Obtener las citas programadas para un día específico, 10 de junio de 2024
~~~mysql
SELECT cita_id, fecha_hora, cliente_id, vehiculo_id
FROM cita
WHERE DATE(fecha_hora) = '2024-06-10';

+---------+---------------------+------------+-------------+
| cita_id | fecha_hora          | cliente_id | vehiculo_id |
+---------+---------------------+------------+-------------+
|      10 | 2024-06-10 18:00:00 |         10 |          10 |
|      11 | 2024-06-10 10:00:00 |          2 |           2 |
+---------+---------------------+------------+-------------+
~~~

6. Generar una factura para un cliente específico en una fecha determinada, cliente ID=1 en la fecha 1 de mayo de 2023
~~~mysql
SELECT f.factura_id, f.fecha, c.cliente_id, CONCAT(c.nombre, ' ', c.apellido) AS 'Nombre cliente', f.total AS 'Total factura'
FROM facturacion f
INNER JOIN cliente c 
ON f.cliente_id = c.cliente_id
WHERE f.cliente_id = 1 AND DATE(f.fecha) = '2023-05-01';

+------------+------------+------------+----------------+---------------+
| factura_id | fecha      | cliente_id | Nombre cliente | Total factura |
+------------+------------+------------+----------------+---------------+
|          1 | 2023-05-01 |          1 | Juan Pérez     |         55000 |
+------------+------------+------------+----------------+---------------+
~~~

7. Listar todas las órdenes de compra y sus detalles
~~~mysql
SELECT oc.orden_id, oc.fecha, oc.proveedor_id AS 'ID proveedor', od.pieza_id AS 'ID pieza', od.cantidad, od.precio_unitario, oc.total as 'Valor total'
FROM orden_compra AS oc
INNER JOIN orden_detalle AS od 
ON oc.orden_id = od.orden_id
ORDER BY oc.orden_id;

+----------+------------+--------------+----------+----------+-----------------+-------------+
| orden_id | fecha      | ID proveedor | ID pieza | cantidad | precio_unitario | Valor total |
+----------+------------+--------------+----------+----------+-----------------+-------------+
|        1 | 2024-06-01 |            1 |        1 |       10 |        20000.00 |      500000 |
|        1 | 2024-06-01 |            1 |        2 |       10 |        30000.00 |      500000 |
|        2 | 2024-06-02 |            2 |        3 |       10 |        30000.00 |      700000 |
|        2 | 2024-06-02 |            2 |        4 |       10 |        40000.00 |      700000 |
|        3 | 2024-06-03 |            3 |        5 |        5 |        60000.00 |      600000 |
|        3 | 2024-06-03 |            3 |        6 |       10 |        30000.00 |      600000 |
|        4 | 2024-06-04 |            4 |        7 |        5 |       100000.00 |      800000 |
|        4 | 2024-06-04 |            4 |        8 |        2 |       150000.00 |      800000 |
|        5 | 2024-06-05 |            5 |        9 |       10 |        45000.00 |      900000 |
|        5 | 2024-06-05 |            5 |       10 |        5 |        90000.00 |      900000 |
|        6 | 2024-06-06 |            6 |        1 |       10 |        50000.00 |     1200000 |
|        6 | 2024-06-06 |            6 |        2 |       10 |        70000.00 |     1200000 |
|        7 | 2024-06-07 |            7 |        3 |        5 |        40000.00 |      400000 |
|        7 | 2024-06-07 |            7 |        4 |       10 |        20000.00 |      400000 |
|        8 | 2024-06-08 |            8 |        5 |        5 |       100000.00 |     1300000 |
|        8 | 2024-06-08 |            8 |        6 |        5 |       160000.00 |     1300000 |
|        9 | 2024-06-09 |            9 |        7 |        4 |        50000.00 |      300000 |
|        9 | 2024-06-09 |            9 |        8 |        4 |        25000.00 |      300000 |
|       10 | 2024-06-10 |           10 |        9 |       10 |        65000.00 |     1100000 |
|       10 | 2024-06-10 |           10 |       10 |        5 |        90000.00 |     1100000 |
+----------+------------+--------------+----------+----------+-----------------+-------------+

~~~
8. Obtener el costo total de piezas utilizadas en una reparación específica, ID_reparacion=4
~~~mysql
SELECT rp.reparacion_id AS 'Reparacion ID', SUM(rp.cantidad * p.precio) AS 'Costo total de piezas'
FROM reparacion_piezas rp
INNER JOIN piezas AS p 
ON rp.pieza_id = p.pieza_id
WHERE rp.reparacion_id = 4
GROUP BY rp.reparacion_id;

+---------------+-----------------------+
| Reparacion ID | Costo total de piezas |
+---------------+-----------------------+
|             4 |              50000.00 |
+---------------+-----------------------+
~~~

9. Obtener el inventario de piezas que necesitan ser reabastecidas (cantidad menor que un umbral)
~~~mysql
SELECT i.inventario_id, p.nombre AS 'Nombre pieza', i.cantidad, i.stock_minimo, u.nombre AS ubicacion
FROM inventario AS i
INNER JOIN piezas AS p 
ON i.pieza_id = p.pieza_id
INNER JOIN ubicacion AS u 
ON i.ubicacion_id = u.ubicacion_id
WHERE i.cantidad < i.stock_minimo;
+---------------+--------------------+----------+--------------+----------------------+
| inventario_id | Nombre pieza       | cantidad | stock_minimo | ubicacion            |
+---------------+--------------------+----------+--------------+----------------------+
|             3 | Filtro de aire     |       20 |           40 | Área de pintura      |
|             4 | Bujías             |       15 |           40 | Área de pintura      |
|             5 | Pastillas de freno |       40 |           50 | Zona de servicio     |
|             8 | Llanta             |       55 |           60 | Almacén de repuestos |
|             9 | Espejo retrovisor  |       42 |           50 | Área de diagnóstico  |
|            10 | Luz delantera      |       38 |           40 | Área de diagnóstico  |
+---------------+--------------------+----------+--------------+----------------------+
~~~
10. Obtener la lista de servicios más solicitados en un período específico, del 1 de mayo de 2023 al 20 de diciembre del 2023.
~~~mysql
SELECT s.nombre AS 'Nombre del servicio', COUNT(re.servicio_id) AS 'Cantidad de solicitudes'
FROM reparaciones AS re
INNER JOIN servicio AS s 
ON re.servicio_id = s.servicio_id
WHERE re.fecha BETWEEN '2023-05-01' AND '2023-12-20'
GROUP BY re.servicio_id, s.nombre
ORDER BY COUNT(re.servicio_id) DESC
LIMIT 3;

+------------------------------+-------------------------+
| Nombre del servicio          | Cantidad de solicitudes |
+------------------------------+-------------------------+
| Revisión eléctrica           |                       4 |
| Cambio de pastillas de freno |                       2 |
| Revisión de suspensión       |                       2 |
+------------------------------+-------------------------+
~~~

11. Obtener el costo total de reparaciones para cada cliente en un período específico, entre 4 de mayo de 2023 y 10 de julio de 2023 
~~~mysql
SELECT c.nombre AS 'Nombre cliente', c.apellido AS 'Apellido cliente', SUM(re.costo_total) AS 'Costo total de reparaciones'
FROM reparaciones AS re
INNER JOIN vehiculo AS ve 
ON re.vehiculo_id = ve.vehiculo_id
INNER JOIN cliente AS c 
ON ve.cliente_id = c.cliente_id
WHERE re.fecha BETWEEN '2023-05-04' AND '2023-07-10'
GROUP BY c.cliente_id;

+----------------+------------------+-----------------------------+
| Nombre cliente | Apellido cliente | Costo total de reparaciones |
+----------------+------------------+-----------------------------+
| Ana            | Martínez         |                       60000 |
| Luis           | Rodríguez        |                       76000 |
| Laura          | Jimenez          |                      100000 |
| Carlos         | Hernández        |                       36000 |
| Sofía          | Díaz             |                      124000 |
| Andrés         | Sánchez          |                       28000 |
| Paola          | Ramírez          |                       84000 |
+----------------+------------------+-----------------------------+
~~~
12. Listar los empleados con mayor cantidad de reparaciones realizadas en un
período específico, entre 3 de mayo 2023 y 10 de diciembre de 2023.
~~~mysql
SELECT e.nombre AS empleado_nombre, e.apellido AS empleado_apellido, COUNT(r.reparacion_id) AS cantidad_reparaciones
FROM reparaciones AS r
INNER JOIN empleado AS e 
ON r.empleado_id = e.empleado_id
WHERE r.fecha BETWEEN '2023-05-03' AND '2023-12-10'
GROUP BY e.empleado_id
ORDER BY cantidad_reparaciones DESC;
+-----------------+-------------------+-----------------------+
| empleado_nombre | empleado_apellido | cantidad_reparaciones |
+-----------------+-------------------+-----------------------+
| Miguel          | Ramirez           |                     3 |
| Luis            | Perez             |                     2 |
| Maria           | Lopez             |                     2 |
| Jose            | Martinez          |                     2 |
| Sandra          | Rodriguez         |                     1 |
| David           | Gonzalez          |                     1 |
| Laura           | Hernandez         |                     1 |
| Sofia           | Garcia            |                     1 |
+-----------------+-------------------+-----------------------+
~~~

 13. Obtener las piezas más utilizadas en reparaciones durante un período
específico, ENTRE 4 mayo 2023 y 10 diciembre 2023 
~~~mysql
SELECT p.nombre AS 'Nombre pieza', SUM(rp.cantidad) AS 'Cantidad total utilizada'
FROM reparacion_piezas AS rp
INNER JOIN piezas AS p 
ON rp.pieza_id = p.pieza_id
INNER JOIN reparaciones AS r 
ON rp.reparacion_id = r.reparacion_id
WHERE r.fecha BETWEEN '2023-05-04' AND '2023-12-10'
GROUP BY p.pieza_id
ORDER BY SUM(rp.cantidad) DESC
LIMIT 5;

+--------------------+--------------------------+
| Nombre pieza       | Cantidad total utilizada |
+--------------------+--------------------------+
| Luz delantera      |                        4 |
| Pastillas de freno |                        2 |
| Batería            |                        2 |
| Bujías             |                        1 |
| Amortiguadores     |                        1 |
+--------------------+--------------------------+
~~~

14. Calcular el promedio de costo de reparaciones por vehículo
~~~mysql
SELECT v.vehiculo_id, v.placa AS vehiculo_placa, AVG(r.costo_total) AS 'Costo promedio reparación'
FROM reparaciones AS r
INNER JOIN vehiculo AS v 
ON r.vehiculo_id = v.vehiculo_id
GROUP BY v.vehiculo_id;

+-------------+----------------+---------------------------+
| vehiculo_id | vehiculo_placa | Costo promedio reparación |
+-------------+----------------+---------------------------+
|           1 | ABC123         |                     44000 |
|           2 | DEF456         |                     84000 |
|           3 | GHI789         |                     52000 |
|           4 | JKL012         |                     72500 |
|           5 | MNO345         |                     76000 |
|           6 | PQR678         |                    115000 |
|           7 | STU901         |                     62500 |
|           8 | VWX234         |                    117000 |
|           9 | YZA567         |                     42000 |
|          10 | BCD890         |                     84000 |
+-------------+----------------+---------------------------+
~~~
15. Obtener el inventario de piezas por proveedor
~~~mysql
SELECT p.nombre_proveedor AS 'Nombre proveedor', pi.nombre AS nombre_pieza, i.cantidad, i.stock_minimo
FROM inventario AS i
INNER JOIN piezas AS pi 
ON i.pieza_id = pi.pieza_id
INNER JOIN proveedor AS p 
ON pi.proveedor_id = p.proveedor_id
ORDER BY p.proveedor_id, pi.nombre;

+------------------+--------------------+----------+--------------+
| Nombre proveedor | nombre_pieza       | cantidad | stock_minimo |
+------------------+--------------------+----------+--------------+
| Proveedor1       | Aceite             |       50 |           30 |
| Proveedor2       | Filtro de aceite   |       80 |           30 |
| Proveedor3       | Filtro de aire     |       20 |           40 |
| Proveedor4       | Bujías             |       15 |           40 |
| Proveedor5       | Pastillas de freno |       40 |           50 |
| Proveedor6       | Amortiguadores     |       52 |           50 |
| Proveedor7       | Batería            |       60 |           50 |
| Proveedor8       | Llanta             |       55 |           60 |
| Proveedor9       | Espejo retrovisor  |       42 |           50 |
| Proveedor10      | Luz delantera      |       38 |           40 |
+------------------+--------------------+----------+--------------+
~~~

16. Listar los clientes que no han realizado reparaciones en el último año, considerando que estamos en 2024-05-06
~~~mysql
SELECT DISTINCT c.cliente_id, c.nombre, c.apellido
FROM cliente AS c
LEFT JOIN vehiculo AS v 
ON c.cliente_id = v.cliente_id
LEFT JOIN reparaciones AS r 
ON v.vehiculo_id = r.vehiculo_id
WHERE r.fecha < '2023-05-06' OR r.fecha IS NULL;

+------------+--------+-----------+
| cliente_id | nombre | apellido  |
+------------+--------+-----------+
|          1 | Juan   | Pérez     |
|          2 | María  | López     |
|          3 | Pedro  | Gómez     |
|          4 | Ana    | Martínez  |
|          5 | Luis   | Rodríguez |
|          9 | Andrés | Sánchez   |
+------------+--------+-----------+
~~~

17. Obtener las ganancias totales del taller en un período específico, entre 5 de mayo 2023 y 10 de septiembre 2023
~~~mysql
SELECT SUM(fa.total) AS 'Ingresos', SUM(re.costo_total) AS 'Costos', SUM(fa.total) - SUM(re.costo_total) AS 'Ganancias totales del taller'
FROM facturacion AS fa
INNER JOIN factura_detalle AS fd
ON fa.factura_id = fd.factura_id
INNER JOIN reparaciones AS re
ON fd.reparacion_id = re.reparacion_id
WHERE fa.fecha BETWEEN '2023-05-05' AND '2023-09-10';

+----------+--------+------------------------------+
| Ingresos | Costos | Ganancias totales del taller |
+----------+--------+------------------------------+
|   560000 | 448000 |                       112000 |
+----------+--------+------------------------------+
~~~

18. Listar los empleados y el total de horas trabajadas en reparaciones en un período específico (asumiendo que se registra la duración de cada reparación), ENTRE 1 de mayo de 2023 y 20 de diciembre de 2023
~~~mysql
SELECT e.empleado_id, e.nombre, e.apellido, SEC_TO_TIME(SUM(TIME_TO_SEC(r.duracion))) AS total_horas_trabajadas
FROM empleado AS e
INNER JOIN reparaciones AS r 
ON e.empleado_id = r.empleado_id
WHERE r.fecha BETWEEN '2023-05-01' AND '2023-12-20'
GROUP BY e.empleado_id;

+-------------+--------+-----------+------------------------+
| empleado_id | nombre | apellido  | total_horas_trabajadas |
+-------------+--------+-----------+------------------------+
|           1 | Carlos | Mendez    | 01:00:00               |
|           2 | Ana    | Suarez    | 02:00:00               |
|           3 | Luis   | Perez     | 03:00:00               |
|           4 | Maria  | Lopez     | 03:00:00               |
|           5 | Jose   | Martinez  | 03:45:00               |
|           6 | Sandra | Rodriguez | 02:15:00               |
|           7 | David  | Gonzalez  | 01:15:00               |
|           8 | Laura  | Hernandez | 03:00:00               |
|           9 | Miguel | Ramirez   | 04:40:00               |
|          10 | Sofia  | Garcia    | 02:45:00               |
+-------------+--------+-----------+------------------------+
~~~

19. Obtener el listado de servicios prestados por cada empleado en un período específico, ENTRE 5 de mayo de 2023 y 10 de diciembre de 2023
~~~mysql
SELECT e.empleado_id, e.nombre AS 'Nombre empleado', e.apellido AS 'Apellido empleado', s.servicio_id, s.nombre AS 'Nombre servicio', COUNT(*) AS 'Cantidad de servicios'
FROM empleado AS e
INNER JOIN reparaciones AS r 
ON e.empleado_id = r.empleado_id
INNER JOIN servicio AS s 
ON r.servicio_id = s.servicio_id
WHERE r.fecha BETWEEN '2023-05-01' AND '2023-12-10'
GROUP BY e.empleado_id, e.nombre, e.apellido, s.servicio_id
ORDER BY e.empleado_id;

+-------------+-----------------+-------------------+-------------+------------------------------+-----------------------+
| empleado_id | Nombre empleado | Apellido empleado | servicio_id | Nombre servicio              | Cantidad de servicios |
+-------------+-----------------+-------------------+-------------+------------------------------+-----------------------+
|           1 | Carlos          | Mendez            |           1 | Cambio de aceite             |                     1 |
|           2 | Ana             | Suarez            |           2 | Alineación                   |                     1 |
|           3 | Luis            | Perez             |           3 | Balanceo                     |                     1 |
|           3 | Luis            | Perez             |           6 | Cambio de pastillas de freno |                     1 |
|           4 | Maria           | Lopez             |           4 | Revisión de frenos           |                     1 |
|           4 | Maria           | Lopez             |           5 | Revisión de suspensión       |                     1 |
|           5 | Jose            | Martinez          |           5 | Revisión de suspensión       |                     1 |
|           5 | Jose            | Martinez          |          10 | Revisión eléctrica           |                     1 |
|           6 | Sandra          | Rodriguez         |           6 | Cambio de pastillas de freno |                     1 |
|           7 | David           | Gonzalez          |           7 | Cambio de bujías             |                     1 |
|           8 | Laura           | Hernandez         |           8 | Revisión de motor            |                     1 |
|           9 | Miguel          | Ramirez           |           9 | Cambio de filtro de aire     |                     1 |
|           9 | Miguel          | Ramirez           |          10 | Revisión eléctrica           |                     2 |
|          10 | Sofia           | Garcia            |          10 | Revisión eléctrica           |                     1 |
+-------------+-----------------+-------------------+-------------+------------------------------+-----------------------+
~~~

SUBCONSULTAS

1. Obtener el cliente que ha gastado más en reparaciones durante el último año.
~~~mysql
SELECT cl.nombre AS 'Nombre cliente', cl.apellido AS 'Apellido cliente', SUM(re.costo_total) AS 'Total costos reparaciones'
FROM cliente AS cl
INNER JOIN facturacion AS fa
ON cl.cliente_id = fa.cliente_id
INNER JOIN factura_detalle AS fd
ON fa.factura_id = fd.factura_id 
INNER JOIN reparaciones AS re
ON fd.reparacion_id = re.reparacion_id
WHERE fa.factura_id IN (SELECT fa1.factura_id
FROM facturacion AS fa1 
WHERE fa1.fecha BETWEEN '2023-05-05' AND '2024-05-05')
GROUP BY cl.cliente_id
ORDER BY SUM(re.costo_total) DESC
LIMIT 1;

+----------------+------------------+---------------------------+
| Nombre cliente | Apellido cliente | Total costos reparaciones |
+----------------+------------------+---------------------------+
| Sofía          | Díaz             |                    124000 |
+----------------+------------------+---------------------------+
~~~

2. Obtener la pieza más utilizada en reparaciones durante el último mes, asumiento que el ultimo mes es mayo del 2023

~~~mysql
SELECT pi.pieza_id, pi.nombre, SUM(rp.cantidad) AS 'Cantidad utilizada'
FROM reparaciones AS re
INNER JOIN reparacion_piezas AS rp
ON re.reparacion_id = rp.reparacion_id
INNER JOIN piezas AS pi
ON rp.pieza_id = pi.pieza_id
WHERE re.reparacion_id IN (SELECT rep1.reparacion_id
FROM reparaciones AS rep1 
WHERE rep1.fecha BETWEEN '2023-05-01' AND '2023-05-31')
GROUP BY pi.pieza_id
ORDER BY SUM(rp.cantidad) DESC
LIMIT 1;

+----------+--------+--------------------+
| pieza_id | nombre | Cantidad utilizada |
+----------+--------+--------------------+
|        1 | Aceite |                  2 |
+----------+--------+--------------------+
~~~

3. Obtener los proveedores que suministran las piezas más caras
~~~mysql
SELECT pr.nombre_proveedor AS 'Nombre proveedor'
FROM proveedor AS pr
INNER JOIN piezas AS pi
ON pr.proveedor_id = pi.proveedor_id
WHERE pi.precio = (SELECT MAX(precio) FROM piezas);

+------------------+
| Nombre proveedor |
+------------------+
| Proveedor7       |
+------------------+
~~~

 4. Listar las reparaciones que no utilizaron piezas específicas durante el último
año, pieza = llanta

~~~mysql
SELECT re.reparacion_id, re.fecha, re.vehiculo_id, re.descripcion
FROM reparaciones AS re
WHERE re.reparacion_id NOT IN (SELECT reparacion_id
	FROM reparacion_piezas AS rp
	INNER JOIN piezas AS p 
	ON rp.pieza_id = p.pieza_id
	WHERE p.nombre = 'Llanta')
AND fecha BETWEEN '2023-05-08' AND '2024-05-08';

+---------------+------------+-------------+-------------------------------------------+
| reparacion_id | fecha      | vehiculo_id | descripcion                               |
+---------------+------------+-------------+-------------------------------------------+
|             9 | 2023-05-09 |           9 | Cambio de filtro de aire del motor        |
|            10 | 2023-05-10 |          10 | Revisión y ajuste del sistema eléctrico   |
|            11 | 2023-08-18 |           2 | Cambio periodico pastillas de freno       |
|            12 | 2024-01-08 |           4 | cambio mantenimiento bujías               |
|            13 | 2023-07-25 |           6 | Mantenimiento periodico sistema electrico |
|            14 | 2023-12-02 |           9 | Revisión sistema eléctrico                |
|            15 | 2023-08-18 |           7 | Revisión suspensión                       |
|            16 | 2023-09-09 |           8 | Revisión sistema eléctrico                |
|            17 | 2023-05-20 |           1 | Cambio de aceite                          |
+---------------+------------+-------------+-------------------------------------------+
~~~

5. Obtener las piezas que están en inventario por debajo del 70% del stock inicial
~~~mysql

SELECT nombre AS 'Nombre pieza', inv.cantidad AS 'Cantidad actual', inv.stock_inicial AS 'Stock inicial'
FROM piezas AS pi
INNER JOIN inventario AS inv
ON pi.pieza_id = inv.pieza_id
WHERE inv.pieza_id IN (SELECT in2.pieza_id
FROM inventario AS in2
WHERE in2.cantidad < (0.7 * in2.stock_inicial));

+----------------+-----------------+---------------+
| Nombre pieza   | Cantidad actual | Stock inicial |
+----------------+-----------------+---------------+
| Filtro de aire |              20 |            35 |
| Bujías         |              15 |            30 |
+----------------+-----------------+---------------+
~~~

PROCEDIMIENTOS ALMACENADOS

1. Crear un procedimiento almacenado para insertar una nueva reparación.
~~~mysql
DELIMITER $$
DROP PROCEDURE IF EXISTS insertar_reparacion;
CREATE PROCEDURE insertar_reparacion(
    IN i_fecha DATE,
    IN i_vehiculo_id INT,
    IN i_empleado_id INT,
    IN i_servicio_id INT,
    IN i_costo_total DECIMAL(10, 2),
    IN i_descripcion VARCHAR(255),
    IN i_duracion TIME
)
BEGIN
    INSERT INTO reparaciones (fecha, vehiculo_id, empleado_id, servicio_id, costo_total, descripcion, duracion)
    VALUES (i_fecha, i_vehiculo_id, i_empleado_id, i_servicio_id, i_costo_total, i_descripcion, i_duracion);
END $$
DELIMITER ;

CALL insertar_reparacion('2023-05-20', 1, 1, 1, 20000, 'Cambio de aceite', '00:30:00');
~~~
Con esto, la tabla reparaciones queda de la siguiente manera:

~~~mysql

+---------------+------------+-------------+-------------+-------------+-------------+-------------------------------------------+----------+
| reparacion_id | fecha      | vehiculo_id | empleado_id | servicio_id | costo_total | descripcion                               | duracion |
+---------------+------------+-------------+-------------+-------------+-------------+-------------------------------------------+----------+
|             1 | 2023-05-01 |           1 |           1 |           1 |       44000 | Cambio de aceite y filtro                 | 01:00:00 |
|             2 | 2023-05-02 |           2 |           2 |           2 |       68000 | Alineación de las ruedas                  | 02:00:00 |
|             3 | 2023-05-03 |           3 |           3 |           3 |       52000 | Balanceo de las ruedas                    | 01:30:00 |
|             4 | 2023-05-04 |           4 |           4 |           4 |       60000 | Revisión y ajuste de frenos               | 01:45:00 |
|             5 | 2023-05-05 |           5 |           5 |           5 |       76000 | Revisión y ajuste de suspensión           | 02:30:00 |
|             6 | 2023-05-06 |           6 |           6 |           6 |      100000 | Cambio de pastillas de freno              | 02:15:00 |
|             7 | 2023-05-07 |           7 |           7 |           7 |       36000 | Cambio de bujías del motor                | 01:15:00 |
|             8 | 2023-05-08 |           8 |           8 |           8 |      124000 | Revisión completa del motor               | 03:00:00 |
|             9 | 2023-05-09 |           9 |           9 |           9 |       28000 | Cambio de filtro de aire del motor        | 00:45:00 |
|            10 | 2023-05-10 |          10 |          10 |          10 |       84000 | Revisión y ajuste del sistema eléctrico   | 02:45:00 |
|            11 | 2023-08-18 |           2 |           3 |           6 |      100000 | Cambio periodico pastillas de freno       | 01:30:00 |
|            12 | 2024-01-08 |           4 |           8 |           7 |       85000 | cambio mantenimiento bujías               | 01:30:00 |
|            13 | 2023-07-25 |           6 |           9 |          10 |      130000 | Mantenimiento periodico sistema electrico | 01:30:00 |
|            14 | 2023-12-02 |           9 |           5 |          10 |       56000 | Revisión sistema eléctrico                | 01:15:00 |
|            15 | 2023-08-18 |           7 |           4 |           5 |       89000 | Revisión suspensión                       | 01:15:00 |
|            16 | 2023-09-09 |           8 |           9 |          10 |      110000 | Revisión sistema eléctrico                | 02:25:00 |
|            17 | 2023-05-20 |           1 |           1 |           1 |       20000 | Cambio de aceite                          | 00:30:00 |
+---------------+------------+-------------+-------------+-------------+-------------+-------------------------------------------+----------+
~~~

2. Crear un procedimiento almacenado para actualizar el inventario de una pieza.

~~~mysql

DELIMITER $$
DROP PROCEDURE IF EXISTS actualizar_inventario;
CREATE PROCEDURE actualizar_inventario(
    IN a_pieza_id INT,
    IN a_nuevacantidad INT
)
BEGIN
	UPDATE inventario
	SET cantidad = a_nuevacantidad
	WHERE pieza_id = a_pieza_id;
END $$
DELIMITER ;

CALL actualizar_inventario(2, 80);
~~~

Con esto, la pieza con ID 2 en la tabla inventario queda de la siguiente manera:

~~~mysql
+---------------+----------+----------+--------------+--------------+---------------+
| inventario_id | pieza_id | cantidad | ubicacion_id | stock_minimo | stock_inicial |
+---------------+----------+----------+--------------+--------------+---------------+
|             2 |        2 |       80 |            1 |           30 |            95 |
+---------------+----------+----------+--------------+--------------+---------------+
~~~


3. Crear un procedimiento almacenado para eliminar una cita
~~~mysql

DELIMITER $$
DROP PROCEDURE IF EXISTS eliminar_cita;
CREATE PROCEDURE eliminar_cita(
    IN p_cita_id INT
)
BEGIN
	DELETE FROM cita
	WHERE cita_id = p_cita_id;
END $$
DELIMITER ;

CALL eliminar_cita(2);
~~~

De esta manera, eliminando la cita con ID=2, la tabla citas queda de la siguiente forma, :
~~~mysql
+---------+---------------------+------------+-------------+-------------+
| cita_id | fecha_hora          | cliente_id | vehiculo_id | servicio_id |
+---------+---------------------+------------+-------------+-------------+
|       1 | 2024-06-01 09:00:00 |          1 |           1 |           1 |
|       3 | 2024-06-03 11:00:00 |          3 |           3 |           3 |
|       4 | 2024-06-04 12:00:00 |          4 |           4 |           4 |
|       5 | 2024-06-05 13:00:00 |          5 |           5 |           5 |
|       6 | 2024-06-06 14:00:00 |          6 |           6 |           6 |
|       7 | 2024-06-07 15:00:00 |          7 |           7 |           7 |
|       8 | 2024-06-08 16:00:00 |          8 |           8 |           8 |
|       9 | 2024-06-09 17:00:00 |          9 |           9 |           9 |
|      10 | 2024-06-10 18:00:00 |         10 |          10 |          10 |
|      11 | 2024-06-10 10:00:00 |          2 |           2 |           6 |
+---------+---------------------+------------+-------------+-------------+
~~~

4. Crear un procedimiento almacenado para generar una factura
~~~mysql
DELIMITER $$
DROP PROCEDURE IF EXISTS generar_factura;
CREATE PROCEDURE generar_factura(
	IN p_fecha DATE,
	IN p_cliente_id INT,
	IN p_total DOUBLE
)
BEGIN
	INSERT INTO facturacion (fecha, cliente_id, total)
	VALUES (p_fecha, p_cliente_id, p_total);
END $$
DELIMITER ;

CALL generar_factura('2024-03-15', 5, 220000);
~~~

Aquí podemos observar que la nueva factura quedó registrada con ID=11:
~~~mysql
+------------+------------+------------+--------+
| factura_id | fecha      | cliente_id | total  |
+------------+------------+------------+--------+
|          1 | 2023-05-01 |          1 |  55000 |
|          2 | 2023-05-02 |          2 |  85000 |
|          3 | 2023-05-03 |          3 |  65000 |
|          4 | 2023-05-04 |          4 |  75000 |
|          5 | 2023-05-05 |          5 |  95000 |
|          6 | 2023-05-06 |          6 | 125000 |
|          7 | 2023-05-07 |          7 |  45000 |
|          8 | 2023-05-08 |          8 | 155000 |
|          9 | 2023-05-09 |          9 |  35000 |
|         10 | 2023-05-10 |         10 | 105000 |
|         11 | 2024-03-15 |          5 | 220000 |
+------------+------------+------------+--------+
~~~

5. Crear un procedimiento almacenado para obtener el historial de reparaciones
de un vehículo
~~~mysql
DELIMITER $$
DROP PROCEDURE IF EXISTS historial_reparaciones;
CREATE PROCEDURE historial_reparaciones(
	IN p_vehiculo_id INT
)
BEGIN
	SELECT vehiculo_id, reparacion_id, fecha, descripcion, costo_total
	FROM reparaciones 
	WHERE vehiculo_id = p_vehiculo_id;
END $$
DELIMITER ;
	
CALL historial_reparaciones(4);

+-------------+---------------+------------+-----------------------------+-------------+
| vehiculo_id | reparacion_id | fecha      | descripcion                 | costo_total |
+-------------+---------------+------------+-----------------------------+-------------+
|           4 |             4 | 2023-05-04 | Revisión y ajuste de frenos |       60000 |
|           4 |            12 | 2024-01-08 | cambio mantenimiento bujías |       85000 |
+-------------+---------------+------------+-----------------------------+-------------+
~~~

6. Crear un procedimiento almacenado para calcular el costo total de reparaciones de un cliente en un período
~~~mysql


DELIMITER $$
DROP PROCEDURE IF EXISTS costo_reparaciones_por_cliente;
CREATE PROCEDURE costo_reparaciones_por_cliente(
	IN p_cliente_id INT,
	IN p_fecha_inicio DATE,
	IN p_fecha_fin DATE
)
BEGIN
	SELECT cl.cliente_id, cl.nombre AS 'Nombre cliente', cl.apellido AS 'Apellido cliente', SUM(re.costo_total) AS 'Costo total reparaciones'
	FROM reparaciones AS re
	INNER JOIN vehiculo AS ve
	ON re.vehiculo_id = ve.vehiculo_id
	INNER JOIN cliente AS cl
	ON ve.cliente_id = cl.cliente_id
	WHERE re.fecha BETWEEN p_fecha_inicio AND p_fecha_fin
	AND cl.cliente_id = p_cliente_id
	GROUP BY cl.cliente_id, cl.nombre, cl.apellido;
END $$
DELIMITER ;
	
CALL costo_reparaciones_por_cliente(5, '2023-01-10','2023-11-10');

+------------+----------------+------------------+--------------------------+
| cliente_id | Nombre cliente | Apellido cliente | Costo total reparaciones |
+------------+----------------+------------------+--------------------------+
|          5 | Luis           | Rodríguez        |                    76000 |
+------------+----------------+------------------+--------------------------+
~~~

7. Crear un procedimiento almacenado para obtener la lista de vehículos que requieren mantenimiento basado en el kilometraje.
~~~mysql
DELIMITER $$
DROP PROCEDURE IF EXISTS mantenimiento_por_kilometraje;
CREATE PROCEDURE mantenimiento_por_kilometraje(
	IN p_kilometraje INT
)
BEGIN
	SELECT vehiculo_id, placa, cliente_id, p_kilometraje AS 'Kilometraje excedido', kilometraje AS 'Kilometraje actual'
	FROM vehiculo
	WHERE kilometraje > p_kilometraje;
	
END $$
DELIMITER ;
	
CALL mantenimiento_por_kilometraje(60000);

+-------------+--------+------------+----------------------+--------------------+
| vehiculo_id | placa  | cliente_id | Kilometraje excedido | Kilometraje actual |
+-------------+--------+------------+----------------------+--------------------+
|           4 | JKL012 |          4 |                60000 |              87164 |
|           6 | PQR678 |          6 |                60000 |              97408 |
|           7 | STU901 |          7 |                60000 |              61699 |
|           8 | VWX234 |          8 |                60000 |              76274 |
|           9 | YZA567 |          9 |                60000 |              76270 |
+-------------+--------+------------+----------------------+--------------------+
~~~



8. Crear un procedimiento almacenado para insertar una nueva orden de compra
~~~mysql
DELIMITER $$
DROP PROCEDURE IF EXISTS insertar_orden_compra;
CREATE PROCEDURE insertar_orden_compra(
	IN p_fecha DATE,
	IN p_proveedor_id INT,
	IN p_empleado_id INT,
	IN p_total DOUBLE
)

BEGIN
    INSERT INTO orden_compra (fecha, proveedor_id, empleado_id, total)
    VALUES (p_fecha, p_proveedor_id, p_empleado_id, p_total);
END $$
DELIMITER ;

CALL insertar_orden_compra('2024-03-22', 4, 6, 30000);
~~~
Aquí podemos observar que la nueva orden de compra quedó registrada con ID=11:

~~~mysql

+----------+------------+--------------+-------------+---------+
| orden_id | fecha      | proveedor_id | empleado_id | total   |
+----------+------------+--------------+-------------+---------+
|        1 | 2024-06-01 |            1 |           1 |  500000 |
|        2 | 2024-06-02 |            2 |           2 |  700000 |
|        3 | 2024-06-03 |            3 |           3 |  600000 |
|        4 | 2024-06-04 |            4 |           4 |  800000 |
|        5 | 2024-06-05 |            5 |           5 |  900000 |
|        6 | 2024-06-06 |            6 |           6 | 1200000 |
|        7 | 2024-06-07 |            7 |           7 |  400000 |
|        8 | 2024-06-08 |            8 |           8 | 1300000 |
|        9 | 2024-06-09 |            9 |           9 |  300000 |
|       10 | 2024-06-10 |           10 |          10 | 1100000 |
|       11 | 2024-03-22 |            4 |           6 |   30000 |
+----------+------------+--------------+-------------+---------+
~~~

9. Crear un procedimiento almacenado para actualizar los datos de un cliente
~~~mysql
DELIMITER $$
DROP PROCEDURE IF EXISTS actualizar_cliente;
CREATE PROCEDURE actualizar_cliente(
    a_cliente_id INT,
    a_documento VARCHAR(25),
    a_nombre VARCHAR(25),
    a_apellido VARCHAR(25),
    a_direccion VARCHAR(50),
    a_ciudad_id INT,
    a_telefono_cliente_id INT
)
BEGIN
	UPDATE cliente
	SET documento = a_documento,
	nombre = a_nombre,
	apellido = a_apellido,
	direccion = a_direccion,
	ciudad_id = a_ciudad_id,
	telefono_cliente_id = a_telefono_cliente_id	
	WHERE cliente_id = a_cliente_id;
END $$
DELIMITER ;

CALL actualizar_cliente(6, '1095841567', 'Laura', 'Jimenez', 'Carrera 26 98-42', 10, 6);
~~~

Llamando el procedimiento mencionado, los datos del cliente con ID=6 quedan de la siguiente forma:
~~~mysql
+------------+----------------+------------+--------+----------+------------------+-----------+---------------------+
| cliente_id | tipo_documento | documento  | nombre | apellido | direccion        | ciudad_id | telefono_cliente_id |
+------------+----------------+------------+--------+----------+------------------+-----------+---------------------+
|          6 | CC             | 1095841567 | Laura  | Jimenez  | Carrera 26 98-42 |        10 |                   6 |
+------------+----------------+------------+--------+----------+------------------+-----------+---------------------+
~~~



10. Crear un procedimiento almacenado para obtener los servicios más solicitados en un período
~~~mysql
DELIMITER $$
DROP PROCEDURE IF EXISTS servicios_mas_solicitados;
CREATE PROCEDURE servicios_mas_solicitados(
	p_fecha_inicio DATE,
	p_fecha_fin DATE
)
BEGIN
	SELECT se.servicio_id, se.nombre AS 'Nombre servicio', COUNT(*) AS '# veces solicitado'
	FROM reparaciones AS re
	INNER JOIN servicio AS se
	ON re.servicio_id = se.servicio_id
	WHERE re.fecha BETWEEN p_fecha_inicio AND p_fecha_fin
	GROUP BY se.servicio_id
	ORDER BY COUNT(*) DESC
	LIMIT 3;
END $$
DELIMITER ;

CALL servicios_mas_solicitados('2023-02-22', '2023-11-08');

+-------------+------------------------------+--------------------+
| servicio_id | Nombre servicio              | # veces solicitado |
+-------------+------------------------------+--------------------+
|          10 | Revisión eléctrica           |                  3 |
|           1 | Cambio de aceite             |                  2 |
|           6 | Cambio de pastillas de freno |                  2 |
+-------------+------------------------------+--------------------+
~~~

