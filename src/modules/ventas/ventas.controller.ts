import { Request, Response } from 'express'
import * as ventasService from './ventas.service'

export const getVentas = async (req: Request, res: Response) => {
    try {
    const emprendimientoId = Number(req.params.emprendimientoId)
    const ventas = await ventasService.getVentas(emprendimientoId)
    res.json(ventas)
    } catch (error) {
    res.status(500).json({ error: 'Error al obtener ventas' })
    }
}

export const getVentaById = async (req: Request, res: Response) => {
    try {
    const { id, emprendimientoId } = req.params
    const venta = await ventasService.getVentaById(Number(id), Number(emprendimientoId))
    if (!venta) return res.status(404).json({ error: 'Venta no encontrada' })
    res.json(venta)
    } catch (error) {
    res.status(500).json({ error: 'Error al obtener venta' })
    }
}

export const createVenta = async (req: Request, res: Response) => {
    try {
    const emprendimientoId = Number(req.params.emprendimientoId)
    const venta = await ventasService.createVenta(req.body, emprendimientoId)
    res.status(201).json(venta)
    } catch (error: any) {
    if (error.message.includes('Stock insuficiente')) {
        return res.status(400).json({ error: error.message })
    }
    res.status(500).json({ error: 'Error al crear venta' })
    }
}

export const updateEstadoVenta = async (req: Request, res: Response) => {
    try {
    const { id, emprendimientoId } = req.params
    const { estado } = req.body
    const venta = await ventasService.updateEstadoVenta(Number(id), estado, Number(emprendimientoId))
    res.json(venta)
    } catch (error) {
    res.status(500).json({ error: 'Error al actualizar estado de venta' })
    }
}

export const deleteVenta = async (req: Request, res: Response) => {
    try {
        const { id, emprendimientoId } = req.params
        await ventasService.deleteVenta(Number(id), Number(emprendimientoId))
        res.json({ message: 'Venta eliminada' })
    } catch (error) {
        res.status(500).json({ error: 'Error al eliminar venta' })
    }
}