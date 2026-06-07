import { Router } from 'express'
import checkJwt from '../../middlewares/auth'
import { syncUser } from './auth.controller'

const router = Router()
router.post('/sync', checkJwt, syncUser)
export default router