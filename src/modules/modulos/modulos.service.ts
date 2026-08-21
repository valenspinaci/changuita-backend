import prisma from '../../config/prisma'

export const getModulos = async (emprendimientoId: number) => {
    const [modulos, configs] = await Promise.all([
        prisma.modulo.findMany({ where: { activo: true }, orderBy: { id: 'asc' } }),
        prisma.configuracionModulo.findMany({ where: { emprendimientoId } }),
    ])

    const configPorModulo = new Map(configs.map(c => [c.moduloId, c.habilitado]))

    return modulos.map(m => ({
        id: m.id,
        nombre: m.nombre,
        descripcion: m.descripcion,
        habilitado: configPorModulo.get(m.id) ?? true,
    }))
}

export const toggleModulo = async (emprendimientoId: number, moduloId: number, habilitado: boolean) => {
    return prisma.configuracionModulo.upsert({
        where: { emprendimientoId_moduloId: { emprendimientoId, moduloId } },
        update: { habilitado },
        create: { emprendimientoId, moduloId, habilitado },
    })
}
