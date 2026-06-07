import prisma from '../../config/prisma'

export const getProductos = async (emprendimientoId: number) => {
    return prisma.producto.findMany({
        where: { emprendimientoId, activo: true },
        include: { variantes: true }
    })
}

export const getProductoById = async (id: number, emprendimientoId: number) => {
    return prisma.producto.findFirst({
        where: { id, emprendimientoId, activo: true },
        include: { categoria: true, variantes: true }
    })
}

export const createProducto = async (data: any, emprendimientoId: number) => {
    const producto = await prisma.producto.create({
        data: {
            ...data,
            emprendimientoId
        }
    })

    // Crear variante por defecto
    await prisma.varianteProducto.create({
        data: {
            productoId: producto.id,
            nombre: 'Por defecto',
            precio: data.precio,
            stock: data.stockTotal ?? 0,
            activo: true,
        }
    })

    return producto
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

export const descontarStock = async (productoId: number, cantidad: number) => {
    return prisma.producto.update({
        where: { id: productoId },
        data: { stockTotal: { decrement: cantidad } }
    })
}