import { Router } from 'express'
import checkJwt from '../../middlewares/auth'
import { getMisEmprendimientos, crearEmprendimiento, getEmprendimiento } from './emprendimientos.controller'

const router = Router()

router.get('/', checkJwt, getMisEmprendimientos)
router.post('/', checkJwt, crearEmprendimiento)
router.get('/:id', checkJwt, getEmprendimiento)

export default router