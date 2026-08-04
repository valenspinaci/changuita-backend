import { Prisma, PrismaClient, Usuario } from '@prisma/client'

const prisma = new PrismaClient()

// Crea o actualiza el Usuario ligado a un auth0Id (sub del JWT).
// Si el email ya pertenece a otro auth0Id (cuenta de Auth0 borrada y
// recreada con el mismo email), re-vincula esa fila al auth0Id nuevo
// en vez de fallar con un unique constraint en `email`.
export const upsertUsuario = async (auth0Id: string, email: string, nombre: string): Promise<Usuario> => {
    try {
        return await prisma.usuario.upsert({
            where: { auth0Id },
            update: {
                ...(email ? { email } : {}),
                ...(nombre ? { nombre } : {}),
            },
            create: {
                auth0Id,
                email: email || auth0Id,
                nombre: nombre || '',
            },
        })
    } catch (error) {
        const esEmailDuplicado =
            error instanceof Prisma.PrismaClientKnownRequestError &&
            error.code === 'P2002' &&
            (error.meta?.target as string[] | undefined)?.includes('email')

        if (!esEmailDuplicado || !email) throw error

        return prisma.usuario.update({
            where: { email },
            data: {
                auth0Id,
                ...(nombre ? { nombre } : {}),
            },
        })
    }
}
