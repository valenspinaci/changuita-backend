import { Request, Response } from 'express'
import { getMisEmprendimientosService, crearEmprendimientoService, getEmprendimientoService } from './emprendimientos.service'

export const getMisEmprendimientos = async (req: Request, res: Response) => {
    try {
        const auth0Id = req.auth?.payload?.sub as string
        const emprendimientos = await getMisEmprendimientosService(auth0Id)
        res.json(emprendimientos)
    } catch (error) {
        res.status(500).json({ error: 'Error al obtener emprendimientos' })
    }
}

export const crearEmprendimiento = async (req: Request, res: Response) => {
    try {
        const auth0Id = req.auth?.payload?.sub as string
        const { nombre, descripcion } = req.body
        if (!nombre) return res.status(400).json({ error: 'El nombre es requerido' })
        const emprendimiento = await crearEmprendimientoService(auth0Id, { nombre, descripcion })
        res.status(201).json(emprendimiento)
    } catch (error) {
        res.status(500).json({ error: 'Error al crear emprendimiento' })
    }
}

export const getEmprendimiento = async (req: Request, res: Response) => {
    try {
        const auth0Id = req.auth?.payload?.sub as string
        const idParam = Array.isArray(req.params.id) ? req.params.id[0] : req.params.id
        const id = parseInt(idParam)
        const emprendimiento = await getEmprendimientoService(auth0Id, id)
        if (!emprendimiento) return res.status(404).json({ error: 'Emprendimiento no encontrado' })
        res.json(emprendimiento)
    } catch (error) {
        res.status(500).json({ error: 'Error al obtener emprendimiento' })
    }
}