import { Request, Response } from 'express'
import * as gastosService from './gastos.service'

export const getGastos = async (req: Request, res: Response) => {
    try {
    const emprendimientoId = Number(req.params.emprendimientoId)
    const gastos = await gastosService.getGastos(emprendimientoId)
    res.json(gastos)
    } catch (error) {
    res.status(500).json({ error: 'Error al obtener gastos' })
    }
}

export const getGastoById = async (req: Request, res: Response) => {
    try {
    const { id, emprendimientoId } = req.params
    const gasto = await gastosService.getGastoById(Number(id), Number(emprendimientoId))
    if (!gasto) return res.status(404).json({ error: 'Gasto no encontrado' })
    res.json(gasto)
    } catch (error) {
    res.status(500).json({ error: 'Error al obtener gasto' })
    }
}

export const createGasto = async (req: Request, res: Response) => {
    try {
    const emprendimientoId = Number(req.params.emprendimientoId)
    const gasto = await gastosService.createGasto(req.body, emprendimientoId)
    res.status(201).json(gasto)
    } catch (error) {
    res.status(500).json({ error: 'Error al crear gasto' })
    }
}

export const updateGasto = async (req: Request, res: Response) => {
    try {
    const { id } = req.params
    const gasto = await gastosService.updateGasto(Number(id), req.body)
    res.json(gasto)
    } catch (error) {
    res.status(500).json({ error: 'Error al actualizar gasto' })
    }
}

export const deleteGasto = async (req: Request, res: Response) => {
    try {
    const { id } = req.params
    await gastosService.deleteGasto(Number(id))
    res.json({ mensaje: 'Gasto eliminado correctamente' })
    } catch (error) {
    res.status(500).json({ error: 'Error al eliminar gasto' })
    }
}

// Gastos recurrentes
export const getGastosRecurrentes = async (req: Request, res: Response) => {
    try {
    const emprendimientoId = Number(req.params.emprendimientoId)
    const gastosRecurrentes = await gastosService.getGastosRecurrentes(emprendimientoId)
    res.json(gastosRecurrentes)
    } catch (error) {
    res.status(500).json({ error: 'Error al obtener gastos recurrentes' })
    }
}

export const createGastoRecurrente = async (req: Request, res: Response) => {
    try {
    const emprendimientoId = Number(req.params.emprendimientoId)
    const gastoRecurrente = await gastosService.createGastoRecurrente(req.body, emprendimientoId)
    res.status(201).json(gastoRecurrente)
    } catch (error) {
    res.status(500).json({ error: 'Error al crear gasto recurrente' })
    }
}

export const updateGastoRecurrente = async (req: Request, res: Response) => {
    try {
    const { id } = req.params
    const gastoRecurrente = await gastosService.updateGastoRecurrente(Number(id), req.body)
    res.json(gastoRecurrente)
    } catch (error) {
    res.status(500).json({ error: 'Error al actualizar gasto recurrente' })
    }
}

export const deleteGastoRecurrente = async (req: Request, res: Response) => {
    try {
    const { id } = req.params
    await gastosService.deleteGastoRecurrente(Number(id))
    res.json({ mensaje: 'Gasto recurrente desactivado correctamente' })
    } catch (error) {
    res.status(500).json({ error: 'Error al desactivar gasto recurrente' })
    }
}