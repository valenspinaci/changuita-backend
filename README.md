# Changuita – Backend

API REST del sistema Changuita, una plataforma de gestión para emprendedores. Provee todos los endpoints consumidos por la Web App y la Mobile App.

---

## Descripción del proyecto

Changuita es una solución de gestión integral para pequeños emprendedores. El backend expone una API RESTful que centraliza la lógica de negocio: autenticación vía Auth0, gestión de productos y stock, registro de ventas y gastos, administración de clientes y pedidos, y métricas para el dashboard.

---

## Instalación de dependencias

```bash
npm install
```

---

## Cómo correr el proyecto en local

```bash
# Modo desarrollo (con ts-node, sin compilar)
npm run dev

# Compilar TypeScript a dist/
npm run build

# Correr la versión compilada
npm start
```

El servidor corre por defecto en `http://localhost:3001`.

---

## Variables de entorno

Crear un archivo `.env` en la raíz del proyecto con las siguientes variables:

```env
# Base de datos
DATABASE_URL=postgresql://usuario:contraseña@host:puerto/nombre_db

# Auth0
AUTH0_DOMAIN=dev-yhoe6u1lccz83eud.us.auth0.com
AUTH0_AUDIENCE=https://api.changuita.app

# Servidor
PORT=3001
```

> ⚠️ Nunca subir el archivo `.env` al repositorio.

---

## Arquitectura técnica

```
changuita-backend/
├── prisma/
│   ├── schema.prisma         # Modelo de datos (Prisma ORM)
│   └── migrations/           # Historial de migraciones
├── src/
│   ├── config/               # Configuración de Auth0 y variables de entorno
│   ├── middlewares/          # Middleware de autenticación JWT (checkJwt)
│   ├── modules/              # Módulos organizados por dominio
│   │   ├── auth/             # Sync de usuario post-login
│   │   ├── emprendimientos/  # CRUD de emprendimientos
│   │   ├── productos/        # Gestión de productos y variantes
│   │   ├── ventas/           # Registro y listado de ventas
│   │   ├── gastos/           # Registro y categorización de gastos
│   │   ├── clientes/         # ABM de clientes
│   │   └── pedidos/          # Gestión de pedidos por estado
│   └── app.ts                # Entry point del servidor Express
├── .env                      # Variables de entorno (no incluido en el repo)
├── .gitignore
├── package.json
└── tsconfig.json
```

Cada módulo dentro de `src/modules/` sigue la estructura:
- `router.ts` – definición de rutas
- `controller.ts` – manejo de requests/responses
- `service.ts` – lógica de negocio y acceso a datos via Prisma

---

## Librerías principales

| Librería | Versión | Uso |
|---|---|---|
| `express` | ^5.x | Framework HTTP |
| `@prisma/client` | ^6.x | ORM para acceso a base de datos |
| `prisma` | ^6.x | CLI de migraciones y generación de cliente |
| `express-oauth2-jwt-bearer` | ^1.x | Validación de tokens JWT de Auth0 |
| `cors` | ^2.x | Habilitación de CORS para web y mobile |
| `dotenv` | ^17.x | Carga de variables de entorno |
| `typescript` | ^6.x | Tipado estático |
| `ts-node` | ^10.x | Ejecución de TypeScript en desarrollo |

---

## Deploy

El backend está deployado en **Render**:

```
https://changuita-backend-9zrf.onrender.com
```

> ℹ️ En el plan gratuito de Render el servicio se duerme tras 15 minutos de inactividad. La primera request puede tardar unos segundos en responder mientras despierta.

---

## Seguridad

- Las contraseñas de usuarios nunca pasan por este servidor; la autenticación es delegada completamente a **Auth0**.
- Los tokens JWT son validados en cada endpoint protegido con el middleware `checkJwt`.
- Variables sensibles gestionadas con `.env` y excluidas del repositorio vía `.gitignore`.
- En producción los errores técnicos no se exponen al cliente; se retornan mensajes genéricos.
