import { Request, Response } from 'express'
import { getMisEmprendimientosService, crearEmprendimientoService, getEmprendimientoService, actualizarEmprendimientoService } from './emprendimientos.service'

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
const email = req.auth?.payload?.email as string ?? ''
const nombre = req.auth?.payload?.name as string ?? ''
console.log('payload completo:', JSON.stringify(req.auth?.payload))
        const { nombre: nombreEmprendimiento, descripcion } = req.body
        if (!nombreEmprendimiento) return res.status(400).json({ error: 'El nombre es requerido' })
        const emprendimiento = await crearEmprendimientoService(auth0Id, email, nombre, { nombre: nombreEmprendimiento, descripcion })
        res.status(201).json(emprendimiento)
    } catch (error) {
        console.error('Error al crear emprendimiento:', error)
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

export const actualizarEmprendimiento = async (req: Request, res: Response) => {
    try {
        const auth0Id = req.auth?.payload?.sub as string
        const idParam = Array.isArray(req.params.id) ? req.params.id[0] : req.params.id
        const id = parseInt(idParam)
        const { nombre, descripcion } = req.body
        if (nombre !== undefined && !nombre.trim()) {
            return res.status(400).json({ error: 'El nombre no puede estar vacío' })
        }
        const emprendimiento = await actualizarEmprendimientoService(auth0Id, id, { nombre, descripcion })
        if (!emprendimiento) return res.status(404).json({ error: 'Emprendimiento no encontrado' })
        res.json(emprendimiento)
    } catch (error) {
        console.error('Error al actualizar emprendimiento:', error)
        res.status(500).json({ error: 'Error al actualizar emprendimiento' })
    }
}