# Proyecto_taller_automotriz

--- Consultas requeridas
--- 1. Obtener el historial de reparaciones de un vehículo específico, vehiculo ID=4

~~~mysql
SELECT vehiculo_id, fecha, reparacion_id, descripcion, costo_total
FROM reparaciones
WHERE vehiculo_id = 4;
~~~

+-------------+------------+---------------+-------------------------------------+-------------+
| vehiculo_id | fecha      | reparacion_id | descripcion                         | costo_total |
+-------------+------------+---------------+-------------------------------------+-------------+
|           4 | 2023-05-04 |             4 | Revisión y ajuste de frenos         |       60000 |
|           4 | 2024-01-08 |            12 | Cambio periodico pastillas de freno |       85000 |
+-------------+------------+---------------+-------------------------------------+-------------+



