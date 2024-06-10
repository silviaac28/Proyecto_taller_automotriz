# Proyecto_taller_automotriz

Consultas requeridas
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

SELECT oc.orden_id, oc.fecha, oc.proveedor_id AS 'ID proveedor', od.pieza_id AS 'ID pieza', od.cantidad, od.precio_unitario, oc.total as 'Valor total'
FROM orden_compra AS oc
INNER JOIN orden_detalle AS od 
ON oc.orden_id = od.orden_id
ORDER BY oc.orden_id;

--- 8. Obtener el costo total de piezas utilizadas en una reparación específica, ID_reparacion=4

SELECT rp.reparacion_id AS 'Reparacion ID', SUM(rp.cantidad * p.precio) AS 'Costo total de piezas'
FROM reparacion_piezas rp
INNER JOIN piezas AS p 
ON rp.pieza_id = p.pieza_id
WHERE rp.reparacion_id = 4
GROUP BY rp.reparacion_id;

--- 9. Obtener el inventario de piezas que necesitan ser reabastecidas (cantidad
menor que un umbral)

SELECT i.inventario_id, p.nombre AS 'Nombre pieza', i.cantidad, i.stock_minimo, u.nombre AS ubicacion
FROM inventario AS i
INNER JOIN piezas AS p 
ON i.pieza_id = p.pieza_id
INNER JOIN ubicacion AS u 
ON i.ubicacion_id = u.ubicacion_id
WHERE i.cantidad < i.stock_minimo;

--- 10. Obtener la lista de servicios más solicitados en un período específico, del 1 de mayo de 2023 al 4 de mayo del 2023.

SELECT s.nombre AS 'Nombre del servicio', COUNT(re.servicio_id) AS 'Cantidad de solicitudes'
FROM reparaciones AS re
INNER JOIN servicio AS s 
ON re.servicio_id = s.servicio_id
WHERE re.fecha BETWEEN '2023-05-01' AND '2023-05-04'
GROUP BY re.servicio_id, s.nombre
ORDER BY 'Cantidad de solicitudes' DESC;

