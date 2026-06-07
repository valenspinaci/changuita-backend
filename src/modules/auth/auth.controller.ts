import { Request, Response } from 'express'
import { PrismaClient } from '@prisma/client'

const prisma = new PrismaClient()

export const syncUser = async (req: Request, res: Response) => {
    try {
        const auth0Id = req.auth?.payload?.sub as string
        const email = req.auth?.payload?.email as string ?? ''
        const nombre = req.auth?.payload?.name as string ?? ''
        
        const usuario = await prisma.usuario.upsert({
            where: { auth0Id },
            update: { email, nombre },
            create: { auth0Id, email, nombre }
        })
        res.json(usuario)
    } catch (error) {
        console.error('Error sync usuario:', error)
        res.status(500).json({ error: 'Error al sincronizar usuario' })
    }
}