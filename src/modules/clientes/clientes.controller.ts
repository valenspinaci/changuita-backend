import { Request, Response } from 'express'
import * as clientesService from './clientes.service'

export const getClientes = async (req: Request, res: Response) => {
    try {
    const emprendimientoId = Number(req.params.emprendimientoId)
    const clientes = await clientesService.getClientes(emprendimientoId)
    res.json(clientes)
    } catch (error) {
    res.status(500).json({ error: 'Error al obtener clientes' })
    }
}

export const getClienteById = async (req: Request, res: Response) => {
    try {
    const { id, emprendimientoId } = req.params
    const cliente = await clientesService.getClienteById(Number(id), Number(emprendimientoId))
    if (!cliente) return res.status(404).json({ error: 'Cliente no encontrado' })
    res.json(cliente)
    } catch (error) {
    res.status(500).json({ error: 'Error al obtener cliente' })
    }
}

export const createCliente = async (req: Request, res: Response) => {
    try {
    const emprendimientoId = Number(req.params.emprendimientoId)
    const cliente = await clientesService.createCliente(req.body, emprendimientoId)
    res.status(201).json(cliente)
    } catch (error) {
    res.status(500).json({ error: 'Error al crear cliente' })
    }
}

export const updateCliente = async (req: Request, res: Response) => {
    try {
        const { id, emprendimientoId } = req.params
        const cliente = await clientesService.updateCliente(Number(id), Number(emprendimientoId), req.body)
        res.json(cliente)
    } catch (error) {
        console.error('Error updateCliente:', error)
        res.status(500).json({ error: 'Error al actualizar cliente' })
    }
}

export const deleteCliente = async (req: Request, res: Response) => {
    try {
    const { id } = req.params
    await clientesService.deleteCliente(Number(id))
    res.json({ mensaje: 'Cliente eliminado correctamente' })
    } catch (error) {
    res.status(500).json({ error: 'Error al eliminar cliente' })
    }
}