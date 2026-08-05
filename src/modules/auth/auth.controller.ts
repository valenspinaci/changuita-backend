import { Request, Response } from 'express'
import { PrismaClient } from '@prisma/client'
import { upsertUsuario } from '../../utils/upsertUsuario'

const prisma = new PrismaClient()

export const syncUser = async (req: Request, res: Response) => {
    try {
        const auth0Id = req.auth?.payload?.sub as string
        const email = req.auth?.payload?.email as string ?? ''
        const nombre = req.auth?.payload?.name as string ?? ''

        const usuario = await upsertUsuario(auth0Id, email, nombre)
        res.json(usuario)
    } catch (error) {
        console.error('Error sync usuario:', error)
        res.status(500).json({ error: 'Error al sincronizar usuario' })
    }
}

export const updateProfile = async (req: Request, res: Response) => {
    try {
        const auth0Id = req.auth?.payload?.sub as string
        const { nombre } = req.body
        if (!nombre || !nombre.trim()) {
            return res.status(400).json({ error: 'El nombre no puede estar vacío' })
        }
        const usuario = await prisma.usuario.update({
            where: { auth0Id },
            data: { nombre }
        })
        res.json(usuario)
    } catch (error) {
        console.error('Error al actualizar perfil:', error)
        res.status(500).json({ error: 'Error al actualizar perfil' })
    }
}
