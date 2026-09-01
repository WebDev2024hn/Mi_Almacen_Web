-- USE almacen_db;

-- =========================================
-- 1. CATEGORÍAS
-- =========================================

INSERT INTO categorias (nombre, descripcion) VALUES
('Computadoras', 'Laptops, computadoras de escritorio y accesorios'),
('Telefonía', 'Teléfonos celulares y accesorios'),
('Periféricos', 'Teclados, mouse, cámaras y otros periféricos'),
('Redes', 'Equipos y accesorios para redes'),
('Almacenamiento', 'Discos duros, SSD y dispositivos de almacenamiento');


-- =========================================
-- 2. PROVEEDORES
-- =========================================

INSERT INTO proveedores
(nombre_proveedor, telefono, correo, direccion)
VALUES
('Tech Solutions Honduras', '9999-1001', 'ventas@techsolutions.hn', 'Tegucigalpa'),
('Distribuidora Digital', '9999-1002', 'contacto@distribuidoradigital.hn', 'San Pedro Sula'),
('Importadora Tecnológica', '9999-1003', 'ventas@importadoratec.hn', 'Tegucigalpa');


-- =========================================
-- 3. USUARIOS
-- =========================================

INSERT INTO usuarios
(nombre_completo, correo, username, rol, estado)
VALUES
('Carlos Martínez', 'carlos@almacen.com', 'cmartinez', 'Administrador', 'activo'),
('Ana López', 'ana@almacen.com', 'alopez', 'Vendedor', 'activo'),
('Luis Hernández', 'luis@almacen.com', 'lhernandez', 'Bodeguero', 'activo');


-- =========================================
-- 4. PRODUCTOS
-- =========================================

INSERT INTO productos
(sku, nombre, descripcion, precio_compra, precio_venta,
 stock_minimo, estado, id_categoria, id_proveedor)
VALUES
(
    'LAP-001',
    'Laptop Lenovo IdeaPad',
    'Laptop para uso empresarial y académico',
    450.00,
    599.99,
    5,
    'activo',
    1,
    1
),
(
    'TEL-001',
    'Samsung Galaxy A55',
    'Teléfono inteligente de gama media',
    280.00,
    369.99,
    5,
    'activo',
    2,
    2
),
(
    'PER-001',
    'Teclado Mecánico RGB',
    'Teclado mecánico USB con iluminación RGB',
    35.00,
    59.99,
    10,
    'activo',
    3,
    1
),
(
    'PER-002',
    'Mouse Inalámbrico',
    'Mouse inalámbrico con conexión USB',
    12.00,
    24.99,
    10,
    'activo',
    3,
    2
),
(
    'RED-001',
    'Router TP-Link',
    'Router inalámbrico de doble banda',
    30.00,
    49.99,
    5,
    'activo',
    4,
    3
),
(
    'ALM-001',
    'SSD Kingston 1TB',
    'Unidad SSD interna de 1TB',
    55.00,
    89.99,
    5,
    'activo',
    5,
    1
),
(
    'ALM-002',
    'Disco Duro Externo 2TB',
    'Disco duro externo USB de 2TB',
    50.00,
    79.99,
    5,
    'inactivo',
    5,
    2
);


-- =========================================
-- 5. MOVIMIENTOS DE INVENTARIO
-- =========================================

INSERT INTO movimientos_inventario
(id_producto, tipo_movimiento, cantidad, observaciones, id_usuario)
VALUES
(1, 'E', 10, 'Compra inicial de laptops', 3),
(2, 'E', 15, 'Ingreso de teléfonos', 3),
(3, 'E', 20, 'Compra inicial de teclados', 3),
(4, 'E', 25, 'Ingreso de mouse inalámbricos', 3),
(5, 'E', 10, 'Ingreso de routers', 3),
(6, 'E', 12, 'Ingreso de unidades SSD', 3),
(1, 'S', 2, 'Venta de laptops', 2),
(3, 'S', 3, 'Venta de teclados', 2);