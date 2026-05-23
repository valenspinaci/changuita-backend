import { Request, Response } from 'express'
import prisma from '../../config/prisma'

export const getCategorias = async (req: Request, res: Response) => {
    try {
        const emprendimientoId = Number(req.params.emprendimientoId)
        const categorias = await prisma.categoriaGasto.findMany({
            where: { emprendimientoId },
            orderBy: { nombre: 'asc' }
        })
        res.json(categorias)
    } catch (error) {
        res.status(500).json({ error: 'Error al obtener categorías' })
    }
}

export const createCategoria = async (req: Request, res: Response) => {
    try {
        const emprendimientoId = Number(req.params.emprendimientoId)
        const { nombre, descripcion } = req.body
        if (!nombre) return res.status(400).json({ error: 'El nombre es requerido' })
        const categoria = await prisma.categoriaGasto.create({
            data: { nombre, descripcion, emprendimientoId }
        })
        res.status(201).json(categoria)
    } catch (error) {
        res.status(500).json({ error: 'Error al crear categoría' })
    }
}

export const deleteCategoria = async (req: Request, res: Response) => {
    try {
        const { id } = req.params
        await prisma.categoriaGasto.delete({ where: { id: Number(id) } })
        res.json({ mensaje: 'Categoría eliminada' })
    } catch (error) {
        res.status(500).json({ error: 'Error al eliminar categoría' })
    }
}