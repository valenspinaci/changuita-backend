import { PrismaClient } from '@prisma/client'

const prisma = new PrismaClient()

export const getMisEmprendimientosService = async (auth0Id: string) => {
    return prisma.emprendimiento.findMany({
        where: {
            miembros: {
                some: {
                    usuario: { auth0Id }
                }
            }
        },
        include: {
            miembros: {
                where: { usuario: { auth0Id } },
                select: { rol: true }
            }
        }
    })
}

export const crearEmprendimientoService = async (auth0Id: string, data: { nombre: string, descripcion?: string }) => {
    // Primero buscamos o creamos el usuario
    console.log('auth0Id recibido:', auth0Id)
    const usuario = await prisma.usuario.upsert({
        where: { auth0Id },
        update: {},
        create: {
            auth0Id,
            email: '',   // se actualiza después con el perfil real
            nombre: '',
        }
    })

    return prisma.emprendimiento.create({
        data: {
            nombre: data.nombre,
            descripcion: data.descripcion,
            miembros: {
                create: {
                    usuarioId: usuario.id,
                    rol: 'OWNER'
                }
            }
        }
    })
}

export const getEmprendimientoService = async (auth0Id: string, id: number) => {
    return prisma.emprendimiento.findFirst({
        where: {
            id,
            miembros: {
                some: { usuario: { auth0Id } }
            }
        }
    })
}