--  Valida si existe una base llamada almacen_db y sino la crea

DROP DATABASE IF EXISTS almacen_db;

CREATE DATABASE  almacen_db;

USE almacen_db;

-- Tablas Independientes
CREATE TABLE categorias (
    id_categoria INT AUTO_INCREMENT PRIMARY KEY,
    nombre VARCHAR(100) NOT NULL UNIQUE,
    descripcion TEXT
);


CREATE TABLE proveedores (
    id_proveedor INT AUTO_INCREMENT PRIMARY KEY,
    nombre_proveedor VARCHAR(150) NOT NULL,
    telefono VARCHAR(20) NOT NULL,
    correo VARCHAR(100) NOT NULL UNIQUE,
    direccion TEXT
);


CREATE TABLE usuarios (
    id_usuario INT AUTO_INCREMENT PRIMARY KEY,
    nombre_completo VARCHAR(150) NOT NULL,
    correo VARCHAR(100) NOT NULL UNIQUE,
    username VARCHAR(50) NOT NULL UNIQUE,
    rol ENUM('Administrador', 'Vendedor', 'Bodeguero') NOT NULL,
    estado ENUM('activo', 'inactivo') NOT NULL
);


-- Tablas Dependiente
CREATE TABLE productos (
    id_producto INT AUTO_INCREMENT PRIMARY KEY,
    sku VARCHAR(50) NOT NULL UNIQUE,
    nombre VARCHAR(150) NOT NULL,
    descripcion TEXT,
    precio_compra DECIMAL(10,2) NOT NULL CHECK (precio_compra > 0), -- se valida que el precio seamayor que 0
    precio_venta DECIMAL(10,2) NOT NULL CHECK (precio_venta > 0),
    stock_minimo INT NOT NULL DEFAULT 5 CHECK (stock_minimo >= 0),
    estado ENUM('activo', 'inactivo') NOT NULL,
    id_categoria INT NOT NULL,
    id_proveedor INT NOT NULL,

    -- Relaciones
    FOREIGN KEY (id_categoria) REFERENCES categorias(id_categoria) ON DELETE RESTRICT ON UPDATE CASCADE,
    FOREIGN KEY (id_proveedor) REFERENCES proveedores(id_proveedor) ON DELETE RESTRICT ON UPDATE CASCADE
);


CREATE TABLE movimientos_inventario (
    id_movimiento INT AUTO_INCREMENT PRIMARY KEY,
    id_producto INT NOT NULL,
    tipo_movimiento ENUM('E', 'S') NOT NULL, -- validacion de valores con E de entrada y S de Salida
    cantidad INT NOT NULL CHECK (cantidad > 0),  -- validacion que cantidad sea mayor que 0
    fecha_hora DATETIME DEFAULT NOW(),
    observaciones VARCHAR(255),
    id_usuario INT NOT NULL,

    -- Relaciones
    FOREIGN KEY (id_producto) REFERENCES productos(id_producto) ON DELETE RESTRICT ON UPDATE CASCADE,
    FOREIGN KEY (id_usuario) REFERENCES usuarios(id_usuario) ON DELETE RESTRICT ON UPDATE CASCADE
);