import express from 'express'
import prisma from './config/prisma'
import checkJwt from './middlewares/auth'
import productosRouter from './modules/productos/productos.router'

const app = express()
const PORT = process.env.PORT || 3000

app.use(express.json())
app.use('/emprendimientos', productosRouter)

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