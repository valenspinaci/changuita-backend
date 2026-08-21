import { PrismaClient } from '@prisma/client'

const prisma = new PrismaClient()

const MODULOS = [
    { nombre: 'ventas', descripcion: 'Registro y seguimiento de ventas' },
    { nombre: 'pedidos', descripcion: 'Gestión de pedidos por estado' },
    { nombre: 'gastos', descripcion: 'Registro y categorización de gastos' },
    { nombre: 'clientes', descripcion: 'ABM de clientes e historial de compras' },
    { nombre: 'stock', descripcion: 'Gestión de productos y stock' },
    { nombre: 'reportes', descripcion: 'Reportes y visualización de datos' },
    { nombre: 'integraciones', descripcion: 'Integraciones con MercadoPago, TiendaNube y WhatsApp' },
]

async function main() {
    for (const modulo of MODULOS) {
        await prisma.modulo.upsert({
            where: { nombre: modulo.nombre },
            update: { descripcion: modulo.descripcion },
            create: modulo,
        })
    }
    console.log(`Seed OK: ${MODULOS.length} módulos.`)
}

main()
    .catch(e => {
        console.error(e)
        process.exit(1)
    })
    .finally(() => prisma.$disconnect())
