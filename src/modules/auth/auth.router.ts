import { Router } from 'express'
import checkJwt from '../../middlewares/auth'
import { syncUser, updateProfile, completarOnboarding } from './auth.controller'

const router = Router()
router.post('/sync', checkJwt, syncUser)
router.put('/me', checkJwt, updateProfile)
router.patch('/onboarding', checkJwt, completarOnboarding)
export default router