-- MySQL Workbench Forward Engineering

SET @OLD_UNIQUE_CHECKS=@@UNIQUE_CHECKS, UNIQUE_CHECKS=0;
SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0;
SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION';

-- -----------------------------------------------------
-- Schema mydb
-- -----------------------------------------------------
-- -----------------------------------------------------
-- Schema occident
-- -----------------------------------------------------

-- -----------------------------------------------------
-- Schema occident
-- -----------------------------------------------------
CREATE SCHEMA IF NOT EXISTS `occident` DEFAULT CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci ;
USE `occident` ;

-- -----------------------------------------------------
-- Table `occident`.`occ_categoriasclientesprovedor`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `occident`.`occ_categoriasclientesprovedor` (
  `CC_idCategoriasCP` INT NOT NULL AUTO_INCREMENT COMMENT 'Identificador de la tabla.',
  `CC_codigo` VARCHAR(45) NOT NULL COMMENT 'Identificador de las categorias de clientes y provedores.',
  `CC_nombreCategoria` VARCHAR(50) NOT NULL COMMENT 'Nombre de la categoria del cliente o el provedor ',
  `CC_tipoCategoria` VARCHAR(2) NOT NULL COMMENT 'Identificador que determina si es un cliente o un proveedor\\nCC = categoría cliente\\nCP = categoría proveedor\\n',
  `CC_descripcion` VARCHAR(100) NULL DEFAULT NULL COMMENT 'Descripcion de la categoria.',
  `CC_estado` VARCHAR(1) NOT NULL COMMENT 'Muestra el estado de la categoría\\nA = Activo\\nI = Inactivo',
  PRIMARY KEY (`CC_idCategoriasCP`))
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8mb4
COLLATE = utf8mb4_0900_ai_ci
COMMENT = 'Tabla de la información necesaria para las categorías de los clientes o los proveedores.';


-- -----------------------------------------------------
-- Table `occident`.`occ_tipocedula`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `occident`.`occ_tipocedula` (
  `TC_idTipoCedula` INT NOT NULL AUTO_INCREMENT COMMENT 'Identificador de la tabla.',
  `TC_codigo` VARCHAR(45) NOT NULL COMMENT 'Identificador del tipo de cedula.',
  `TC_descipcion` VARCHAR(50) NOT NULL COMMENT 'Descripcion de la cedula',
  `TC_formato` VARCHAR(50) NOT NULL COMMENT 'Formato del tipo de cedula a registrar.',
  `TC_estado` VARCHAR(1) NOT NULL COMMENT 'Muestra el estado del tipo de cedula.\\nA = Activo\\nI = Inactivo',
  PRIMARY KEY (`TC_idTipoCedula`))
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8mb4
COLLATE = utf8mb4_0900_ai_ci
COMMENT = 'Tabla para el registro de los diferentes tipos de cedulas.';


-- -----------------------------------------------------
-- Table `occident`.`occ_tiposcontactos`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `occident`.`occ_tiposcontactos` (
  `TC_idTiposContactos` INT NOT NULL AUTO_INCREMENT COMMENT 'Identificador de la tabla.',
  `TC_codigo` VARCHAR(45) NOT NULL COMMENT 'Identificador del tipo de contacto.',
  `TC_descripcion` VARCHAR(100) NOT NULL COMMENT 'Descripción del tipo de contacto.\\\\n',
  `TC_direccionFisica` VARCHAR(500) NULL DEFAULT NULL COMMENT 'Dirección física del contacto.',
  `TC_estado` VARCHAR(1) NOT NULL COMMENT 'Muestra el estado del tipo de contacto.\\nA = Activo\\nI = Inactivo',
  PRIMARY KEY (`TC_idTiposContactos`))
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8mb4
COLLATE = utf8mb4_0900_ai_ci
COMMENT = 'Tabla para registrar los diferentes tipos de contactos de la sucursales.';


-- -----------------------------------------------------
-- Table `occident`.`occ_clientes`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `occident`.`occ_clientes` (
  `C_idClientes` INT NOT NULL AUTO_INCREMENT COMMENT 'Identificador de la tabla.',
  `C_tipoCedula` INT NOT NULL COMMENT 'Identificador del tipo de cedula del cliente.',
  `C_categoriaCliente` INT NOT NULL COMMENT 'Identificador de la categoria del cliente.',
  `C_tiposContacto` INT NOT NULL COMMENT 'Identificador del tipo de contacto del cliente.',
  `C_cedula` INT NOT NULL COMMENT 'Cedula del cliente',
  `C_nombre` VARCHAR(100) NOT NULL COMMENT 'Nombre del cliente.',
  `C_fechaNacimiento` DATETIME NOT NULL COMMENT 'Fecha de nacimiento del cliente.',
  `C_limiteCredito` FLOAT NULL DEFAULT NULL COMMENT 'Límite del crédito que posee el cliente.',
  `C_montoCredito` FLOAT NULL DEFAULT NULL COMMENT 'Monto del credito del cliente.',
  `C_saldo` FLOAT NULL DEFAULT NULL COMMENT 'Saldo actual del cliente.',
  `C_estado` VARCHAR(1) NOT NULL COMMENT 'Muestra el estado de los clientes.\\nA = Activo\\nI = Inactivo',
  PRIMARY KEY (`C_idClientes`),
  INDEX `FK_tipoCedula_idx` (`C_tipoCedula` ASC) VISIBLE,
  INDEX `FK_CategoriaCliente_idx` (`C_categoriaCliente` ASC) VISIBLE,
  INDEX `fk_occ_clientes_occ_tiposContactos1_idx` (`C_tiposContacto` ASC) VISIBLE,
  CONSTRAINT `FK_C_CategoriaCliente`
    FOREIGN KEY (`C_categoriaCliente`)
    REFERENCES `occident`.`occ_categoriasclientesprovedor` (`CC_idCategoriasCP`),
  CONSTRAINT `FK_C_TipoCedula`
    FOREIGN KEY (`C_tipoCedula`)
    REFERENCES `occident`.`occ_tipocedula` (`TC_idTipoCedula`),
  CONSTRAINT `FK_C_tiposContacto`
    FOREIGN KEY (`C_tiposContacto`)
    REFERENCES `occident`.`occ_tiposcontactos` (`TC_idTiposContactos`))
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8mb4
COLLATE = utf8mb4_0900_ai_ci
COMMENT = 'Tabla de registro de la informacion de los clientes.';


-- -----------------------------------------------------
-- Table `occident`.`occ_monedas`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `occident`.`occ_monedas` (
  `M_idMonedas` INT NOT NULL AUTO_INCREMENT COMMENT 'Identificador de la tabla.',
  `M_codigo` VARCHAR(45) NOT NULL COMMENT 'Identificador de la moneda.',
  `M_descripcion` VARCHAR(50) NOT NULL COMMENT 'Descripcion de moneda.',
  `M_abreviatura` VARCHAR(3) NOT NULL COMMENT 'Abreviaturas de la monedas que se registran.',
  `M_estado` VARCHAR(1) NOT NULL COMMENT 'Muestra el estado de la moneda.\\nA = Activo\\nI = Inactivo',
  PRIMARY KEY (`M_idMonedas`))
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8mb4
COLLATE = utf8mb4_0900_ai_ci
COMMENT = 'Tabla encargada de registrar los tipos de monedas que admite la empresa para las diferentes transacciones.';


-- -----------------------------------------------------
-- Table `occident`.`occ_empresa`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `occident`.`occ_empresa` (
  `E_idEmpresa` INT NOT NULL AUTO_INCREMENT COMMENT 'Identificador de la tabla.',
  `E_tiposContactos` INT NOT NULL COMMENT 'Identificador del tipo de contacto.',
  `E_NombreOrazonSocial` VARCHAR(100) NOT NULL COMMENT 'Nombre de la empresa o razón social.',
  `E_cedulaJuridica` INT NOT NULL COMMENT 'Cedula jurídica de la empresa.',
  `E_tipoCedula` INT NOT NULL COMMENT 'Identificador del tipo de cedula registrado.',
  `E_fechaCreacion` DATETIME NOT NULL COMMENT 'Fecha de la empresa.',
  `E_nombreEncargado` VARCHAR(100) NOT NULL COMMENT 'Es el nombre del encargado de la empresa o el dueño básicamente el que este cargo.',
  `E_estado` VARCHAR(1) NOT NULL COMMENT 'Muestra el estado de la empresa.\\nA = Activo\\nI = Inactivo',
  PRIMARY KEY (`E_idEmpresa`),
  INDEX `fk_occ_empresa_occ_tiposContactos1_idx` (`E_tiposContactos` ASC) VISIBLE,
  INDEX `FK_TipoCedula_idx` (`E_tipoCedula` ASC) VISIBLE,
  CONSTRAINT `FK_E_TipoCedula`
    FOREIGN KEY (`E_tipoCedula`)
    REFERENCES `occident`.`occ_tipocedula` (`TC_idTipoCedula`),
  CONSTRAINT `FK_E_TipoContactos`
    FOREIGN KEY (`E_tiposContactos`)
    REFERENCES `occident`.`occ_tiposcontactos` (`TC_idTiposContactos`))
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8mb4
COLLATE = utf8mb4_0900_ai_ci
COMMENT = 'Toda la información necesaria de la empresa.';


-- -----------------------------------------------------
-- Table `occident`.`occ_sucursales`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `occident`.`occ_sucursales` (
  `S_idSucursales` INT NOT NULL AUTO_INCREMENT COMMENT 'Identificador de la tabla.',
  `S_idEmpresa` INT NOT NULL COMMENT 'Identificador de la empresa a la que pertenece la sucursal.',
  `S_idContactos` INT NOT NULL COMMENT 'Identificador del contacto de la sucursal.',
  `S_codigo` VARCHAR(50) NOT NULL COMMENT 'Identificador de la sucursal.',
  `S_nombre` VARCHAR(100) NOT NULL COMMENT 'Nombre destinado para la sucursal.',
  `S_nombreEncargado` VARCHAR(100) NOT NULL COMMENT 'Nombre de la persona encarga de la sucursal.',
  `S_estado` VARCHAR(1) NOT NULL COMMENT 'Muestra el estado de la sucursal.\\nA = Activo\\nI = Inactivo',
  PRIMARY KEY (`S_idSucursales`),
  INDEX `FK_Empresa_idx` (`S_idEmpresa` ASC) VISIBLE,
  INDEX `FK_contactos_idx` (`S_idContactos` ASC) VISIBLE,
  CONSTRAINT `FK_S_contactos`
    FOREIGN KEY (`S_idContactos`)
    REFERENCES `occident`.`occ_tiposcontactos` (`TC_idTiposContactos`),
  CONSTRAINT `FK_S_empresa`
    FOREIGN KEY (`S_idEmpresa`)
    REFERENCES `occident`.`occ_empresa` (`E_idEmpresa`))
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8mb4
COLLATE = utf8mb4_0900_ai_ci
COMMENT = 'Tabla que registra las sucursales pertenecientes a una empreza.';


-- -----------------------------------------------------
-- Table `occident`.`occ_cajas`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `occident`.`occ_cajas` (
  `C_idCajas` INT NOT NULL AUTO_INCREMENT COMMENT 'Identificador de la tabla.',
  `C_sucursal` INT NOT NULL COMMENT 'Identificador de la sucursal a la que pertenece la caja.',
  `C_moneda` INT NOT NULL COMMENT 'Identificador de la moneda que acepta esta caja.',
  `C_codigo` VARCHAR(45) NOT NULL COMMENT 'Identificador de las cajas.',
  `C_fecha` DATETIME NOT NULL COMMENT 'Fecha en la que se agrego la caja.',
  `C_estado` VARCHAR(2) NOT NULL COMMENT 'Muestra el estado de la caja.\\nA = Activo\\nI = Inactivo',
  PRIMARY KEY (`C_idCajas`),
  INDEX `FK_sucursal_idx` (`C_sucursal` ASC) VISIBLE,
  INDEX `FK_moneda_idx` (`C_moneda` ASC) VISIBLE,
  CONSTRAINT `FK_C_moneda`
    FOREIGN KEY (`C_moneda`)
    REFERENCES `occident`.`occ_monedas` (`M_idMonedas`),
  CONSTRAINT `FK_C_sucursal`
    FOREIGN KEY (`C_sucursal`)
    REFERENCES `occident`.`occ_sucursales` (`S_idSucursales`))
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8mb4
COLLATE = utf8mb4_0900_ai_ci
COMMENT = 'Tabla de las cajas donde se realizan las transacciones (factura, entre otras) de una sucursal.';


-- -----------------------------------------------------
-- Table `occident`.`occ_impuestos`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `occident`.`occ_impuestos` (
  `I_idImpuesto` INT NOT NULL AUTO_INCREMENT COMMENT 'Identificador de la tabla.',
  `I_codigo` VARCHAR(45) NOT NULL COMMENT 'Identificador del impuesto',
  `I_impuesto` FLOAT NOT NULL COMMENT 'Impuesto de Venta (IV)',
  `I_fecha` DATETIME NOT NULL COMMENT 'Fecha del registro del impuesto.',
  `I_estado` VARCHAR(1) NOT NULL COMMENT 'Muestra el estado de impuesto.\\\\nA = Activo\\\\nI = Inactivo\\\\n',
  PRIMARY KEY (`I_idImpuesto`))
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8mb4
COLLATE = utf8mb4_0900_ai_ci
COMMENT = 'Tabla encargada de guardar los impuestos del pais(IVA).';


-- -----------------------------------------------------
-- Table `occident`.`occ_bodegas`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `occident`.`occ_bodegas` (
  `B_idBodegas` INT NOT NULL AUTO_INCREMENT COMMENT 'Identificador de la tabla.',
  `B_idSucursal` INT NOT NULL COMMENT 'Identificado de la sucursal a la que pertenece la bodega.',
  `B_codigo` VARCHAR(50) NOT NULL COMMENT 'Identificador de las bodegas.',
  `B_descripcion` VARCHAR(100) NOT NULL COMMENT 'Descripcion de la bodega.',
  `B_ubicacion` VARCHAR(1000) NOT NULL COMMENT 'Ubicacion donde esta la bodega.',
  `B_estado` VARCHAR(1) NOT NULL COMMENT 'Muestra el estado de la bodega.\\nA = Activo\\nI = Inactivo',
  PRIMARY KEY (`B_idBodegas`),
  INDEX `FK_sucursal_idx` (`B_idSucursal` ASC) VISIBLE,
  CONSTRAINT `FK_B_sucursal`
    FOREIGN KEY (`B_idSucursal`)
    REFERENCES `occident`.`occ_sucursales` (`S_idSucursales`))
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8mb4
COLLATE = utf8mb4_0900_ai_ci
COMMENT = 'Las bodegas son donde se almacenan los inventarios de cada sucursal, además cada sucursal podrá tener más de una bodega.';


-- -----------------------------------------------------
-- Table `occident`.`occ_inventariotomafisica`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `occident`.`occ_inventariotomafisica` (
  `ITF_idInventarioTomaFisica` INT NOT NULL AUTO_INCREMENT COMMENT 'Identificador de la tabla.',
  `ITF_idBodega` INT NOT NULL COMMENT 'Identificador del la bodega.',
  `ITF_codigo` VARCHAR(45) NOT NULL COMMENT 'Identificador del inventario o la toma fisica.',
  `ITF_tipo` VARCHAR(1) NOT NULL COMMENT 'Definir el tipo de tabla que se va a utilizar ya sea un inventario o una toma física \\nI = Inventario\\nT = Toma física\\n',
  `ITF_estado` VARCHAR(45) NOT NULL COMMENT 'Muestra el estdo de la toma fisica o el inventario.\\nA = Activo\\nI = Inactivo',
  PRIMARY KEY (`ITF_idInventarioTomaFisica`),
  INDEX `FK_ITF_bodega_idx` (`ITF_idBodega` ASC) VISIBLE,
  CONSTRAINT `FK_ITF_bodega`
    FOREIGN KEY (`ITF_idBodega`)
    REFERENCES `occident`.`occ_bodegas` (`B_idBodegas`))
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8mb4
COLLATE = utf8mb4_0900_ai_ci
COMMENT = 'Tabla encargada del registro de los inventarios y las tomas físicas.';


-- -----------------------------------------------------
-- Table `occident`.`occ_provedores`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `occident`.`occ_provedores` (
  `P_idProvedores` INT NOT NULL AUTO_INCREMENT COMMENT 'Identificador de la tabla.',
  `P_tiposContactos` INT NOT NULL COMMENT 'Identificador del tipo de contacto del provedor.',
  `P_categoriaProvedor` INT NOT NULL COMMENT 'Identificador de la categoria del provedor.',
  `P_tipoCedula` INT NOT NULL COMMENT 'Identificador del tipo de cedula que posee el provedor.',
  `P_cedula` INT NOT NULL COMMENT 'Cedula del provedor.',
  `P_nombreRazonSocial` VARCHAR(100) NOT NULL COMMENT 'Nombre o razon sacial que tiene el proveedor.',
  `P_fechaIngreso` DATETIME NOT NULL COMMENT 'Fecha de ingreso al sistema.',
  `P_saldo` FLOAT NOT NULL COMMENT 'El saldo que se le debe a un proveedor.',
  `P_cuentaBanco` VARCHAR(30) NOT NULL COMMENT 'La cuenta del banco a la cual se le debe realizar el pago.',
  `P_banco` VARCHAR(50) NOT NULL COMMENT 'El banco a la cual se le debe realizar el pago.',
  `P_diasPago` VARCHAR(20) NOT NULL COMMENT 'Dias de pago para el provedor.',
  `P_estado` VARCHAR(1) NOT NULL COMMENT 'Muestra el estado de los proveedores.\\nA = Activo\\nI = Inactivo\\n',
  PRIMARY KEY (`P_idProvedores`),
  INDEX `fk_occ_provedores_occ_tiposContactos1_idx` (`P_tiposContactos` ASC) VISIBLE,
  INDEX `FK_tipoCedula_idx` (`P_tipoCedula` ASC) VISIBLE,
  INDEX `FK_categoriaProvedor_idx` (`P_categoriaProvedor` ASC) VISIBLE,
  CONSTRAINT `FK_P_categoriaProvedor`
    FOREIGN KEY (`P_categoriaProvedor`)
    REFERENCES `occident`.`occ_categoriasclientesprovedor` (`CC_idCategoriasCP`),
  CONSTRAINT `FK_P_tipoCedula`
    FOREIGN KEY (`P_tipoCedula`)
    REFERENCES `occident`.`occ_tipocedula` (`TC_idTipoCedula`),
  CONSTRAINT `FK_P_tipoContactos`
    FOREIGN KEY (`P_tiposContactos`)
    REFERENCES `occident`.`occ_tiposcontactos` (`TC_idTiposContactos`))
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8mb4
COLLATE = utf8mb4_0900_ai_ci
COMMENT = 'Tabla encargada de registrar a todos los proveedores para la compra de mercadería.';


-- -----------------------------------------------------
-- Table `occident`.`occ_facturas`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `occident`.`occ_facturas` (
  `F_idFacturas` INT NOT NULL AUTO_INCREMENT COMMENT 'Identificador de la tabla.',
  `F_cliente` INT NULL DEFAULT NULL COMMENT 'Identificador del cliente.',
  `F_moneda` INT NULL DEFAULT NULL COMMENT 'Identificador del la moneda.',
  `F_caja` INT NULL DEFAULT NULL COMMENT 'Identificador de la caja en la que se registrar la factura.',
  `F_codigo` VARCHAR(45) NOT NULL COMMENT 'Identificador de la factura.',
  `F_estado` INT NULL DEFAULT NULL COMMENT 'Muestra el estado de la factura.\\nA = Activo\\nI = Inactivo',
  `F_montoTotal` FLOAT NULL DEFAULT NULL COMMENT 'Monto total de factura.',
  `F_fechaRegistro` DATETIME NULL DEFAULT NULL COMMENT 'Fecha en la que se realizo la factura.',
  `F_fechaCancelacionVencimiento` DATETIME NULL DEFAULT NULL COMMENT 'Fecha de cancelacion para factura.\\nFecha de vencimiento para apartado.',
  `F_impuestoVigente` INT NULL DEFAULT NULL COMMENT 'Identificador del impuesto vigente que se le aplica a la factura.',
  `F_exento` VARCHAR(1) NULL DEFAULT NULL COMMENT 'Apartado que informa si la factura esta o no exenta de impuesto.\\nS = Libre de exento\\nN = No esta libre de exento',
  `F_montoDelDescuento` FLOAT NULL DEFAULT NULL COMMENT 'Monto total del descuento que se le aplico a la factura.',
  `F_tipoPago` VARCHAR(45) NULL DEFAULT NULL COMMENT 'Forma en la que se pago la factura, por ejemplo Efectivo',
  `F_tipoFactura` VARCHAR(2) NULL DEFAULT NULL COMMENT 'Tipo de factura que se aplica:\\nFC = Factura\\nAP = Apartado\\nPF = Pre-factura\\nTR = Traslado\\nCP = Compras\\nDV = Devolución\\nCD = Crédito\\n\\n\\n',
  `F_saldoActual` FLOAT NULL DEFAULT NULL COMMENT 'Saldo actual de la factura.',
  `F_idInventarioSalida` INT NULL DEFAULT NULL COMMENT 'Identificador del inventario de salida donde se efectúa el traslado.',
  `F_idInventarioEntrada` INT NULL DEFAULT NULL COMMENT 'Identificador del inventario de entrada donde se efectúa el traslado.',
  `F_idProvedor` INT NULL DEFAULT NULL COMMENT 'Identificador del provedor.',
  PRIMARY KEY (`F_idFacturas`),
  INDEX `FK_cliente_id` (`F_cliente` ASC) VISIBLE,
  INDEX `FK_moneda_idx` (`F_moneda` ASC) VISIBLE,
  INDEX `FK_impuesto_idx` (`F_impuestoVigente` ASC) VISIBLE,
  INDEX `FK_inventarioSalida_idx` (`F_idInventarioSalida` ASC) VISIBLE,
  INDEX `FK_inventarioEntrada_idx` (`F_idInventarioEntrada` ASC) VISIBLE,
  INDEX `FK_caja_idx` (`F_caja` ASC) VISIBLE,
  INDEX `FK_provedor_idx` (`F_idProvedor` ASC) VISIBLE,
  CONSTRAINT `FK_F_caja`
    FOREIGN KEY (`F_caja`)
    REFERENCES `occident`.`occ_cajas` (`C_idCajas`),
  CONSTRAINT `FK_F_cliente`
    FOREIGN KEY (`F_cliente`)
    REFERENCES `occident`.`occ_clientes` (`C_idClientes`),
  CONSTRAINT `FK_F_impuesto`
    FOREIGN KEY (`F_impuestoVigente`)
    REFERENCES `occident`.`occ_impuestos` (`I_idImpuesto`),
  CONSTRAINT `FK_F_inventarioEntrada`
    FOREIGN KEY (`F_idInventarioEntrada`)
    REFERENCES `occident`.`occ_inventariotomafisica` (`ITF_idInventarioTomaFisica`),
  CONSTRAINT `FK_F_inventarioSalida`
    FOREIGN KEY (`F_idInventarioSalida`)
    REFERENCES `occident`.`occ_inventariotomafisica` (`ITF_idInventarioTomaFisica`),
  CONSTRAINT `FK_F_moneda`
    FOREIGN KEY (`F_moneda`)
    REFERENCES `occident`.`occ_monedas` (`M_idMonedas`),
  CONSTRAINT `FK_F_provedor`
    FOREIGN KEY (`F_idProvedor`)
    REFERENCES `occident`.`occ_provedores` (`P_idProvedores`))
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8mb4
COLLATE = utf8mb4_0900_ai_ci
COMMENT = 'Tabla encardada de guardar toda la información de las transacciones:\\nFactura\\nApartado\\nPre-factura\\nTraslado\\nCompras\\nDevolución\\nCrédito\\n';


-- -----------------------------------------------------
-- Table `occident`.`occ_creditos`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `occident`.`occ_creditos` (
  `C_idCreditos` INT NOT NULL AUTO_INCREMENT COMMENT 'Identificador de la tabla.',
  `C_idFactura` INT NOT NULL COMMENT 'Identificador de la factura a la que pertenece el credito.',
  `C_idCliente` INT NOT NULL COMMENT 'Identificador del cliente a la que pertenece el credito.',
  `C_monto` FLOAT NOT NULL COMMENT 'Monto del credito.',
  `C_fecha` DATETIME NOT NULL COMMENT 'Fecha en el que se realizo el credito.',
  `C_estado` VARCHAR(45) NOT NULL COMMENT 'Muestra el estado del credito.\\nA = Activo\\nI = Inactivo',
  PRIMARY KEY (`C_idCreditos`),
  INDEX `FK_factura_idx` (`C_idFactura` ASC) VISIBLE,
  INDEX `FK_C_cliente_idx` (`C_idCliente` ASC) VISIBLE,
  CONSTRAINT `FK_C_cliente`
    FOREIGN KEY (`C_idCliente`)
    REFERENCES `occident`.`occ_clientes` (`C_idClientes`),
  CONSTRAINT `FK_C_factura`
    FOREIGN KEY (`C_idFactura`)
    REFERENCES `occident`.`occ_facturas` (`F_idFacturas`))
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8mb4
COLLATE = utf8mb4_0900_ai_ci
COMMENT = 'Tabla que registra todos los créditos emitidos.';


-- -----------------------------------------------------
-- Table `occident`.`occ_cuentascobar`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `occident`.`occ_cuentascobar` (
  `CC_idCuentasCobar` INT NOT NULL AUTO_INCREMENT COMMENT 'Identificador de la tabla.',
  `CC_IdCliente` INT NOT NULL COMMENT 'Identificador del cliente al que esta asignada la cuenta por cobrar.',
  `CC_codigoCredito` INT NOT NULL COMMENT 'Identificador del credito asignado',
  `CC_montoTotal` FLOAT NOT NULL COMMENT 'Monto total de la cuenta por cobrar',
  `CC_fechaRegistro` DATETIME NOT NULL COMMENT 'Fecha en la que se reliza la cuenta por cobrar.',
  `CC_fechaCancelacion` DATETIME NOT NULL COMMENT 'Fecha de la cancelacion de la cuenta por cobrar.',
  `CC_fechaVencimiento` DATETIME NOT NULL COMMENT 'Fecha del vencimiento de la cuenta por cobrar.',
  `CC_estado` VARCHAR(1) NOT NULL COMMENT 'Muestra el estado de las cuentas por cobrar.\\nA = Activo\\nI = Inactivo',
  PRIMARY KEY (`CC_idCuentasCobar`),
  INDEX `FK_cliente_idx` (`CC_IdCliente` ASC) VISIBLE,
  INDEX `FK_Credito_idx` (`CC_codigoCredito` ASC) VISIBLE,
  CONSTRAINT `FK_CC_cliente`
    FOREIGN KEY (`CC_IdCliente`)
    REFERENCES `occident`.`occ_clientes` (`C_idClientes`),
  CONSTRAINT `FK_CC_Credito`
    FOREIGN KEY (`CC_codigoCredito`)
    REFERENCES `occident`.`occ_creditos` (`C_idCreditos`))
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8mb4
COLLATE = utf8mb4_0900_ai_ci
COMMENT = 'Tabla que genera una cuenta por cobrar a un cliente ya que tiene un monto pendiente por parga, por ejemplo una factura pendiente.';


-- -----------------------------------------------------
-- Table `occident`.`occ_abonos`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `occident`.`occ_abonos` (
  `A_idAbonos` INT NOT NULL AUTO_INCREMENT COMMENT 'Identificador de la tabla.',
  `A_idCuentaXCobrar` INT NULL DEFAULT NULL COMMENT 'Identificador de la cuenta por cobrar para el abono.',
  `A_codigo` VARCHAR(45) NULL DEFAULT NULL COMMENT 'Identificador del abono. ',
  `A_monto` FLOAT NULL DEFAULT NULL COMMENT 'Monto del abono.',
  `A_fecha` DATETIME NULL DEFAULT NULL COMMENT 'Fecha en la que se hace el abono.',
  `A_estado` VARCHAR(1) NULL DEFAULT NULL COMMENT 'Muestra el estado del abono.\\nA = Activo\\\\nI = Inactivo',
  PRIMARY KEY (`A_idAbonos`),
  INDEX `FK_CuentaXCobrar_idx` (`A_idCuentaXCobrar` ASC) VISIBLE,
  CONSTRAINT `FK_CXC_CuentaXCobrar`
    FOREIGN KEY (`A_idCuentaXCobrar`)
    REFERENCES `occident`.`occ_cuentascobar` (`CC_idCuentasCobar`))
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8mb4
COLLATE = utf8mb4_0900_ai_ci
COMMENT = 'Tabla almacenara los abonos a los créditos que posee un cliente. ';


-- -----------------------------------------------------
-- Table `occident`.`occ_familias`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `occident`.`occ_familias` (
  `F_iFamilias` INT NOT NULL AUTO_INCREMENT COMMENT 'Identificador de la tabla.',
  `F_codigo` VARCHAR(50) NOT NULL COMMENT 'Identificador del la familia de productos.',
  `F_descripcion` VARCHAR(100) NOT NULL COMMENT 'Descripción de las familias, donde se podrán registrar información necesaria para los distintos artículos del mismo.\\\\nEjemplo, lácteos.\\\\n',
  `F_descuento` FLOAT NOT NULL COMMENT 'Desceunto que se le aplica a una familia en caso de que tenga un descuento.',
  `F_estado` VARCHAR(1) NOT NULL COMMENT 'Muestra el estado de la familia de productos.\\nA = Activo\\nI = Inactivo',
  PRIMARY KEY (`F_iFamilias`))
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8mb4
COLLATE = utf8mb4_0900_ai_ci
COMMENT = 'Tabla encargada de guardar las familias de artículos como lo serían los lácteos.';


-- -----------------------------------------------------
-- Table `occident`.`occ_unidades`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `occident`.`occ_unidades` (
  `U_idUnidades` INT NOT NULL AUTO_INCREMENT COMMENT 'Identificador de la tabla.',
  `U_codigo` VARCHAR(45) NOT NULL COMMENT 'Identificador del tipo de unidad.',
  `U_descripcion` VARCHAR(50) NOT NULL COMMENT 'Descripcion de la unidad de medida a registrar, por ejemplo gramos.',
  `U_estado` VARCHAR(1) NOT NULL COMMENT 'Describe el estado de las unidades de medida.\\nA = Activo\\nI = Inactivo',
  PRIMARY KEY (`U_idUnidades`))
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8mb4
COLLATE = utf8mb4_0900_ai_ci
COMMENT = 'Tabla de registro de las unidades de medidas.';


-- -----------------------------------------------------
-- Table `occident`.`occ_articulos`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `occident`.`occ_articulos` (
  `A_idArticulos` INT NOT NULL AUTO_INCREMENT COMMENT 'Identificador de la tabla.',
  `A_idfamilia` INT NOT NULL COMMENT 'Identificador de la familia a la que pertenece el articulo.',
  `A_unidadMedida` INT NOT NULL COMMENT 'Identificador de la unidad de medida del articulo.',
  `A_codigo` VARCHAR(50) NOT NULL COMMENT 'Identificador de los articulos.',
  `A_codigoBarras` INT NULL DEFAULT NULL COMMENT 'Codigo de barras en caso de que el articulo lo tenga.',
  `A_descripcion` VARCHAR(100) NOT NULL COMMENT 'Descripcion del articulo.',
  `A_precioXunidar` FLOAT NOT NULL COMMENT 'Precio por unidad del articulo.',
  `A_cantidadMin` INT NULL DEFAULT NULL COMMENT 'Cantidad minima de articulos para que el precio del producto cambie a menos costo.',
  `A_precioXcantidad` FLOAT NULL DEFAULT NULL COMMENT 'Es el precio que se establece cuando la cantidad de productos supere la cantidad mínima y se disminuye el precio por producto.',
  `A_estado` VARCHAR(1) NOT NULL COMMENT 'Muestra el estado del articulo.\\nA = Activo\\\\nI = Inactivo',
  PRIMARY KEY (`A_idArticulos`),
  INDEX `fk_occ_articulos_occ_familias1_idx` (`A_idfamilia` ASC) VISIBLE,
  INDEX `FK_A_unidadMedida_idx` (`A_unidadMedida` ASC) VISIBLE,
  CONSTRAINT `FK_A_familias`
    FOREIGN KEY (`A_idfamilia`)
    REFERENCES `occident`.`occ_familias` (`F_iFamilias`),
  CONSTRAINT `FK_A_unidadMedida`
    FOREIGN KEY (`A_unidadMedida`)
    REFERENCES `occident`.`occ_unidades` (`U_idUnidades`))
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8mb4
COLLATE = utf8mb4_0900_ai_ci
COMMENT = 'Los artículos que se manejan en el sistema.';


-- -----------------------------------------------------
-- Table `occident`.`occ_cheques`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `occident`.`occ_cheques` (
  `C_idCheques` INT NOT NULL AUTO_INCREMENT COMMENT 'Identificador de la tabla.',
  `C_idProvedor` INT NOT NULL COMMENT 'Identificador del proveedor del cheque.',
  `C_fecha` DATETIME NOT NULL COMMENT 'Fecha en que se realizo el cheque.',
  `C_numeroDeCheque` INT NOT NULL COMMENT 'Numero de cheque.',
  `C_motivo` VARCHAR(50) NOT NULL COMMENT 'El motivo del porque se emite el cheque.',
  `C_monto` FLOAT NOT NULL COMMENT 'Monto del cheque.',
  `C_emitidoPor` VARCHAR(50) NOT NULL COMMENT 'El nombre de la persona o entidad que emitio el cheque',
  `C_estado` VARCHAR(1) NOT NULL COMMENT 'Muestra el estado del cheque.\\nA = Activo\\nI = Inactivo',
  PRIMARY KEY (`C_idCheques`),
  INDEX `FK_provedor_idx` (`C_idProvedor` ASC) VISIBLE,
  CONSTRAINT `FK_CH_provedor`
    FOREIGN KEY (`C_idProvedor`)
    REFERENCES `occident`.`occ_provedores` (`P_idProvedores`))
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8mb4
COLLATE = utf8mb4_0900_ai_ci
COMMENT = 'Tabla encargada de guardar toda la información necesaria para la emisión de cheques a los proveedores para el pago de la mercadería.';


-- -----------------------------------------------------
-- Table `occident`.`occ_cuentaspagar`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `occident`.`occ_cuentaspagar` (
  `CP_idCuentasPagar` INT NOT NULL AUTO_INCREMENT COMMENT 'Identificador de la tabla.',
  `CP_idProvedor` INT NULL DEFAULT NULL COMMENT 'Identificador del proveedor de la cuenta por pagar.',
  `CP_idCliente` INT NULL DEFAULT NULL COMMENT 'Identificador del cliente de la cuenta por pagar.',
  `CP_idFactura` INT NULL DEFAULT NULL COMMENT 'Identificador de la factura asociada a la cuenta por pagar.',
  `CP_codigo` VARCHAR(45) NOT NULL COMMENT 'Identificador de la cuenta por pagar.',
  `CP_montoTotal` FLOAT NULL DEFAULT NULL COMMENT 'Monto total de la cuenta por pagar.',
  `CP_fechaRegistro` DATETIME NULL DEFAULT NULL COMMENT 'Feche en la que se emite la cuenta por pagar.',
  `CP_fechaCancelacion` DATETIME NULL DEFAULT NULL COMMENT 'Fecha de la cancelación de la cuenta por pagar.',
  `CP_fechaVencimiento` DATETIME NULL DEFAULT NULL COMMENT 'Fecha del vencimiento de la cuenta por pagar.',
  `CP_estado` VARCHAR(1) NULL DEFAULT NULL COMMENT 'Muestra el estado de la cuenta por pagar.\\nA = Activo\\nI = Inactivo',
  PRIMARY KEY (`CP_idCuentasPagar`),
  INDEX `FK_Factura_idx` (`CP_idFactura` ASC) VISIBLE,
  INDEX `FK_provedor_idx` (`CP_idProvedor` ASC) VISIBLE,
  INDEX `FK_cliente_idx` (`CP_idCliente` ASC) VISIBLE,
  CONSTRAINT `FK_CP_factura`
    FOREIGN KEY (`CP_idFactura`)
    REFERENCES `occident`.`occ_facturas` (`F_idFacturas`),
  CONSTRAINT `FK_FK_CP_cliente`
    FOREIGN KEY (`CP_idCliente`)
    REFERENCES `occident`.`occ_clientes` (`C_idClientes`),
  CONSTRAINT `FK_FK_CP_provedor`
    FOREIGN KEY (`CP_idProvedor`)
    REFERENCES `occident`.`occ_provedores` (`P_idProvedores`))
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8mb4
COLLATE = utf8mb4_0900_ai_ci
COMMENT = 'Tabla que genera una cuenta por pagar a un proveedor hay un monto pendiente por parga, por ejemplo, una compra de una mercadería.';


-- -----------------------------------------------------
-- Table `occident`.`occ_detallearticulo`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `occident`.`occ_detallearticulo` (
  `DA_idDetalleArticulo` INT NOT NULL AUTO_INCREMENT COMMENT 'Identificador de la tabla.',
  `DA_idfactura` INT NULL DEFAULT NULL COMMENT 'Identificador de la \"factura\" a la que pertenece este detalle.\\nEn este caso puede variar entre (Factura, Apartado, Prefectura, Traslado, Compras, Devolución, Crédito).\\n',
  `DA_idArticulo` INT NULL DEFAULT NULL COMMENT 'Identificador del artículo que está registrando para el detalle.',
  `DA_estado` VARCHAR(3) NULL DEFAULT NULL COMMENT 'Muestra el estado del detalle artículo\\nA = Activo\\nI = Inactivo',
  PRIMARY KEY (`DA_idDetalleArticulo`),
  INDEX `FK_factura_idx` (`DA_idfactura` ASC) VISIBLE,
  INDEX `FK_articulo_idx` (`DA_idArticulo` ASC) VISIBLE,
  CONSTRAINT `FK_DA_articulo`
    FOREIGN KEY (`DA_idArticulo`)
    REFERENCES `occident`.`occ_articulos` (`A_idArticulos`),
  CONSTRAINT `FK_DA_factura`
    FOREIGN KEY (`DA_idfactura`)
    REFERENCES `occident`.`occ_facturas` (`F_idFacturas`))
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8mb4
COLLATE = utf8mb4_0900_ai_ci
COMMENT = 'Tabla que registra todos los artículos relacionados con una factura.';


-- -----------------------------------------------------
-- Table `occident`.`occ_detallecaja`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `occident`.`occ_detallecaja` (
  `DC_idDetalleCaja` INT NOT NULL AUTO_INCREMENT COMMENT 'Identificador de la tabla.',
  `DC_idCaja` INT NOT NULL COMMENT 'Identificador de la caja a la que pertenece el detalle.',
  `DC_fecha` DATETIME NOT NULL COMMENT 'Fecha en el que se registro el detalle.',
  `DC_saldoInicial` FLOAT NOT NULL COMMENT 'Saldo inicial de la caja.',
  `DC_saldoFinal` FLOAT NOT NULL COMMENT 'Saldo final de la caja.',
  `DC_montoMovimientos` FLOAT NOT NULL COMMENT 'Monto de los movimientos de la caja.',
  `DC_totalEntradas` INT NOT NULL COMMENT 'Total de entradas registradas en la caja.',
  `DC_totalSalidas` INT NOT NULL COMMENT 'Total de salidas registradas en la caja.',
  `DC_estado` VARCHAR(1) NOT NULL COMMENT 'Muestra el estado del detalle de la caja.\\nA = Activo\\nI = Inactivo',
  PRIMARY KEY (`DC_idDetalleCaja`),
  INDEX `FK_DC_caja_idx` (`DC_idCaja` ASC) VISIBLE,
  CONSTRAINT `FK_DC_caja`
    FOREIGN KEY (`DC_idCaja`)
    REFERENCES `occident`.`occ_cajas` (`C_idCajas`))
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8mb4
COLLATE = utf8mb4_0900_ai_ci
COMMENT = 'Tabla donde se registran los cierres de caja de una sucursal.';


-- -----------------------------------------------------
-- Table `occident`.`occ_detallecontactos`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `occident`.`occ_detallecontactos` (
  `DC_idDetalleContactos` INT NOT NULL AUTO_INCREMENT COMMENT 'Identificador de la tabla.',
  `DC_idTipoContacto` INT NOT NULL COMMENT 'Identificador del tipo de categoría al que pertenece.\\\\n',
  `DC_Telefono` VARCHAR(12) NULL DEFAULT NULL COMMENT 'Numero de teléfono.',
  `DT_Fax` VARCHAR(50) NULL DEFAULT NULL COMMENT 'Fax',
  `DC_Correo` VARCHAR(76) NULL DEFAULT NULL COMMENT 'Correo electronico.',
  `DT_paginaWeb` VARCHAR(2083) NULL DEFAULT NULL COMMENT 'Dirección de la página Web',
  `DT_estado` VARCHAR(1) NULL DEFAULT NULL COMMENT 'Muestra el estado del detalle del contacto.\\nA = Activo\\nI = Inactivo',
  PRIMARY KEY (`DC_idDetalleContactos`),
  INDEX `FK_Contacto_idx` (`DC_idTipoContacto` ASC) VISIBLE,
  CONSTRAINT `FK_Contacto`
    FOREIGN KEY (`DC_idTipoContacto`)
    REFERENCES `occident`.`occ_tiposcontactos` (`TC_idTiposContactos`))
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8mb4
COLLATE = utf8mb4_0900_ai_ci
COMMENT = 'Tabla donde se registran todos los contactos relacionados a la tabla \"occ_tiposContactos\".';


-- -----------------------------------------------------
-- Table `occident`.`occ_detalleinventario`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `occident`.`occ_detalleinventario` (
  `DI_idDetalleInventario` INT NOT NULL AUTO_INCREMENT COMMENT 'Identificador de la tabla.',
  `DI_idInventario` INT NOT NULL COMMENT 'Identificador del inventario al que pertenece el detalle.',
  `DI_idArticulo` INT NOT NULL COMMENT 'Identificador del articulo a registrar en el inventario.',
  `DI_cantidad` INT NOT NULL COMMENT 'Cantidad de existencia del artículo.',
  `DI_estado` VARCHAR(2) NOT NULL COMMENT 'Muestra el estado del detalle del inventario.\\nA = Activo\\nI = Inactivo',
  PRIMARY KEY (`DI_idDetalleInventario`),
  INDEX `FK_bodega_idx` (`DI_idInventario` ASC) VISIBLE,
  INDEX `FK_articulo_idx` (`DI_idArticulo` ASC) VISIBLE,
  CONSTRAINT `FK_DI_articulo`
    FOREIGN KEY (`DI_idArticulo`)
    REFERENCES `occident`.`occ_articulos` (`A_idArticulos`),
  CONSTRAINT `FK_DI_inventarioTomaFisica`
    FOREIGN KEY (`DI_idInventario`)
    REFERENCES `occident`.`occ_inventariotomafisica` (`ITF_idInventarioTomaFisica`))
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8mb4
COLLATE = utf8mb4_0900_ai_ci
COMMENT = 'Tabla encargada del registro de los artículos relaciones con un inventario o la toma física.';


-- -----------------------------------------------------
-- Table `occident`.`occ_robosdaños`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `occident`.`occ_robosdaños` (
  `RD_idRobosDaños` INT NOT NULL AUTO_INCREMENT COMMENT 'Identificador de la tabla.',
  `RD_idInventario` INT NULL DEFAULT NULL COMMENT 'Identificador del inventario al que pertenece el articulo robado o dañado.',
  `RD_fecha` DATETIME NULL DEFAULT NULL COMMENT 'Fecha en la que se registro la daño o robo.',
  `RD_tipo` VARCHAR(1) NULL DEFAULT NULL COMMENT 'El tipo de tabla.\\nR = Robo\\\\nD = Daño\\\\n',
  `RD_total` FLOAT NULL DEFAULT NULL COMMENT 'Total del costo del daño o el robo.',
  `RD_estado` VARCHAR(1) NULL DEFAULT NULL COMMENT 'Muestra el estado del daño o el robo.\\nA = Activo\\nI = Inactivo\\n',
  PRIMARY KEY (`RD_idRobosDaños`),
  INDEX `FK_inventario_idx` (`RD_idInventario` ASC) VISIBLE,
  CONSTRAINT `FK_RD_inventario`
    FOREIGN KEY (`RD_idInventario`)
    REFERENCES `occident`.`occ_inventariotomafisica` (`ITF_idInventarioTomaFisica`))
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8mb4
COLLATE = utf8mb4_0900_ai_ci
COMMENT = 'Tabla que registra los robos y daños causados en las sucursales.';


-- -----------------------------------------------------
-- Table `occident`.`occ_detallerobosdaños`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `occident`.`occ_detallerobosdaños` (
  `DRD_idDetalleRobosDaños` INT NOT NULL AUTO_INCREMENT COMMENT 'Identificador de la tabla.',
  `DRD_idArticulo` INT NULL DEFAULT NULL COMMENT 'Identificador del articulo dañado o robado.',
  `DRD_idRoboDaños` INT NULL DEFAULT NULL COMMENT 'Identificador de la tabla de robo y daños al que pertenece el detalle.',
  `DRD_estado` VARCHAR(1) NULL DEFAULT NULL COMMENT 'Muestra el estado del detalle de robos y daños.\\nA = Activo\\nI = Inactivo',
  PRIMARY KEY (`DRD_idDetalleRobosDaños`),
  INDEX `FK_articulo_idx` (`DRD_idArticulo` ASC) VISIBLE,
  INDEX `FK_roboDaños_idx` (`DRD_idRoboDaños` ASC) VISIBLE,
  CONSTRAINT `FK_DRB_articulo`
    FOREIGN KEY (`DRD_idArticulo`)
    REFERENCES `occident`.`occ_articulos` (`A_idArticulos`),
  CONSTRAINT `FK_DRB_roboDaños`
    FOREIGN KEY (`DRD_idRoboDaños`)
    REFERENCES `occident`.`occ_robosdaños` (`RD_idRobosDaños`))
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8mb4
COLLATE = utf8mb4_0900_ai_ci
COMMENT = 'Tabla que registra los artículos dañados o robado en un reporte de daños o robos.';


-- -----------------------------------------------------
-- Table `occident`.`occ_pagos`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `occident`.`occ_pagos` (
  `P_idPagos` INT NOT NULL AUTO_INCREMENT COMMENT 'Identificador de la tabla.',
  `P_idCXP` INT NULL DEFAULT NULL COMMENT 'Identificador de la cuenta por pagar.',
  `P_codigo` VARCHAR(45) NOT NULL COMMENT 'Identificador del pago.',
  `P_monto` FLOAT NULL DEFAULT NULL COMMENT 'Monto del pago.',
  `P_fecha` DATETIME NULL DEFAULT NULL COMMENT 'Fecha en la que se realizo el pago.',
  `P_saldoRestante` FLOAT NULL DEFAULT NULL COMMENT 'Saldo restante de la cuenta por pagar.',
  `P_estado` VARCHAR(1) NULL DEFAULT NULL COMMENT 'Muestra el estado del pago.\\nA = Activo\\nI = Inactivo',
  PRIMARY KEY (`P_idPagos`),
  INDEX `FK_CXP_idx` (`P_idCXP` ASC) VISIBLE,
  CONSTRAINT `FK_P_CXP`
    FOREIGN KEY (`P_idCXP`)
    REFERENCES `occident`.`occ_cuentaspagar` (`CP_idCuentasPagar`))
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8mb4
COLLATE = utf8mb4_0900_ai_ci
COMMENT = 'Tabla que registra los pagos para las cuentas por cobrar.';


-- -----------------------------------------------------
-- Table `occident`.`occ_tipocambio`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `occident`.`occ_tipocambio` (
  `TC_idTipoCambio` INT NOT NULL AUTO_INCREMENT COMMENT 'Identificador de la tabla.',
  `TC_codigo` VARCHAR(45) NOT NULL COMMENT 'Identificador del tipo de cambio.',
  `TC_descripcion` VARCHAR(50) NOT NULL COMMENT 'Descripcion del tipo de cambio.',
  `TC_monedaDestino` INT NOT NULL COMMENT 'Identificador de la moneda de destino.',
  `TC_monedaOrigen` INT NOT NULL COMMENT 'Identificador de la moneda de destino.',
  `TC_ValorTipoCambio` FLOAT NOT NULL COMMENT 'Valor del tipo de cambio.',
  `TC_fecha` DATETIME NOT NULL COMMENT 'Fecha que se cambió o se creó el tipo de cambio.',
  `TC_estado` VARCHAR(1) NOT NULL COMMENT 'Muestra el estado del tipo de cambio.\\nA = Activo\\nI = Inactivo',
  PRIMARY KEY (`TC_idTipoCambio`),
  INDEX `FK_TC_monedaDestino_idx` (`TC_monedaDestino` ASC) VISIBLE,
  INDEX `FK_TC_monedaOrigen_idx` (`TC_monedaOrigen` ASC) VISIBLE,
  CONSTRAINT `FK_TC_monedaDestino`
    FOREIGN KEY (`TC_monedaDestino`)
    REFERENCES `occident`.`occ_monedas` (`M_idMonedas`),
  CONSTRAINT `FK_TC_monedaOrigen`
    FOREIGN KEY (`TC_monedaOrigen`)
    REFERENCES `occident`.`occ_monedas` (`M_idMonedas`))
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8mb4
COLLATE = utf8mb4_0900_ai_ci
COMMENT = 'Tabla que registra el valor de los diferentes tipos de cambio entre las diferentes monedas.';


SET SQL_MODE=@OLD_SQL_MODE;
SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS;
SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS;
