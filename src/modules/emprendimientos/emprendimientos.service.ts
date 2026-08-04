import { PrismaClient } from '@prisma/client'
import { upsertUsuario } from '../../utils/upsertUsuario'

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

export const crearEmprendimientoService = async (
    auth0Id: string,
    email: string,
    nombre: string,
    data: { nombre: string, descripcion?: string }
) => {
const usuario = await upsertUsuario(auth0Id, email, nombre)
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