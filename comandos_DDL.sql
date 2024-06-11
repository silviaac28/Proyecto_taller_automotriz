CREATE DATABASE taller_automotriz_db;
USE taller_automotriz_db;

CREATE TABLE ciudad (
    ciudad_id INT(11) NOT NULL AUTO_INCREMENT,
    nombre VARCHAR(20),
    PRIMARY KEY (ciudad_id)
);

CREATE TABLE telefono_cliente (
    telefono_cliente_id INT(11) NOT NULL AUTO_INCREMENT,
    telefono VARCHAR(20),
    email VARCHAR(50),
    PRIMARY KEY (telefono_cliente_id)
);

CREATE TABLE cliente (
    cliente_id INT(11) NOT NULL AUTO_INCREMENT,
    tipo_documento ENUM('CC', 'NIT'),
    documento VARCHAR(25),
    nombre VARCHAR(25),
    apellido VARCHAR(25),
    direccion VARCHAR(50),
    ciudad_id INT(11),
    telefono_cliente_id INT(11),
    PRIMARY KEY (cliente_id),
    FOREIGN KEY (ciudad_id) REFERENCES ciudad(ciudad_id),
    FOREIGN KEY (telefono_cliente_id) REFERENCES telefono_cliente(telefono_cliente_id)
);

CREATE TABLE marca (
    marca_id INT(11) NOT NULL AUTO_INCREMENT,
    nombre VARCHAR(25),
    PRIMARY KEY (marca_id)
);

CREATE TABLE modelo (
    modelo_id INT(11) NOT NULL AUTO_INCREMENT,
    nombre VARCHAR(25),
    marca_id INT(11),
    PRIMARY KEY (modelo_id),
    FOREIGN KEY (marca_id) REFERENCES marca(marca_id)
);

CREATE TABLE vehiculo (
    vehiculo_id INT(11) NOT NULL AUTO_INCREMENT,
    placa VARCHAR(20),
    modelo_id INT(11),
    año DATE,
    cliente_id INT(11),
    kilometraje INT(11),
    PRIMARY KEY (vehiculo_id),
    FOREIGN KEY (modelo_id) REFERENCES modelo(modelo_id),
    FOREIGN KEY (cliente_id) REFERENCES cliente(cliente_id)
);


CREATE TABLE telefono_empleado (
    telefono_empleado_id INT(11) NOT NULL AUTO_INCREMENT,
    telefono VARCHAR(20),
    email VARCHAR(50),
    PRIMARY KEY (telefono_empleado_id)
);
CREATE TABLE empleado (
    empleado_id INT(11) NOT NULL AUTO_INCREMENT,
    nombre VARCHAR(25),
    apellido VARCHAR(25),
    direccion VARCHAR(50),
    telefono_empleado_id INT(11),
    PRIMARY KEY (empleado_id),
    FOREIGN KEY (telefono_empleado_id) REFERENCES telefono_empleado(telefono_empleado_id)
);

CREATE TABLE servicio (
    servicio_id INT(11) NOT NULL AUTO_INCREMENT,
    nombre VARCHAR(50),
    descripcion VARCHAR(255),
    costo DOUBLE,
    PRIMARY KEY (servicio_id)
);

CREATE TABLE reparaciones (
    reparacion_id INT(11) NOT NULL AUTO_INCREMENT,
    fecha DATE,
    vehiculo_id INT(11),
    empleado_id INT(11),
    servicio_id INT(11),
    costo_total DOUBLE,
    descripcion VARCHAR(100),
    duracion TIME,
    PRIMARY KEY (reparacion_id),
    FOREIGN KEY (vehiculo_id) REFERENCES vehiculo(vehiculo_id),
    FOREIGN KEY (empleado_id) REFERENCES empleado(empleado_id),
    FOREIGN KEY (servicio_id) REFERENCES servicio(servicio_id)
);

CREATE TABLE telefono_proveedor (
    telefono_proveedor_id INT(11) NOT NULL AUTO_INCREMENT,
    telefono VARCHAR(20),
    email VARCHAR(50),
    PRIMARY KEY (telefono_proveedor_id)
);

CREATE TABLE proveedor (
    proveedor_id INT(11) NOT NULL AUTO_INCREMENT,
    nombre_proveedor VARCHAR(25),
    nombre_contacto VARCHAR(25),
    apellido_contacto VARCHAR(25),
    telefono_contacto VARCHAR(20),
    telefono_proveedor_id INT(11),
    PRIMARY KEY (proveedor_id),
    FOREIGN KEY (telefono_proveedor_id) REFERENCES telefono_proveedor(telefono_proveedor_id)
);

CREATE TABLE piezas (
    pieza_id INT(11) NOT NULL AUTO_INCREMENT,
    nombre VARCHAR(25),
    descripcion VARCHAR(100),
    precio DOUBLE(8,2),
    proveedor_id INT(11),
    PRIMARY KEY (pieza_id),
    FOREIGN KEY (proveedor_id) REFERENCES proveedor(proveedor_id)
);


CREATE TABLE ubicacion(
    ubicacion_id INT(11) NOT NULL AUTO_INCREMENT,
    nombre VARCHAR(25),
    PRIMARY KEY (ubicacion_id)
);

CREATE TABLE inventario (
    inventario_id INT(11) NOT NULL AUTO_INCREMENT,
    pieza_id INT(11),
    cantidad INT(11),
    stock_minimo INT(11),
    ubicacion_id INT(11),
    stock_inicial INT(11),
    PRIMARY KEY (inventario_id),
    FOREIGN KEY (pieza_id) REFERENCES piezas(pieza_id),
    FOREIGN KEY (ubicacion_id) REFERENCES ubicacion(ubicacion_id)
);

CREATE TABLE facturacion (
    factura_id INT(11) NOT NULL AUTO_INCREMENT,
    fecha DATE,
    cliente_id INT(11),
    total DOUBLE,
    PRIMARY KEY (factura_id),
    FOREIGN KEY (cliente_id) REFERENCES cliente(cliente_id)
);

CREATE TABLE factura_detalle (
    factura_id INT(11),
    reparacion_id INT(11),
    cantidad INT(11),
    precio DOUBLE,
    PRIMARY KEY (factura_id, reparacion_id),
    FOREIGN KEY (factura_id) REFERENCES facturacion(factura_id),
    FOREIGN KEY (reparacion_id) REFERENCES reparaciones(reparacion_id)
);

CREATE TABLE reparacion_piezas (
    reparacion_id INT(11),
    pieza_id INT(11),
    cantidad INT(11),
    PRIMARY KEY (reparacion_id, pieza_id),
    FOREIGN KEY (reparacion_id) REFERENCES reparaciones(reparacion_id),
    FOREIGN KEY (pieza_id) REFERENCES piezas(pieza_id)
);



CREATE TABLE orden_compra (
    orden_id INT(11) NOT NULL AUTO_INCREMENT,
    fecha DATE,
    proveedor_id INT(11),
    empleado_id INT(11),
    total DOUBLE,
    PRIMARY KEY (orden_id),
    FOREIGN KEY (proveedor_id) REFERENCES proveedor(proveedor_id),
    FOREIGN KEY (empleado_id) REFERENCES empleado(empleado_id)
);

CREATE TABLE orden_detalle (
    orden_id INT(11),
    pieza_id INT(11),
    cantidad INT(11),
    precio_unitario DOUBLE(8,2),
    PRIMARY KEY (orden_id, pieza_id),
    FOREIGN KEY (orden_id) REFERENCES orden_compra(orden_id),
    FOREIGN KEY (pieza_id) REFERENCES piezas(pieza_id)
);

CREATE TABLE cita (
    cita_id INT(11) NOT NULL AUTO_INCREMENT,
    fecha_hora DATETIME,
    cliente_id INT(11),
    vehiculo_id INT(11),
    servicio_id INT(11),
    PRIMARY KEY (cita_id),
    FOREIGN KEY (cliente_id) REFERENCES cliente(cliente_id),
    FOREIGN KEY (vehiculo_id) REFERENCES vehiculo(vehiculo_id),
    FOREIGN KEY (servicio_id) REFERENCES servicio(servicio_id)
);
