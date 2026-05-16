import prisma from '../../config/prisma'

export const getProductos = async (emprendimientoId: number) => {
    return prisma.producto.findMany({
        where: { emprendimientoId, activo: true },
        include: { categoria: true, variantes: true },
        orderBy: { creadoEn: 'desc' }
    })
}

export const getProductoById = async (id: number, emprendimientoId: number) => {
    return prisma.producto.findFirst({
        where: { id, emprendimientoId, activo: true },
        include: { categoria: true, variantes: true }
    })
}

export const createProducto = async (data: any, emprendimientoId: number) => {
    return prisma.producto.create({
    data: {
        ...data,
        emprendimientoId
    }
})
}

export const updateProducto = async (id: number, data: any, emprendimientoId: number) => {
    return prisma.producto.update({
        where: { id },
        data
    })
}

export const deleteProducto = async (id: number, emprendimientoId: number) => {
    return prisma.producto.update({
        where: { id },
        data: { activo: false }
})
}