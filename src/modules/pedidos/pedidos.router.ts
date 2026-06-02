import { Router } from 'express'
import checkJwt from '../../middlewares/auth'
import * as pedidosController from './pedidos.controller'

const router = Router()

router.get('/:emprendimientoId/pedidos', checkJwt, pedidosController.getPedidos)
router.get('/:emprendimientoId/pedidos/:id', checkJwt, pedidosController.getPedidoById)
router.post('/:emprendimientoId/pedidos', checkJwt, pedidosController.createPedido)
router.patch('/:emprendimientoId/pedidos/:id/estado', checkJwt, pedidosController.updateEstadoPedido)
router.delete('/:emprendimientoId/pedidos/:id', checkJwt, pedidosController.deletePedido)
router.put('/:emprendimientoId/pedidos/:id', checkJwt, pedidosController.updatePedido)

export default router