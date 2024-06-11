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

--- 7. Listar todas las órdenes de compra y sus detalles
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
10. Obtener la lista de servicios más solicitados en un período específico, del 1 de mayo de 2023 al 4 de mayo del 2023.
~~~mysql
10. Obtener la lista de servicios más solicitados en un período específico, del 1 de mayo de 2023 al 20 de diciembre del 2023.

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



