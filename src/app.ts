import express from 'express'
import prisma from './config/prisma'
import checkJwt from './middlewares/auth'
import productosRouter from './modules/productos/productos.router'
import ventasRouter from './modules/ventas/ventas.router'
import clientesRouter from './modules/clientes/clientes.router'
import pedidosRouter from './modules/pedidos/pedidos.router'
import gastosRouter from './modules/gastos/gastos.router'
import emprendimientosRouter from './modules/emprendimientos/emprendimientos.router'
import cors from 'cors'

const app = express()
const PORT = process.env.PORT || 3000

app.use(cors({
    origin: ['http://localhost:3002', 'http://localhost:3000'],
    credentials: true,
}))

app.use(express.json())
app.use('/emprendimientos', productosRouter)
app.use('/emprendimientos', ventasRouter)
app.use('/emprendimientos', clientesRouter)
app.use('/emprendimientos', pedidosRouter)
app.use('/emprendimientos', gastosRouter)
app.use('/emprendimientos', emprendimientosRouter)
// Ruta pública
app.get('/health', async (req, res) => {
    try {
        await prisma.$queryRaw`SELECT 1`
        res.json({ status: 'ok', message: 'API de Changuita corriendo', db: 'conectada' })
    } catch (error) {
        res.status(500).json({ status: 'error', db: 'desconectada' })
    }
})

// Ruta protegida de prueba
app.get('/protegido', checkJwt, (req, res) => {
    res.json({ mensaje: 'Si ves esto, estás autenticado' })
})

app.listen(PORT, () => {
    console.log(`Servidor corriendo en http://localhost:${PORT}`)
})

export default app