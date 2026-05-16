import { Router } from 'express'
import checkJwt from '../../middlewares/auth'
import * as gastosController from './gastos.controller'

const router = Router()

// Gastos
router.get('/:emprendimientoId/gastos', checkJwt, gastosController.getGastos)
router.get('/:emprendimientoId/gastos/:id', checkJwt, gastosController.getGastoById)
router.post('/:emprendimientoId/gastos', checkJwt, gastosController.createGasto)
router.put('/:emprendimientoId/gastos/:id', checkJwt, gastosController.updateGasto)
router.delete('/:emprendimientoId/gastos/:id', checkJwt, gastosController.deleteGasto)

// Gastos recurrentes
router.get('/:emprendimientoId/gastos-recurrentes', checkJwt, gastosController.getGastosRecurrentes)
router.post('/:emprendimientoId/gastos-recurrentes', checkJwt, gastosController.createGastoRecurrente)
router.put('/:emprendimientoId/gastos-recurrentes/:id', checkJwt, gastosController.updateGastoRecurrente)
router.delete('/:emprendimientoId/gastos-recurrentes/:id', checkJwt, gastosController.deleteGastoRecurrente)

export default router