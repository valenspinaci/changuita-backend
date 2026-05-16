import express from 'express'
import prisma from './config/prisma'

const app = express()
const PORT = process.env.PORT || 3000

app.use(express.json())

app.get('/health', async (req, res) => {
    try {
        await prisma.$queryRaw`SELECT 1`
        res.json({ status: 'ok', message: 'API de Changuita corriendo', db: 'conectada' })
    } catch (error) {
        res.status(500).json({ status: 'error', db: 'desconectada' })
    }
})

app.listen(PORT, () => {
    console.log(`Servidor corriendo en http://localhost:${PORT}`)
})

export default app