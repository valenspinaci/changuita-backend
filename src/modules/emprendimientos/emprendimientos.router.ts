import { Router } from 'express'
import checkJwt from '../../middlewares/auth'
import { getMisEmprendimientos, crearEmprendimiento, getEmprendimiento, actualizarEmprendimiento } from './emprendimientos.controller'

const router = Router()

router.get('/', checkJwt, getMisEmprendimientos)
router.post('/', checkJwt, crearEmprendimiento)
router.get('/:id', checkJwt, getEmprendimiento)
router.put('/:id', checkJwt, actualizarEmprendimiento)

export default router