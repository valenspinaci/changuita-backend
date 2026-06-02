-- CreateEnum
CREATE TYPE "RolEmprendimiento" AS ENUM ('OWNER', 'ADMIN', 'OPERADOR', 'VISUALIZADOR');

-- CreateEnum
CREATE TYPE "EstadoSuscripcion" AS ENUM ('ACTIVA', 'VENCIDA', 'CANCELADA', 'PRUEBA');

-- CreateEnum
CREATE TYPE "EstadoVenta" AS ENUM ('PENDIENTE', 'COBRADA', 'CANCELADA', 'DEVUELTA');

-- CreateEnum
CREATE TYPE "EstadoPedido" AS ENUM ('PENDIENTE', 'ACTIVO', 'ENTREGADO', 'CANCELADO');

-- CreateEnum
CREATE TYPE "FrecuenciaGasto" AS ENUM ('DIARIO', 'SEMANAL', 'MENSUAL', 'TRIMESTRAL', 'ANUAL');

-- CreateEnum
CREATE TYPE "TipoNotificacion" AS ENUM ('STOCK_MINIMO', 'PAGO_PENDIENTE', 'PEDIDO_NUEVO', 'VENTA_REGISTRADA', 'SUSCRIPCION_POR_VENCER', 'GASTO_RECURRENTE', 'SISTEMA');

-- CreateTable
CREATE TABLE "usuario" (
    "id" SERIAL NOT NULL,
    "auth0_id" TEXT NOT NULL,
    "email" TEXT NOT NULL,
    "nombre" TEXT NOT NULL,
    "avatar_url" TEXT,
    "creado_en" TIMESTAMP(3) NOT NULL DEFAULT CURRENT_TIMESTAMP,
    "actualizado_en" TIMESTAMP(3) NOT NULL,

    CONSTRAINT "usuario_pkey" PRIMARY KEY ("id")
);

-- CreateTable
CREATE TABLE "modulo" (
    "id" SERIAL NOT NULL,
    "nombre" TEXT NOT NULL,
    "descripcion" TEXT,
    "activo" BOOLEAN NOT NULL DEFAULT true,

    CONSTRAINT "modulo_pkey" PRIMARY KEY ("id")
);

-- CreateTable
CREATE TABLE "configuracion_modulo" (
    "id" SERIAL NOT NULL,
    "emprendimiento_id" INTEGER NOT NULL,
    "modulo_id" INTEGER NOT NULL,
    "habilitado" BOOLEAN NOT NULL DEFAULT true,
    "creado_en" TIMESTAMP(3) NOT NULL DEFAULT CURRENT_TIMESTAMP,

    CONSTRAINT "configuracion_modulo_pkey" PRIMARY KEY ("id")
);

-- CreateTable
CREATE TABLE "emprendimiento" (
    "id" SERIAL NOT NULL,
    "nombre" TEXT NOT NULL,
    "descripcion" TEXT,
    "logo_url" TEXT,
    "creado_en" TIMESTAMP(3) NOT NULL DEFAULT CURRENT_TIMESTAMP,
    "actualizado_en" TIMESTAMP(3) NOT NULL,

    CONSTRAINT "emprendimiento_pkey" PRIMARY KEY ("id")
);

-- CreateTable
CREATE TABLE "miembro_emprendimiento" (
    "id" SERIAL NOT NULL,
    "usuario_id" INTEGER NOT NULL,
    "emprendimiento_id" INTEGER NOT NULL,
    "rol" "RolEmprendimiento" NOT NULL DEFAULT 'OPERADOR',
    "creado_en" TIMESTAMP(3) NOT NULL DEFAULT CURRENT_TIMESTAMP,

    CONSTRAINT "miembro_emprendimiento_pkey" PRIMARY KEY ("id")
);

-- CreateTable
CREATE TABLE "plan" (
    "id" SERIAL NOT NULL,
    "nombre" TEXT NOT NULL,
    "descripcion" TEXT,
    "precio" DECIMAL(10,2) NOT NULL,
    "activo" BOOLEAN NOT NULL DEFAULT true,

    CONSTRAINT "plan_pkey" PRIMARY KEY ("id")
);

-- CreateTable
CREATE TABLE "suscripcion" (
    "id" SERIAL NOT NULL,
    "emprendimiento_id" INTEGER NOT NULL,
    "plan_id" INTEGER NOT NULL,
    "estado" "EstadoSuscripcion" NOT NULL DEFAULT 'PRUEBA',
    "fecha_inicio" TIMESTAMP(3) NOT NULL,
    "fecha_fin" TIMESTAMP(3),
    "creado_en" TIMESTAMP(3) NOT NULL DEFAULT CURRENT_TIMESTAMP,

    CONSTRAINT "suscripcion_pkey" PRIMARY KEY ("id")
);

-- CreateTable
CREATE TABLE "integracion" (
    "id" SERIAL NOT NULL,
    "nombre" TEXT NOT NULL,
    "descripcion" TEXT,
    "logo_url" TEXT,
    "activa" BOOLEAN NOT NULL DEFAULT true,

    CONSTRAINT "integracion_pkey" PRIMARY KEY ("id")
);

-- CreateTable
CREATE TABLE "plan_integracion" (
    "id" SERIAL NOT NULL,
    "plan_id" INTEGER NOT NULL,
    "integracion_id" INTEGER NOT NULL,

    CONSTRAINT "plan_integracion_pkey" PRIMARY KEY ("id")
);

-- CreateTable
CREATE TABLE "emprendimiento_integracion" (
    "id" SERIAL NOT NULL,
    "emprendimiento_id" INTEGER NOT NULL,
    "integracion_id" INTEGER NOT NULL,
    "access_token" TEXT,
    "refresh_token" TEXT,
    "external_shop_id" TEXT,
    "activa" BOOLEAN NOT NULL DEFAULT true,
    "creado_en" TIMESTAMP(3) NOT NULL DEFAULT CURRENT_TIMESTAMP,

    CONSTRAINT "emprendimiento_integracion_pkey" PRIMARY KEY ("id")
);

-- CreateTable
CREATE TABLE "categoria_producto" (
    "id" SERIAL NOT NULL,
    "emprendimiento_id" INTEGER NOT NULL,
    "nombre" TEXT NOT NULL,
    "descripcion" TEXT,

    CONSTRAINT "categoria_producto_pkey" PRIMARY KEY ("id")
);

-- CreateTable
CREATE TABLE "producto" (
    "id" SERIAL NOT NULL,
    "emprendimiento_id" INTEGER NOT NULL,
    "categoria_id" INTEGER,
    "nombre" TEXT NOT NULL,
    "descripcion" TEXT,
    "precio" DECIMAL(10,2) NOT NULL,
    "stock_total" INTEGER NOT NULL DEFAULT 0,
    "stock_minimo" INTEGER NOT NULL DEFAULT 0,
    "imagen_url" TEXT,
    "activo" BOOLEAN NOT NULL DEFAULT true,
    "creado_en" TIMESTAMP(3) NOT NULL DEFAULT CURRENT_TIMESTAMP,
    "actualizado_en" TIMESTAMP(3) NOT NULL,

    CONSTRAINT "producto_pkey" PRIMARY KEY ("id")
);

-- CreateTable
CREATE TABLE "variante_producto" (
    "id" SERIAL NOT NULL,
    "producto_id" INTEGER NOT NULL,
    "nombre" TEXT NOT NULL,
    "sku" TEXT,
    "precio" DECIMAL(10,2),
    "stock" INTEGER NOT NULL DEFAULT 0,
    "activo" BOOLEAN NOT NULL DEFAULT true,

    CONSTRAINT "variante_producto_pkey" PRIMARY KEY ("id")
);

-- CreateTable
CREATE TABLE "cliente" (
    "id" SERIAL NOT NULL,
    "emprendimiento_id" INTEGER NOT NULL,
    "nombre" TEXT NOT NULL,
    "email" TEXT,
    "telefono" TEXT,
    "direccion" TEXT,
    "notas" TEXT,
    "creado_en" TIMESTAMP(3) NOT NULL DEFAULT CURRENT_TIMESTAMP,
    "actualizado_en" TIMESTAMP(3) NOT NULL,

    CONSTRAINT "cliente_pkey" PRIMARY KEY ("id")
);

-- CreateTable
CREATE TABLE "proveedor" (
    "id" SERIAL NOT NULL,
    "emprendimiento_id" INTEGER NOT NULL,
    "nombre" TEXT NOT NULL,
    "contacto" TEXT,
    "email" TEXT,
    "telefono" TEXT,
    "notas" TEXT,

    CONSTRAINT "proveedor_pkey" PRIMARY KEY ("id")
);

-- CreateTable
CREATE TABLE "medio_pago" (
    "id" SERIAL NOT NULL,
    "emprendimiento_id" INTEGER,
    "nombre" TEXT NOT NULL,
    "activo" BOOLEAN NOT NULL DEFAULT true,

    CONSTRAINT "medio_pago_pkey" PRIMARY KEY ("id")
);

-- CreateTable
CREATE TABLE "venta" (
    "id" SERIAL NOT NULL,
    "emprendimiento_id" INTEGER NOT NULL,
    "cliente_id" INTEGER,
    "medio_pago_id" INTEGER,
    "pedido_id" INTEGER,
    "estado" "EstadoVenta" NOT NULL DEFAULT 'PENDIENTE',
    "total" DECIMAL(10,2) NOT NULL,
    "descuento" DECIMAL(10,2) NOT NULL DEFAULT 0,
    "origen_externo" TEXT,
    "external_id" TEXT,
    "fecha" TIMESTAMP(3) NOT NULL DEFAULT CURRENT_TIMESTAMP,
    "notas" TEXT,
    "creado_en" TIMESTAMP(3) NOT NULL DEFAULT CURRENT_TIMESTAMP,

    CONSTRAINT "venta_pkey" PRIMARY KEY ("id")
);

-- CreateTable
CREATE TABLE "detalle_venta" (
    "id" SERIAL NOT NULL,
    "venta_id" INTEGER NOT NULL,
    "variante_id" INTEGER NOT NULL,
    "cantidad" INTEGER NOT NULL,
    "precio_unitario" DECIMAL(10,2) NOT NULL,

    CONSTRAINT "detalle_venta_pkey" PRIMARY KEY ("id")
);

-- CreateTable
CREATE TABLE "pedido" (
    "id" SERIAL NOT NULL,
    "emprendimiento_id" INTEGER NOT NULL,
    "cliente_id" INTEGER,
    "estado" "EstadoPedido" NOT NULL DEFAULT 'PENDIENTE',
    "fecha_estimada" TIMESTAMP(3),
    "notas" TEXT,
    "creado_en" TIMESTAMP(3) NOT NULL DEFAULT CURRENT_TIMESTAMP,
    "actualizado_en" TIMESTAMP(3) NOT NULL,

    CONSTRAINT "pedido_pkey" PRIMARY KEY ("id")
);

-- CreateTable
CREATE TABLE "detalle_pedido" (
    "id" SERIAL NOT NULL,
    "pedido_id" INTEGER NOT NULL,
    "variante_id" INTEGER NOT NULL,
    "cantidad" INTEGER NOT NULL,
    "precio_unitario" DECIMAL(10,2) NOT NULL,

    CONSTRAINT "detalle_pedido_pkey" PRIMARY KEY ("id")
);

-- CreateTable
CREATE TABLE "categoria_gasto" (
    "id" SERIAL NOT NULL,
    "emprendimiento_id" INTEGER NOT NULL,
    "nombre" TEXT NOT NULL,
    "descripcion" TEXT,

    CONSTRAINT "categoria_gasto_pkey" PRIMARY KEY ("id")
);

-- CreateTable
CREATE TABLE "gasto" (
    "id" SERIAL NOT NULL,
    "emprendimiento_id" INTEGER NOT NULL,
    "categoria_id" INTEGER,
    "proveedor_id" INTEGER,
    "gasto_recurrente_id" INTEGER,
    "descripcion" TEXT NOT NULL,
    "monto" DECIMAL(10,2) NOT NULL,
    "fecha" TIMESTAMP(3) NOT NULL DEFAULT CURRENT_TIMESTAMP,
    "comprobante" TEXT,
    "creado_en" TIMESTAMP(3) NOT NULL DEFAULT CURRENT_TIMESTAMP,

    CONSTRAINT "gasto_pkey" PRIMARY KEY ("id")
);

-- CreateTable
CREATE TABLE "gasto_recurrente" (
    "id" SERIAL NOT NULL,
    "emprendimiento_id" INTEGER NOT NULL,
    "categoria_id" INTEGER,
    "descripcion" TEXT NOT NULL,
    "monto_referencia" DECIMAL(10,2),
    "frecuencia" "FrecuenciaGasto" NOT NULL,
    "proxima_fecha" TIMESTAMP(3) NOT NULL,
    "activo" BOOLEAN NOT NULL DEFAULT true,
    "creado_en" TIMESTAMP(3) NOT NULL DEFAULT CURRENT_TIMESTAMP,

    CONSTRAINT "gasto_recurrente_pkey" PRIMARY KEY ("id")
);

-- CreateTable
CREATE TABLE "notificacion" (
    "id" SERIAL NOT NULL,
    "miembro_id" INTEGER NOT NULL,
    "tipo" "TipoNotificacion" NOT NULL,
    "titulo" TEXT NOT NULL,
    "cuerpo" TEXT NOT NULL,
    "leida" BOOLEAN NOT NULL DEFAULT false,
    "creado_en" TIMESTAMP(3) NOT NULL DEFAULT CURRENT_TIMESTAMP,

    CONSTRAINT "notificacion_pkey" PRIMARY KEY ("id")
);

-- CreateIndex
CREATE UNIQUE INDEX "usuario_auth0_id_key" ON "usuario"("auth0_id");

-- CreateIndex
CREATE UNIQUE INDEX "usuario_email_key" ON "usuario"("email");

-- CreateIndex
CREATE UNIQUE INDEX "modulo_nombre_key" ON "modulo"("nombre");

-- CreateIndex
CREATE UNIQUE INDEX "configuracion_modulo_emprendimiento_id_modulo_id_key" ON "configuracion_modulo"("emprendimiento_id", "modulo_id");

-- CreateIndex
CREATE UNIQUE INDEX "miembro_emprendimiento_usuario_id_emprendimiento_id_key" ON "miembro_emprendimiento"("usuario_id", "emprendimiento_id");

-- CreateIndex
CREATE UNIQUE INDEX "plan_nombre_key" ON "plan"("nombre");

-- CreateIndex
CREATE UNIQUE INDEX "suscripcion_emprendimiento_id_key" ON "suscripcion"("emprendimiento_id");

-- CreateIndex
CREATE UNIQUE INDEX "integracion_nombre_key" ON "integracion"("nombre");

-- CreateIndex
CREATE UNIQUE INDEX "plan_integracion_plan_id_integracion_id_key" ON "plan_integracion"("plan_id", "integracion_id");

-- CreateIndex
CREATE UNIQUE INDEX "emprendimiento_integracion_emprendimiento_id_integracion_id_key" ON "emprendimiento_integracion"("emprendimiento_id", "integracion_id");

-- CreateIndex
CREATE UNIQUE INDEX "categoria_producto_emprendimiento_id_nombre_key" ON "categoria_producto"("emprendimiento_id", "nombre");

-- CreateIndex
CREATE UNIQUE INDEX "venta_pedido_id_key" ON "venta"("pedido_id");

-- CreateIndex
CREATE UNIQUE INDEX "categoria_gasto_emprendimiento_id_nombre_key" ON "categoria_gasto"("emprendimiento_id", "nombre");

-- AddForeignKey
ALTER TABLE "configuracion_modulo" ADD CONSTRAINT "configuracion_modulo_emprendimiento_id_fkey" FOREIGN KEY ("emprendimiento_id") REFERENCES "emprendimiento"("id") ON DELETE RESTRICT ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "configuracion_modulo" ADD CONSTRAINT "configuracion_modulo_modulo_id_fkey" FOREIGN KEY ("modulo_id") REFERENCES "modulo"("id") ON DELETE RESTRICT ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "miembro_emprendimiento" ADD CONSTRAINT "miembro_emprendimiento_usuario_id_fkey" FOREIGN KEY ("usuario_id") REFERENCES "usuario"("id") ON DELETE RESTRICT ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "miembro_emprendimiento" ADD CONSTRAINT "miembro_emprendimiento_emprendimiento_id_fkey" FOREIGN KEY ("emprendimiento_id") REFERENCES "emprendimiento"("id") ON DELETE RESTRICT ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "suscripcion" ADD CONSTRAINT "suscripcion_emprendimiento_id_fkey" FOREIGN KEY ("emprendimiento_id") REFERENCES "emprendimiento"("id") ON DELETE RESTRICT ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "suscripcion" ADD CONSTRAINT "suscripcion_plan_id_fkey" FOREIGN KEY ("plan_id") REFERENCES "plan"("id") ON DELETE RESTRICT ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "plan_integracion" ADD CONSTRAINT "plan_integracion_plan_id_fkey" FOREIGN KEY ("plan_id") REFERENCES "plan"("id") ON DELETE RESTRICT ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "plan_integracion" ADD CONSTRAINT "plan_integracion_integracion_id_fkey" FOREIGN KEY ("integracion_id") REFERENCES "integracion"("id") ON DELETE RESTRICT ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "emprendimiento_integracion" ADD CONSTRAINT "emprendimiento_integracion_emprendimiento_id_fkey" FOREIGN KEY ("emprendimiento_id") REFERENCES "emprendimiento"("id") ON DELETE RESTRICT ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "emprendimiento_integracion" ADD CONSTRAINT "emprendimiento_integracion_integracion_id_fkey" FOREIGN KEY ("integracion_id") REFERENCES "integracion"("id") ON DELETE RESTRICT ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "categoria_producto" ADD CONSTRAINT "categoria_producto_emprendimiento_id_fkey" FOREIGN KEY ("emprendimiento_id") REFERENCES "emprendimiento"("id") ON DELETE RESTRICT ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "producto" ADD CONSTRAINT "producto_emprendimiento_id_fkey" FOREIGN KEY ("emprendimiento_id") REFERENCES "emprendimiento"("id") ON DELETE RESTRICT ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "producto" ADD CONSTRAINT "producto_categoria_id_fkey" FOREIGN KEY ("categoria_id") REFERENCES "categoria_producto"("id") ON DELETE SET NULL ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "variante_producto" ADD CONSTRAINT "variante_producto_producto_id_fkey" FOREIGN KEY ("producto_id") REFERENCES "producto"("id") ON DELETE RESTRICT ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "cliente" ADD CONSTRAINT "cliente_emprendimiento_id_fkey" FOREIGN KEY ("emprendimiento_id") REFERENCES "emprendimiento"("id") ON DELETE RESTRICT ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "proveedor" ADD CONSTRAINT "proveedor_emprendimiento_id_fkey" FOREIGN KEY ("emprendimiento_id") REFERENCES "emprendimiento"("id") ON DELETE RESTRICT ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "medio_pago" ADD CONSTRAINT "medio_pago_emprendimiento_id_fkey" FOREIGN KEY ("emprendimiento_id") REFERENCES "emprendimiento"("id") ON DELETE SET NULL ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "venta" ADD CONSTRAINT "venta_emprendimiento_id_fkey" FOREIGN KEY ("emprendimiento_id") REFERENCES "emprendimiento"("id") ON DELETE RESTRICT ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "venta" ADD CONSTRAINT "venta_cliente_id_fkey" FOREIGN KEY ("cliente_id") REFERENCES "cliente"("id") ON DELETE SET NULL ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "venta" ADD CONSTRAINT "venta_medio_pago_id_fkey" FOREIGN KEY ("medio_pago_id") REFERENCES "medio_pago"("id") ON DELETE SET NULL ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "venta" ADD CONSTRAINT "venta_pedido_id_fkey" FOREIGN KEY ("pedido_id") REFERENCES "pedido"("id") ON DELETE SET NULL ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "detalle_venta" ADD CONSTRAINT "detalle_venta_venta_id_fkey" FOREIGN KEY ("venta_id") REFERENCES "venta"("id") ON DELETE RESTRICT ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "detalle_venta" ADD CONSTRAINT "detalle_venta_variante_id_fkey" FOREIGN KEY ("variante_id") REFERENCES "variante_producto"("id") ON DELETE RESTRICT ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "pedido" ADD CONSTRAINT "pedido_emprendimiento_id_fkey" FOREIGN KEY ("emprendimiento_id") REFERENCES "emprendimiento"("id") ON DELETE RESTRICT ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "pedido" ADD CONSTRAINT "pedido_cliente_id_fkey" FOREIGN KEY ("cliente_id") REFERENCES "cliente"("id") ON DELETE SET NULL ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "detalle_pedido" ADD CONSTRAINT "detalle_pedido_pedido_id_fkey" FOREIGN KEY ("pedido_id") REFERENCES "pedido"("id") ON DELETE RESTRICT ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "detalle_pedido" ADD CONSTRAINT "detalle_pedido_variante_id_fkey" FOREIGN KEY ("variante_id") REFERENCES "variante_producto"("id") ON DELETE RESTRICT ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "categoria_gasto" ADD CONSTRAINT "categoria_gasto_emprendimiento_id_fkey" FOREIGN KEY ("emprendimiento_id") REFERENCES "emprendimiento"("id") ON DELETE RESTRICT ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "gasto" ADD CONSTRAINT "gasto_emprendimiento_id_fkey" FOREIGN KEY ("emprendimiento_id") REFERENCES "emprendimiento"("id") ON DELETE RESTRICT ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "gasto" ADD CONSTRAINT "gasto_categoria_id_fkey" FOREIGN KEY ("categoria_id") REFERENCES "categoria_gasto"("id") ON DELETE SET NULL ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "gasto" ADD CONSTRAINT "gasto_proveedor_id_fkey" FOREIGN KEY ("proveedor_id") REFERENCES "proveedor"("id") ON DELETE SET NULL ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "gasto" ADD CONSTRAINT "gasto_gasto_recurrente_id_fkey" FOREIGN KEY ("gasto_recurrente_id") REFERENCES "gasto_recurrente"("id") ON DELETE SET NULL ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "gasto_recurrente" ADD CONSTRAINT "gasto_recurrente_emprendimiento_id_fkey" FOREIGN KEY ("emprendimiento_id") REFERENCES "emprendimiento"("id") ON DELETE RESTRICT ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "gasto_recurrente" ADD CONSTRAINT "gasto_recurrente_categoria_id_fkey" FOREIGN KEY ("categoria_id") REFERENCES "categoria_gasto"("id") ON DELETE SET NULL ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "notificacion" ADD CONSTRAINT "notificacion_miembro_id_fkey" FOREIGN KEY ("miembro_id") REFERENCES "miembro_emprendimiento"("id") ON DELETE RESTRICT ON UPDATE CASCADE;
