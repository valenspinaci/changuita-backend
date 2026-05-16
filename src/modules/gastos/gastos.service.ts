import prisma from '../../config/prisma'

export const getGastos = async (emprendimientoId: number) => {
    return prisma.gasto.findMany({
    where: { emprendimientoId },
    include: {
        categoria: true,
        proveedor: true,
        gastoRecurrente: true
    },
    orderBy: { fecha: 'desc' }
    })
}

export const getGastoById = async (id: number, emprendimientoId: number) => {
    return prisma.gasto.findFirst({
    where: { id, emprendimientoId },
    include: {
        categoria: true,
        proveedor: true,
        gastoRecurrente: true
    }
    })
}

export const createGasto = async (data: any, emprendimientoId: number) => {
    return prisma.gasto.create({
    data: { ...data, emprendimientoId }
    })
}

export const updateGasto = async (id: number, data: any) => {
    return prisma.gasto.update({
    where: { id },
    data
    })
}

export const deleteGasto = async (id: number) => {
    return prisma.gasto.delete({
    where: { id }
    })
}

// Gastos recurrentes
export const getGastosRecurrentes = async (emprendimientoId: number) => {
    return prisma.gastoRecurrente.findMany({
    where: { emprendimientoId, activo: true },
    include: { categoria: true },
    orderBy: { proximaFecha: 'asc' }
    })
}

export const createGastoRecurrente = async (data: any, emprendimientoId: number) => {
    return prisma.gastoRecurrente.create({
    data: { ...data, emprendimientoId }
    })
}

export const updateGastoRecurrente = async (id: number, data: any) => {
    return prisma.gastoRecurrente.update({
    where: { id },
    data
    })
}

export const deleteGastoRecurrente = async (id: number) => {
    return prisma.gastoRecurrente.update({
    where: { id },
    data: { activo: false }
    })
}