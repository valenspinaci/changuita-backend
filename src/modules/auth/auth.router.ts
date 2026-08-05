import { Router } from 'express'
import checkJwt from '../../middlewares/auth'
import { syncUser, updateProfile } from './auth.controller'

const router = Router()
router.post('/sync', checkJwt, syncUser)
router.put('/me', checkJwt, updateProfile)
export default router