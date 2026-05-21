import { Router } from 'express'
import checkJwt from '../../middlewares/auth'
import * as ventasController from './ventas.controller'

const router = Router()

router.get('/:emprendimientoId/ventas', checkJwt, ventasController.getVentas)
router.get('/:emprendimientoId/ventas/:id', checkJwt, ventasController.getVentaById)
router.post('/:emprendimientoId/ventas', checkJwt, ventasController.createVenta)
router.patch('/:emprendimientoId/ventas/:id/estado', checkJwt, ventasController.updateEstadoVenta)
router.delete('/:emprendimientoId/ventas/:id', checkJwt, ventasController.deleteVenta)

export default router;