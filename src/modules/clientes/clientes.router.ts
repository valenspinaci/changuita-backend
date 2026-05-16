import { Router } from 'express'
import checkJwt from '../../middlewares/auth'
import * as clientesController from './clientes.controller'

const router = Router()

router.get('/:emprendimientoId/clientes', checkJwt, clientesController.getClientes)
router.get('/:emprendimientoId/clientes/:id', checkJwt, clientesController.getClienteById)
router.post('/:emprendimientoId/clientes', checkJwt, clientesController.createCliente)
router.put('/:emprendimientoId/clientes/:id', checkJwt, clientesController.updateCliente)
router.delete('/:emprendimientoId/clientes/:id', checkJwt, clientesController.deleteCliente)

export default router