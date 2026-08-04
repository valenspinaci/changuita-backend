import { Request, Response } from 'express'
import { upsertUsuario } from '../../utils/upsertUsuario'

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
