import prisma from '../../config/prisma'

export const getPedidos = async (emprendimientoId: number) => {
    return prisma.pedido.findMany({
    where: { emprendimientoId },
    include: {
        cliente: true,
        detalles: {
        include: { variante: { include: { producto: true } } }
        }
    },
    orderBy: { creadoEn: 'desc' }
    })
}

export const getPedidoById = async (id: number, emprendimientoId: number) => {
    return prisma.pedido.findFirst({
    where: { id, emprendimientoId },
    include: {
        cliente: true,
        detalles: {
        include: { variante: { include: { producto: true } } }
        },
        venta: true
    }
    })
}

export const createPedido = async (data: any, emprendimientoId: number) => {
    const { detalles, clienteId, fechaEstimada, notas } = data

    return prisma.pedido.create({
    data: {
        emprendimientoId,
        clienteId,
        fechaEstimada,
        notas,
        estado: 'PENDIENTE',
        detalles: {
        create: detalles.map((d: any) => ({
            varianteId: d.varianteId,
            cantidad: d.cantidad,
            precioUnitario: d.precioUnitario
        }))
        }
    },
    include: { detalles: true }
    })
}

export const updateEstadoPedido = async (id: number, estado: string) => {
    return prisma.pedido.update({
    where: { id },
    data: { estado: estado as any }
    })
}

export const deletePedido = async (id: number) => {
    return prisma.pedido.update({
    where: { id },
    data: { estado: 'CANCELADO' }
    })
}

export const updatePedido = async (id: number, data: any) => {
    return prisma.pedido.update({
        where: { id },
        data: {
        notas: data.notas,
        fechaEstimada: data.fechaEstimada,
        clienteId: data.clienteId,
        },
        include: { cliente: true, detalles: true }
    })
}