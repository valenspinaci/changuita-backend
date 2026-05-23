import prisma from '../../config/prisma'

export const getClientes = async (emprendimientoId: number) => {
    return prisma.cliente.findMany({
        where: { emprendimientoId },
        include: {
            ventas: {
                select: { total: true, creadoEn: true, estado: true }
            }
        },
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

export const updateCliente = async (id: number, emprendimientoId: number, data: any) => {
    const { nombre, email, telefono, direccion, notas } = data
    // Primero verificar que pertenece al emprendimiento
    const cliente = await prisma.cliente.findFirst({
        where: { id, emprendimientoId }
    })
    if (!cliente) throw new Error('Cliente no encontrado')
    return prisma.cliente.update({
        where: { id },
        data: { nombre, email, telefono, direccion, notas }
    })
}

export const deleteCliente = async (id: number) => {
    return prisma.cliente.delete({
    where: { id }
    })
}