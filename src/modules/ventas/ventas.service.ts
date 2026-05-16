import prisma from '../../config/prisma'

export const getVentas = async (emprendimientoId: number) => {
    return prisma.venta.findMany({
    where: { emprendimientoId },
    include: {
        cliente: true,
        medioPago: true,
        detalles: {
        include: { variante: { include: { producto: true } } }
        }
    },
    orderBy: { creadoEn: 'desc' }
    })
}

export const getVentaById = async (id: number, emprendimientoId: number) => {
    return prisma.venta.findFirst({
        where: { id, emprendimientoId },
        include: {
            cliente: true,
            medioPago: true,
            detalles: {
        include: { variante: { include: { producto: true } } }
        }
    }
    })
}

export const createVenta = async (data: any, emprendimientoId: number) => {
    const { detalles, clienteId, medioPagoId, descuento = 0, notas } = data

    return prisma.$transaction(async (tx) => {
    // 1. Verificar y descontar stock de cada variante
    for (const detalle of detalles) {
        const variante = await tx.varianteProducto.findUnique({
        where: { id: detalle.varianteId }
        })
        if (!variante) throw new Error(`Variante ${detalle.varianteId} no encontrada`)
        if (variante.stock < detalle.cantidad) {
        throw new Error(`Stock insuficiente para la variante ${variante.nombre}`)
        }
        await tx.varianteProducto.update({
        where: { id: detalle.varianteId },
        data: { stock: { decrement: detalle.cantidad } }
        })
    }

    // 2. Calcular total
    let total = detalles.reduce((acc: number, d: any) => {
      return acc + d.precioUnitario * d.cantidad
    }, 0)
    total = total - descuento

    // 3. Crear la venta
    const venta = await tx.venta.create({
        data: {
        emprendimientoId,
        clienteId,
        medioPagoId,
        descuento,
        notas,
        total,
        estado: 'PENDIENTE',
        detalles: {
            create: detalles.map((d: any) => ({
            varianteId: d.varianteId,
            cantidad: d.cantidad,
            precioUnitario: d.precioUnitario
            }))
        }
        },
        include: {
        detalles: true
        }
    })

    // 4. Verificar stock minimo y generar notificacion si hace falta
    for (const detalle of detalles) {
        const variante = await tx.varianteProducto.findUnique({
        where: { id: detalle.varianteId },
        include: { producto: true }
        })
        if (variante && variante.stock <= variante.producto.stockMinimo) {
        // TODO: disparar notificacion de stock bajo
        console.log(`⚠️ Stock bajo: ${variante.producto.nombre} - ${variante.nombre}`)
        }
    }

    return venta
    })
}

export const updateEstadoVenta = async (id: number, estado: string, emprendimientoId: number) => {
    return prisma.venta.update({
    where: { id },
    data: { estado: estado as any }
    })
}