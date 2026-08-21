import { Router } from 'express'
import checkJwt from '../../middlewares/auth'
import * as modulosController from './modulos.controller'

const router = Router()

router.get('/:emprendimientoId/modulos', checkJwt, modulosController.getModulos)
router.patch('/:emprendimientoId/modulos/:moduloId', checkJwt, modulosController.toggleModulo)

export default router
