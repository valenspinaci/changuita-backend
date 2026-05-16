-- CreateTable
CREATE TABLE `usuario` (
    `id` INTEGER NOT NULL AUTO_INCREMENT,
    `auth0_id` VARCHAR(191) NOT NULL,
    `email` VARCHAR(191) NOT NULL,
    `nombre` VARCHAR(191) NOT NULL,
    `avatar_url` VARCHAR(191) NULL,
    `creado_en` DATETIME(3) NOT NULL DEFAULT CURRENT_TIMESTAMP(3),
    `actualizado_en` DATETIME(3) NOT NULL,

    UNIQUE INDEX `usuario_auth0_id_key`(`auth0_id`),
    UNIQUE INDEX `usuario_email_key`(`email`),
    PRIMARY KEY (`id`)
) DEFAULT CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci;

-- CreateTable
CREATE TABLE `modulo` (
    `id` INTEGER NOT NULL AUTO_INCREMENT,
    `nombre` VARCHAR(191) NOT NULL,
    `descripcion` VARCHAR(191) NULL,
    `activo` BOOLEAN NOT NULL DEFAULT true,

    UNIQUE INDEX `modulo_nombre_key`(`nombre`),
    PRIMARY KEY (`id`)
) DEFAULT CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci;

-- CreateTable
CREATE TABLE `configuracion_modulo` (
    `id` INTEGER NOT NULL AUTO_INCREMENT,
    `emprendimiento_id` INTEGER NOT NULL,
    `modulo_id` INTEGER NOT NULL,
    `habilitado` BOOLEAN NOT NULL DEFAULT true,
    `creado_en` DATETIME(3) NOT NULL DEFAULT CURRENT_TIMESTAMP(3),

    UNIQUE INDEX `configuracion_modulo_emprendimiento_id_modulo_id_key`(`emprendimiento_id`, `modulo_id`),
    PRIMARY KEY (`id`)
) DEFAULT CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci;

-- CreateTable
CREATE TABLE `emprendimiento` (
    `id` INTEGER NOT NULL AUTO_INCREMENT,
    `nombre` VARCHAR(191) NOT NULL,
    `descripcion` VARCHAR(191) NULL,
    `logo_url` VARCHAR(191) NULL,
    `creado_en` DATETIME(3) NOT NULL DEFAULT CURRENT_TIMESTAMP(3),
    `actualizado_en` DATETIME(3) NOT NULL,

    PRIMARY KEY (`id`)
) DEFAULT CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci;

-- CreateTable
CREATE TABLE `miembro_emprendimiento` (
    `id` INTEGER NOT NULL AUTO_INCREMENT,
    `usuario_id` INTEGER NOT NULL,
    `emprendimiento_id` INTEGER NOT NULL,
    `rol` ENUM('OWNER', 'ADMIN', 'OPERADOR', 'VISUALIZADOR') NOT NULL DEFAULT 'OPERADOR',
    `creado_en` DATETIME(3) NOT NULL DEFAULT CURRENT_TIMESTAMP(3),

    UNIQUE INDEX `miembro_emprendimiento_usuario_id_emprendimiento_id_key`(`usuario_id`, `emprendimiento_id`),
    PRIMARY KEY (`id`)
) DEFAULT CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci;

-- CreateTable
CREATE TABLE `plan` (
    `id` INTEGER NOT NULL AUTO_INCREMENT,
    `nombre` VARCHAR(191) NOT NULL,
    `descripcion` VARCHAR(191) NULL,
    `precio` DECIMAL(10, 2) NOT NULL,
    `activo` BOOLEAN NOT NULL DEFAULT true,

    UNIQUE INDEX `plan_nombre_key`(`nombre`),
    PRIMARY KEY (`id`)
) DEFAULT CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci;

-- CreateTable
CREATE TABLE `suscripcion` (
    `id` INTEGER NOT NULL AUTO_INCREMENT,
    `emprendimiento_id` INTEGER NOT NULL,
    `plan_id` INTEGER NOT NULL,
    `estado` ENUM('ACTIVA', 'VENCIDA', 'CANCELADA', 'PRUEBA') NOT NULL DEFAULT 'PRUEBA',
    `fecha_inicio` DATETIME(3) NOT NULL,
    `fecha_fin` DATETIME(3) NULL,
    `creado_en` DATETIME(3) NOT NULL DEFAULT CURRENT_TIMESTAMP(3),

    UNIQUE INDEX `suscripcion_emprendimiento_id_key`(`emprendimiento_id`),
    PRIMARY KEY (`id`)
) DEFAULT CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci;

-- CreateTable
CREATE TABLE `integracion` (
    `id` INTEGER NOT NULL AUTO_INCREMENT,
    `nombre` VARCHAR(191) NOT NULL,
    `descripcion` VARCHAR(191) NULL,
    `logo_url` VARCHAR(191) NULL,
    `activa` BOOLEAN NOT NULL DEFAULT true,

    UNIQUE INDEX `integracion_nombre_key`(`nombre`),
    PRIMARY KEY (`id`)
) DEFAULT CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci;

-- CreateTable
CREATE TABLE `plan_integracion` (
    `id` INTEGER NOT NULL AUTO_INCREMENT,
    `plan_id` INTEGER NOT NULL,
    `integracion_id` INTEGER NOT NULL,

    UNIQUE INDEX `plan_integracion_plan_id_integracion_id_key`(`plan_id`, `integracion_id`),
    PRIMARY KEY (`id`)
) DEFAULT CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci;

-- CreateTable
CREATE TABLE `emprendimiento_integracion` (
    `id` INTEGER NOT NULL AUTO_INCREMENT,
    `emprendimiento_id` INTEGER NOT NULL,
    `integracion_id` INTEGER NOT NULL,
    `access_token` VARCHAR(191) NULL,
    `refresh_token` VARCHAR(191) NULL,
    `external_shop_id` VARCHAR(191) NULL,
    `activa` BOOLEAN NOT NULL DEFAULT true,
    `creado_en` DATETIME(3) NOT NULL DEFAULT CURRENT_TIMESTAMP(3),

    UNIQUE INDEX `emprendimiento_integracion_emprendimiento_id_integracion_id_key`(`emprendimiento_id`, `integracion_id`),
    PRIMARY KEY (`id`)
) DEFAULT CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci;

-- CreateTable
CREATE TABLE `categoria_producto` (
    `id` INTEGER NOT NULL AUTO_INCREMENT,
    `emprendimiento_id` INTEGER NOT NULL,
    `nombre` VARCHAR(191) NOT NULL,
    `descripcion` VARCHAR(191) NULL,

    UNIQUE INDEX `categoria_producto_emprendimiento_id_nombre_key`(`emprendimiento_id`, `nombre`),
    PRIMARY KEY (`id`)
) DEFAULT CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci;

-- CreateTable
CREATE TABLE `producto` (
    `id` INTEGER NOT NULL AUTO_INCREMENT,
    `emprendimiento_id` INTEGER NOT NULL,
    `categoria_id` INTEGER NULL,
    `nombre` VARCHAR(191) NOT NULL,
    `descripcion` VARCHAR(191) NULL,
    `precio` DECIMAL(10, 2) NOT NULL,
    `stock_total` INTEGER NOT NULL DEFAULT 0,
    `stock_minimo` INTEGER NOT NULL DEFAULT 0,
    `imagen_url` VARCHAR(191) NULL,
    `activo` BOOLEAN NOT NULL DEFAULT true,
    `creado_en` DATETIME(3) NOT NULL DEFAULT CURRENT_TIMESTAMP(3),
    `actualizado_en` DATETIME(3) NOT NULL,

    PRIMARY KEY (`id`)
) DEFAULT CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci;

-- CreateTable
CREATE TABLE `variante_producto` (
    `id` INTEGER NOT NULL AUTO_INCREMENT,
    `producto_id` INTEGER NOT NULL,
    `nombre` VARCHAR(191) NOT NULL,
    `sku` VARCHAR(191) NULL,
    `precio` DECIMAL(10, 2) NULL,
    `stock` INTEGER NOT NULL DEFAULT 0,
    `activo` BOOLEAN NOT NULL DEFAULT true,

    PRIMARY KEY (`id`)
) DEFAULT CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci;

-- CreateTable
CREATE TABLE `cliente` (
    `id` INTEGER NOT NULL AUTO_INCREMENT,
    `emprendimiento_id` INTEGER NOT NULL,
    `nombre` VARCHAR(191) NOT NULL,
    `email` VARCHAR(191) NULL,
    `telefono` VARCHAR(191) NULL,
    `direccion` VARCHAR(191) NULL,
    `notas` VARCHAR(191) NULL,
    `creado_en` DATETIME(3) NOT NULL DEFAULT CURRENT_TIMESTAMP(3),
    `actualizado_en` DATETIME(3) NOT NULL,

    PRIMARY KEY (`id`)
) DEFAULT CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci;

-- CreateTable
CREATE TABLE `proveedor` (
    `id` INTEGER NOT NULL AUTO_INCREMENT,
    `emprendimiento_id` INTEGER NOT NULL,
    `nombre` VARCHAR(191) NOT NULL,
    `contacto` VARCHAR(191) NULL,
    `email` VARCHAR(191) NULL,
    `telefono` VARCHAR(191) NULL,
    `notas` VARCHAR(191) NULL,

    PRIMARY KEY (`id`)
) DEFAULT CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci;

-- CreateTable
CREATE TABLE `medio_pago` (
    `id` INTEGER NOT NULL AUTO_INCREMENT,
    `emprendimiento_id` INTEGER NULL,
    `nombre` VARCHAR(191) NOT NULL,
    `activo` BOOLEAN NOT NULL DEFAULT true,

    PRIMARY KEY (`id`)
) DEFAULT CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci;

-- CreateTable
CREATE TABLE `venta` (
    `id` INTEGER NOT NULL AUTO_INCREMENT,
    `emprendimiento_id` INTEGER NOT NULL,
    `cliente_id` INTEGER NULL,
    `medio_pago_id` INTEGER NULL,
    `pedido_id` INTEGER NULL,
    `estado` ENUM('PENDIENTE', 'COBRADA', 'CANCELADA', 'DEVUELTA') NOT NULL DEFAULT 'PENDIENTE',
    `total` DECIMAL(10, 2) NOT NULL,
    `descuento` DECIMAL(10, 2) NOT NULL DEFAULT 0,
    `origen_externo` VARCHAR(191) NULL,
    `external_id` VARCHAR(191) NULL,
    `fecha` DATETIME(3) NOT NULL DEFAULT CURRENT_TIMESTAMP(3),
    `notas` VARCHAR(191) NULL,
    `creado_en` DATETIME(3) NOT NULL DEFAULT CURRENT_TIMESTAMP(3),

    UNIQUE INDEX `venta_pedido_id_key`(`pedido_id`),
    PRIMARY KEY (`id`)
) DEFAULT CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci;

-- CreateTable
CREATE TABLE `detalle_venta` (
    `id` INTEGER NOT NULL AUTO_INCREMENT,
    `venta_id` INTEGER NOT NULL,
    `variante_id` INTEGER NOT NULL,
    `cantidad` INTEGER NOT NULL,
    `precio_unitario` DECIMAL(10, 2) NOT NULL,

    PRIMARY KEY (`id`)
) DEFAULT CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci;

-- CreateTable
CREATE TABLE `pedido` (
    `id` INTEGER NOT NULL AUTO_INCREMENT,
    `emprendimiento_id` INTEGER NOT NULL,
    `cliente_id` INTEGER NULL,
    `estado` ENUM('PENDIENTE', 'ACTIVO', 'ENTREGADO', 'CANCELADO') NOT NULL DEFAULT 'PENDIENTE',
    `fecha_estimada` DATETIME(3) NULL,
    `notas` VARCHAR(191) NULL,
    `creado_en` DATETIME(3) NOT NULL DEFAULT CURRENT_TIMESTAMP(3),
    `actualizado_en` DATETIME(3) NOT NULL,

    PRIMARY KEY (`id`)
) DEFAULT CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci;

-- CreateTable
CREATE TABLE `detalle_pedido` (
    `id` INTEGER NOT NULL AUTO_INCREMENT,
    `pedido_id` INTEGER NOT NULL,
    `variante_id` INTEGER NOT NULL,
    `cantidad` INTEGER NOT NULL,
    `precio_unitario` DECIMAL(10, 2) NOT NULL,

    PRIMARY KEY (`id`)
) DEFAULT CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci;

-- CreateTable
CREATE TABLE `categoria_gasto` (
    `id` INTEGER NOT NULL AUTO_INCREMENT,
    `emprendimiento_id` INTEGER NOT NULL,
    `nombre` VARCHAR(191) NOT NULL,
    `descripcion` VARCHAR(191) NULL,

    UNIQUE INDEX `categoria_gasto_emprendimiento_id_nombre_key`(`emprendimiento_id`, `nombre`),
    PRIMARY KEY (`id`)
) DEFAULT CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci;

-- CreateTable
CREATE TABLE `gasto` (
    `id` INTEGER NOT NULL AUTO_INCREMENT,
    `emprendimiento_id` INTEGER NOT NULL,
    `categoria_id` INTEGER NULL,
    `proveedor_id` INTEGER NULL,
    `gasto_recurrente_id` INTEGER NULL,
    `descripcion` VARCHAR(191) NOT NULL,
    `monto` DECIMAL(10, 2) NOT NULL,
    `fecha` DATETIME(3) NOT NULL DEFAULT CURRENT_TIMESTAMP(3),
    `comprobante` VARCHAR(191) NULL,
    `creado_en` DATETIME(3) NOT NULL DEFAULT CURRENT_TIMESTAMP(3),

    PRIMARY KEY (`id`)
) DEFAULT CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci;

-- CreateTable
CREATE TABLE `gasto_recurrente` (
    `id` INTEGER NOT NULL AUTO_INCREMENT,
    `emprendimiento_id` INTEGER NOT NULL,
    `categoria_id` INTEGER NULL,
    `descripcion` VARCHAR(191) NOT NULL,
    `monto_referencia` DECIMAL(10, 2) NULL,
    `frecuencia` ENUM('DIARIO', 'SEMANAL', 'MENSUAL', 'TRIMESTRAL', 'ANUAL') NOT NULL,
    `proxima_fecha` DATETIME(3) NOT NULL,
    `activo` BOOLEAN NOT NULL DEFAULT true,
    `creado_en` DATETIME(3) NOT NULL DEFAULT CURRENT_TIMESTAMP(3),

    PRIMARY KEY (`id`)
) DEFAULT CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci;

-- CreateTable
CREATE TABLE `notificacion` (
    `id` INTEGER NOT NULL AUTO_INCREMENT,
    `miembro_id` INTEGER NOT NULL,
    `tipo` ENUM('STOCK_MINIMO', 'PAGO_PENDIENTE', 'PEDIDO_NUEVO', 'VENTA_REGISTRADA', 'SUSCRIPCION_POR_VENCER', 'GASTO_RECURRENTE', 'SISTEMA') NOT NULL,
    `titulo` VARCHAR(191) NOT NULL,
    `cuerpo` VARCHAR(191) NOT NULL,
    `leida` BOOLEAN NOT NULL DEFAULT false,
    `creado_en` DATETIME(3) NOT NULL DEFAULT CURRENT_TIMESTAMP(3),

    PRIMARY KEY (`id`)
) DEFAULT CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci;

-- AddForeignKey
ALTER TABLE `configuracion_modulo` ADD CONSTRAINT `configuracion_modulo_emprendimiento_id_fkey` FOREIGN KEY (`emprendimiento_id`) REFERENCES `emprendimiento`(`id`) ON DELETE RESTRICT ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE `configuracion_modulo` ADD CONSTRAINT `configuracion_modulo_modulo_id_fkey` FOREIGN KEY (`modulo_id`) REFERENCES `modulo`(`id`) ON DELETE RESTRICT ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE `miembro_emprendimiento` ADD CONSTRAINT `miembro_emprendimiento_usuario_id_fkey` FOREIGN KEY (`usuario_id`) REFERENCES `usuario`(`id`) ON DELETE RESTRICT ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE `miembro_emprendimiento` ADD CONSTRAINT `miembro_emprendimiento_emprendimiento_id_fkey` FOREIGN KEY (`emprendimiento_id`) REFERENCES `emprendimiento`(`id`) ON DELETE RESTRICT ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE `suscripcion` ADD CONSTRAINT `suscripcion_emprendimiento_id_fkey` FOREIGN KEY (`emprendimiento_id`) REFERENCES `emprendimiento`(`id`) ON DELETE RESTRICT ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE `suscripcion` ADD CONSTRAINT `suscripcion_plan_id_fkey` FOREIGN KEY (`plan_id`) REFERENCES `plan`(`id`) ON DELETE RESTRICT ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE `plan_integracion` ADD CONSTRAINT `plan_integracion_plan_id_fkey` FOREIGN KEY (`plan_id`) REFERENCES `plan`(`id`) ON DELETE RESTRICT ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE `plan_integracion` ADD CONSTRAINT `plan_integracion_integracion_id_fkey` FOREIGN KEY (`integracion_id`) REFERENCES `integracion`(`id`) ON DELETE RESTRICT ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE `emprendimiento_integracion` ADD CONSTRAINT `emprendimiento_integracion_emprendimiento_id_fkey` FOREIGN KEY (`emprendimiento_id`) REFERENCES `emprendimiento`(`id`) ON DELETE RESTRICT ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE `emprendimiento_integracion` ADD CONSTRAINT `emprendimiento_integracion_integracion_id_fkey` FOREIGN KEY (`integracion_id`) REFERENCES `integracion`(`id`) ON DELETE RESTRICT ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE `categoria_producto` ADD CONSTRAINT `categoria_producto_emprendimiento_id_fkey` FOREIGN KEY (`emprendimiento_id`) REFERENCES `emprendimiento`(`id`) ON DELETE RESTRICT ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE `producto` ADD CONSTRAINT `producto_emprendimiento_id_fkey` FOREIGN KEY (`emprendimiento_id`) REFERENCES `emprendimiento`(`id`) ON DELETE RESTRICT ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE `producto` ADD CONSTRAINT `producto_categoria_id_fkey` FOREIGN KEY (`categoria_id`) REFERENCES `categoria_producto`(`id`) ON DELETE SET NULL ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE `variante_producto` ADD CONSTRAINT `variante_producto_producto_id_fkey` FOREIGN KEY (`producto_id`) REFERENCES `producto`(`id`) ON DELETE RESTRICT ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE `cliente` ADD CONSTRAINT `cliente_emprendimiento_id_fkey` FOREIGN KEY (`emprendimiento_id`) REFERENCES `emprendimiento`(`id`) ON DELETE RESTRICT ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE `proveedor` ADD CONSTRAINT `proveedor_emprendimiento_id_fkey` FOREIGN KEY (`emprendimiento_id`) REFERENCES `emprendimiento`(`id`) ON DELETE RESTRICT ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE `medio_pago` ADD CONSTRAINT `medio_pago_emprendimiento_id_fkey` FOREIGN KEY (`emprendimiento_id`) REFERENCES `emprendimiento`(`id`) ON DELETE SET NULL ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE `venta` ADD CONSTRAINT `venta_emprendimiento_id_fkey` FOREIGN KEY (`emprendimiento_id`) REFERENCES `emprendimiento`(`id`) ON DELETE RESTRICT ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE `venta` ADD CONSTRAINT `venta_cliente_id_fkey` FOREIGN KEY (`cliente_id`) REFERENCES `cliente`(`id`) ON DELETE SET NULL ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE `venta` ADD CONSTRAINT `venta_medio_pago_id_fkey` FOREIGN KEY (`medio_pago_id`) REFERENCES `medio_pago`(`id`) ON DELETE SET NULL ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE `venta` ADD CONSTRAINT `venta_pedido_id_fkey` FOREIGN KEY (`pedido_id`) REFERENCES `pedido`(`id`) ON DELETE SET NULL ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE `detalle_venta` ADD CONSTRAINT `detalle_venta_venta_id_fkey` FOREIGN KEY (`venta_id`) REFERENCES `venta`(`id`) ON DELETE RESTRICT ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE `detalle_venta` ADD CONSTRAINT `detalle_venta_variante_id_fkey` FOREIGN KEY (`variante_id`) REFERENCES `variante_producto`(`id`) ON DELETE RESTRICT ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE `pedido` ADD CONSTRAINT `pedido_emprendimiento_id_fkey` FOREIGN KEY (`emprendimiento_id`) REFERENCES `emprendimiento`(`id`) ON DELETE RESTRICT ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE `pedido` ADD CONSTRAINT `pedido_cliente_id_fkey` FOREIGN KEY (`cliente_id`) REFERENCES `cliente`(`id`) ON DELETE SET NULL ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE `detalle_pedido` ADD CONSTRAINT `detalle_pedido_pedido_id_fkey` FOREIGN KEY (`pedido_id`) REFERENCES `pedido`(`id`) ON DELETE RESTRICT ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE `detalle_pedido` ADD CONSTRAINT `detalle_pedido_variante_id_fkey` FOREIGN KEY (`variante_id`) REFERENCES `variante_producto`(`id`) ON DELETE RESTRICT ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE `categoria_gasto` ADD CONSTRAINT `categoria_gasto_emprendimiento_id_fkey` FOREIGN KEY (`emprendimiento_id`) REFERENCES `emprendimiento`(`id`) ON DELETE RESTRICT ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE `gasto` ADD CONSTRAINT `gasto_emprendimiento_id_fkey` FOREIGN KEY (`emprendimiento_id`) REFERENCES `emprendimiento`(`id`) ON DELETE RESTRICT ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE `gasto` ADD CONSTRAINT `gasto_categoria_id_fkey` FOREIGN KEY (`categoria_id`) REFERENCES `categoria_gasto`(`id`) ON DELETE SET NULL ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE `gasto` ADD CONSTRAINT `gasto_proveedor_id_fkey` FOREIGN KEY (`proveedor_id`) REFERENCES `proveedor`(`id`) ON DELETE SET NULL ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE `gasto` ADD CONSTRAINT `gasto_gasto_recurrente_id_fkey` FOREIGN KEY (`gasto_recurrente_id`) REFERENCES `gasto_recurrente`(`id`) ON DELETE SET NULL ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE `gasto_recurrente` ADD CONSTRAINT `gasto_recurrente_emprendimiento_id_fkey` FOREIGN KEY (`emprendimiento_id`) REFERENCES `emprendimiento`(`id`) ON DELETE RESTRICT ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE `gasto_recurrente` ADD CONSTRAINT `gasto_recurrente_categoria_id_fkey` FOREIGN KEY (`categoria_id`) REFERENCES `categoria_gasto`(`id`) ON DELETE SET NULL ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE `notificacion` ADD CONSTRAINT `notificacion_miembro_id_fkey` FOREIGN KEY (`miembro_id`) REFERENCES `miembro_emprendimiento`(`id`) ON DELETE RESTRICT ON UPDATE CASCADE;
