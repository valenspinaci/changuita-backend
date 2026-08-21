import { Request, Response } from 'express'
import * as modulosService from './modulos.service'

export const getModulos = async (req: Request, res: Response) => {
    try {
        const emprendimientoId = Number(req.params.emprendimientoId)
        const modulos = await modulosService.getModulos(emprendimientoId)
        res.json(modulos)
    } catch (error) {
        res.status(500).json({ error: 'Error al obtener módulos' })
    }
}

export const toggleModulo = async (req: Request, res: Response) => {
    try {
        const { emprendimientoId, moduloId } = req.params
        const { habilitado } = req.body
        if (typeof habilitado !== 'boolean') {
            return res.status(400).json({ error: 'habilitado debe ser true o false' })
        }
        const config = await modulosService.toggleModulo(Number(emprendimientoId), Number(moduloId), habilitado)
        res.json(config)
    } catch (error) {
        console.error('Error al actualizar módulo:', error)
        res.status(500).json({ error: 'Error al actualizar módulo' })
    }
}
