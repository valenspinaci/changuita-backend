import { auth } from 'express-oauth2-jwt-bearer'

//Este middleware lo voy a poner en cualquier endpoint que requiera que el usuario esté logueado. 
//Si el token no es válido, Auth0 rechaza la request automáticamente con un 401

const checkJwt = auth({
    audience: process.env.AUTH0_AUDIENCE,
    issuerBaseURL: `https://${process.env.AUTH0_DOMAIN}`,
})

export default checkJwt