const express = require('express');
const app = express();
const mysql = require('mysql2');

const PORT = 3000;

const pool = mysql.createPool({
    host: 'localhost',
    user: 'root',
    password: 'password', // contrasena debe cambiarse por la local
    database: 'almacen_db'
});

pool.getConnection((error, conexion) => {
    if (error) {
        console.log('Error de conexión con la base de datos...');
    } else {
        console.log('Conexión exitosa');
        conexion.release();
    }
});

app.use(express.json());

//CREAR PRODUCTO
app.post('/api/productos', (req, res) => {

    const {
        sku,
        nombre,
        descripcion,
        precio_compra,
        precio_venta,
        stock_minimo,
        estado,
        id_categoria,
        id_proveedor
    } = req.body;

    if (!sku || !nombre) {
        return res.status(400).json({
            mensaje: 'El SKU y el nombre son obligatorios'
        });
    }

    if (precio_compra <= 0 || precio_venta <= 0) {
        return res.status(400).json({
            mensaje: 'Los precios deben ser mayores que 0'
        });
    }

    if (estado !== 'activo' && estado !== 'inactivo') {
        return res.status(400).json({
            mensaje: 'El estado debe ser activo o inactivo'
        });
    }

    const sql = `
        INSERT INTO productos
        (
            sku,
            nombre,
            descripcion,
            precio_compra,
            precio_venta,
            stock_minimo,
            estado,
            id_categoria,
            id_proveedor
        )
        VALUES (?, ?, ?, ?, ?, ?, ?, ?, ?)
    `;

    const valores = [
        sku,
        nombre,
        descripcion,
        precio_compra,
        precio_venta,
        stock_minimo,
        estado,
        id_categoria,
        id_proveedor
    ];

    pool.query(sql, valores, (error, resultado) => {

        if (error) {
            console.log('Error al crear el producto:', error);

            return res.status(500).json({
                mensaje: 'Error al crear el producto'
            });
        }

        res.status(201).json({
            mensaje: 'Producto creado correctamente',
            id_producto: resultado.insertId
        });
    });
});

// LISTAR PRODUCTOS
app.get('/api/productos', (req, res) => {

    const sql = 'SELECT * FROM productos';

    pool.query(sql, (error, resultados) => {

        if (error) {
            console.log('Error al consultar los productos:', error);

            return res.status(500).json({
                mensaje: 'Error al consultar los productos'
            });
        }

        console.log('Productos encontrados:', resultados);

        res.status(200).json(resultados);
    });
});


// Obetener prpducto por ID
app.get('/api/productos/:id', (req, res) => {
    const { id } = req.params;
    const sql = 'SELECT * FROM productos WHERE id_producto = ?';

    pool.query(sql, [id], (error, resultados) => {
        if (error) {
            console.log('Error al obtener el producto:', error);
            return res.status(500).json({ mensaje: 'Error al obtener el producto' });
        }

        if (resultados.length === 0) {
            return res.status(404).json({ mensaje: 'Producto no encontrado' });
        }
        res.status(200).json(resultados[0]);
    });
});


// update de Producto
app.put('/api/productos/:id', (req, res) => {
    const { id } = req.params;
    const {
        sku,
        nombre,
        descripcion,
        precio_compra,
        precio_venta,
        stock_minimo,
        estado,
        id_categoria,
        id_proveedor
    } = req.body;

    if (!sku || !nombre) {
        return res.status(400).json({ mensaje: 'El SKU y el nombre son obligatorios' });
    }

    if (precio_compra <= 0 || precio_venta <= 0) {
        return res.status(400).json({ mensaje: 'Los precios deben ser mayores que 0' });
    }

    if (estado !== 'activo' && estado !== 'inactivo') {
        return res.status(400).json({ mensaje: 'El estado debe ser activo o inactivo' });
    }

    const sql = `
        UPDATE productos 
        SET sku = ?, 
            nombre = ?, 
            descripcion = ?, 
            precio_compra = ?, 
            precio_venta = ?, 
            stock_minimo = ?, 
            estado = ?, 
            id_categoria = ?, 
            id_proveedor = ?
        WHERE id_producto = ?
    `;

    const valores = [sku, nombre, descripcion, precio_compra, precio_venta, stock_minimo, estado, id_categoria, id_proveedor, id];

    pool.query(sql, valores, (error, resultado) => {
        if (error) {
            console.log('Error al actualizar el producto:', error);
            return res.status(500).json({ mensaje: 'Error al actualizar' });
        }

        if (resultado.affectedRows === 0) {
            return res.status(404).json({ mensaje: 'Producto no encontrado' });
        }

        res.status(200).json({ mensaje: 'Producto actualizado' });
    });
});


app.listen(PORT, () => {
    console.log(`El servidor está escuchando en: http://localhost:${PORT}`);
});