import { Router } from 'express'
import checkJwt from '../../middlewares/auth'
import * as productosController from './productos.controller'
import * as categoriasController from './categorias.controller'

const router = Router()

router.get('/:emprendimientoId/productos', checkJwt, productosController.getProductos)
router.get('/:emprendimientoId/productos/:id', checkJwt, productosController.getProductoById)
router.post('/:emprendimientoId/productos', checkJwt, productosController.createProducto)
router.put('/:emprendimientoId/productos/:id', checkJwt, productosController.updateProducto)
router.delete('/:emprendimientoId/productos/:id', checkJwt, productosController.deleteProducto)
router.get('/:emprendimientoId/categorias-producto', checkJwt, categoriasController.getCategorias)
router.post('/:emprendimientoId/categorias-producto', checkJwt, categoriasController.createCategoria)
router.delete('/:emprendimientoId/categorias-producto/:id', checkJwt, categoriasController.deleteCategoria)
router.patch('/:emprendimientoId/productos/:id/stock', checkJwt, productosController.descontarStock)

export default router