import { Request, Response } from 'express'
import * as pedidosService from './pedidos.service'

export const getPedidos = async (req: Request, res: Response) => {
    try {
    const emprendimientoId = Number(req.params.emprendimientoId)
    const pedidos = await pedidosService.getPedidos(emprendimientoId)
    res.json(pedidos)
    } catch (error) {
    res.status(500).json({ error: 'Error al obtener pedidos' })
    }
}

export const getPedidoById = async (req: Request, res: Response) => {
    try {
    const { id, emprendimientoId } = req.params
    const pedido = await pedidosService.getPedidoById(Number(id), Number(emprendimientoId))
    if (!pedido) return res.status(404).json({ error: 'Pedido no encontrado' })
    res.json(pedido)
    } catch (error) {
    res.status(500).json({ error: 'Error al obtener pedido' })
    }
}

export const createPedido = async (req: Request, res: Response) => {
    try {
    const emprendimientoId = Number(req.params.emprendimientoId)
    const pedido = await pedidosService.createPedido(req.body, emprendimientoId)
    res.status(201).json(pedido)
    } catch (error) {
    res.status(500).json({ error: 'Error al crear pedido' })
    }
}

export const updateEstadoPedido = async (req: Request, res: Response) => {
    try {
    const { id } = req.params
    const { estado } = req.body
    const pedido = await pedidosService.updateEstadoPedido(Number(id), estado)
    res.json(pedido)
    } catch (error) {
    res.status(500).json({ error: 'Error al actualizar estado del pedido' })
    }
}

export const deletePedido = async (req: Request, res: Response) => {
    try {
    const { id } = req.params
    await pedidosService.deletePedido(Number(id))
    res.json({ mensaje: 'Pedido cancelado correctamente' })
    } catch (error) {
    res.status(500).json({ error: 'Error al cancelar pedido' })
    }
}

export const updatePedido = async (req: Request, res: Response) => {
    try {
        const { id } = req.params
        const { notas, fechaEstimada, clienteId } = req.body
        const pedido = await pedidosService.updatePedido(Number(id), { notas, fechaEstimada, clienteId })
        res.json(pedido)
    } catch (error) {
        res.status(500).json({ error: 'Error al actualizar pedido' })
    }
}