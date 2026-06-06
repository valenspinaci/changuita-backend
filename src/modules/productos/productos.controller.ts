import { Request, Response } from 'express'
import * as productosService from './productos.service'

export const getProductos = async (req: Request, res: Response) => {
    try {
        const emprendimientoId = Number(req.params.emprendimientoId)
        const productos = await productosService.getProductos(emprendimientoId)
        res.json(productos)
    } catch (error) {
        res.status(500).json({ error: 'Error al obtener productos' })
    }
}

export const getProductoById = async (req: Request, res: Response) => {
    try {
        const { id, emprendimientoId } = req.params
        const producto = await productosService.getProductoById(Number(id), Number(emprendimientoId))
        if (!producto) return res.status(404).json({ error: 'Producto no encontrado' })
        res.json(producto)
    } catch (error) {
        res.status(500).json({ error: 'Error al obtener producto' })
    }
}

export const createProducto = async (req: Request, res: Response) => {
    try {
        const emprendimientoId = Number(req.params.emprendimientoId)
        const producto = await productosService.createProducto(req.body, emprendimientoId)
        res.status(201).json(producto)
    } catch (error) {
        res.status(500).json({ error: 'Error al crear producto' })
    }
}

export const updateProducto = async (req: Request, res: Response) => {
    try {
        const { id, emprendimientoId } = req.params
        const producto = await productosService.updateProducto(Number(id), req.body, Number(emprendimientoId))
        res.json(producto)
    } catch (error) {
        res.status(500).json({ error: 'Error al actualizar producto' })
    }
}

export const deleteProducto = async (req: Request, res: Response) => {
    try {
        const { id, emprendimientoId } = req.params
        await productosService.deleteProducto(Number(id), Number(emprendimientoId))
        res.json({ mensaje: 'Producto eliminado correctamente' })
    } catch (error) {
        res.status(500).json({ error: 'Error al eliminar producto' })
    }
}

export const descontarStock = async (req: Request, res: Response) => {
    try {
        const { id } = req.params
        const { cantidad } = req.body
        const producto = await productosService.descontarStock(Number(id), Number(cantidad))
        res.json(producto)
    } catch (error) {
        res.status(500).json({ error: 'Error al descontar stock' })
    }
}