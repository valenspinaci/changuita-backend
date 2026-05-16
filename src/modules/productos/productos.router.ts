import { Router } from 'express'
import checkJwt from '../../middlewares/auth'
import * as productosController from './productos.controller'

const router = Router()

router.get('/:emprendimientoId/productos', checkJwt, productosController.getProductos)
router.get('/:emprendimientoId/productos/:id', checkJwt, productosController.getProductoById)
router.post('/:emprendimientoId/productos', checkJwt, productosController.createProducto)
router.put('/:emprendimientoId/productos/:id', checkJwt, productosController.updateProducto)
router.delete('/:emprendimientoId/productos/:id', checkJwt, productosController.deleteProducto)

export default router