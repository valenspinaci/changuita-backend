import prisma from '../../config/prisma'

export const getClientes = async (emprendimientoId: number) => {
    return prisma.cliente.findMany({
    where: { emprendimientoId },
    orderBy: { creadoEn: 'desc' }
    })
}

export const getClienteById = async (id: number, emprendimientoId: number) => {
    return prisma.cliente.findFirst({
    where: { id, emprendimientoId },
    include: {
        ventas: { orderBy: { creadoEn: 'desc' }, take: 5 },
        pedidos: { orderBy: { creadoEn: 'desc' }, take: 5 }
    }
    })
}

export const createCliente = async (data: any, emprendimientoId: number) => {
    return prisma.cliente.create({
    data: { ...data, emprendimientoId }
    })
}

export const updateCliente = async (id: number, data: any) => {
    return prisma.cliente.update({
    where: { id },
    data
    })
}

export const deleteCliente = async (id: number) => {
    return prisma.cliente.delete({
    where: { id }
    })
}