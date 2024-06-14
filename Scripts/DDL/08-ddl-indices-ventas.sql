--@Autor: Jorge Francisco Pereda Ceballos, Brandon Cervantes Rubí,  Alexis Isaac Alcocer Diaz
--@Fecha: 03/11/2024
--@Descripción: Creación de indices para el módulo de VENTA

Prompt Conectando a petcare_pdb_venta
connect sys/system as sysdba
alter session set container=petcare_pdb_venta;
connect pet_c_venta/venta123@PDB_VENTA

-- Índices para llaves foráneas
--

-- Índice para PRODUCTO_CATEGORIA.CATALOGO_PRODUCTO_ID
CREATE INDEX PET_C_VENTA.PROD_CAT_CAT_PROD_ID_IDX
    ON PET_C_VENTA.PRODUCTO_CATEGORIA (CATALOGO_PRODUCTO_ID)
    TABLESPACE VENTA_IDXS_TS;

-- Índice para PRODUCTO_CATEGORIA.CATALOGO_CATEGORIA_ID
CREATE INDEX PET_C_VENTA.PROD_CAT_CAT_CATEGORIA_ID_IDX
    ON PET_C_VENTA.PRODUCTO_CATEGORIA (CATALOGO_CATEGORIA_ID)
    TABLESPACE VENTA_IDXS_TS;

-- Índice para CLIENTE_TELEFONO.CLIENTE_ID
CREATE INDEX PET_C_VENTA.CLIENTE_TELEFONO_CLIENTE_ID_IDX
    ON PET_C_VENTA.CLIENTE_TELEFONO (CLIENTE_ID)
    TABLESPACE VENTA_IDXS_TS;

-- Índice para ORDEN_COMPRA.CLIENTE_ID
CREATE INDEX PET_C_VENTA.ORDEN_COMPRA_CLIENTE_ID_IDX
    ON PET_C_VENTA.ORDEN_COMPRA (CLIENTE_ID)
    TABLESPACE VENTA_IDXS_TS;

-- Índice para SERVICIO_ORDEN_COMPRA.ORDEN_COMPRA_ID
CREATE INDEX PET_C_VENTA.SERV_ORD_COMP_ORDEN_COMPRA_ID_IDX
    ON PET_C_VENTA.SERVICIO_ORDEN_COMPRA (ORDEN_COMPRA_ID)
    TABLESPACE VENTA_IDXS_TS;    

-- Índice para INVENTARIO_PRODUCTO.ORDEN_COMPRA_ID
CREATE INDEX PET_C_VENTA.INV_PROD_ORDEN_COMPRA_ID_IDX
    ON PET_C_VENTA.INVENTARIO_PRODUCTO (ORDEN_COMPRA_ID)
    TABLESPACE VENTA_IDXS_TS;

-- Índice para INVENTARIO_PRODUCTO.CATALOGO_PRODUCTO_ID
CREATE INDEX PET_C_VENTA.INV_PROD_CATALOGO_PRODUCTO_ID_IDX
    ON PET_C_VENTA.INVENTARIO_PRODUCTO (CATALOGO_PRODUCTO_ID)
    TABLESPACE VENTA_IDXS_TS;    

-- Índice para ESTATUS_INVENTARIO_HISTORICO.ESTATUS_PRODUCTO_ID
CREATE INDEX PET_C_VENTA.EST_INV_HIST_ESTATUS_PROD_ID_IDX
    ON PET_C_VENTA.ESTATUS_INVENTARIO_HISTORICO (ESTATUS_PRODUCTO_ID)
    TABLESPACE VENTA_IDXS_TS;

-- Índice para ESTATUS_INVENTARIO_HISTORICO.INVENTARIO_PRODUCTO_ID
CREATE INDEX PET_C_VENTA.EST_INV_HIST_INVENTARIO_PROD_ID_IDX
    ON PET_C_VENTA.ESTATUS_INVENTARIO_HISTORICO (INVENTARIO_PRODUCTO_ID)
    TABLESPACE VENTA_IDXS_TS;    


-- Índice compuesto:  
-- Este índice busca en la tabla ORDEN_COMPRA por cliente y rango de fechas.
CREATE INDEX PET_C_VENTA.ORDEN_COMPRA_CLIENTE_FECHA_IDX
    ON PET_C_VENTA.ORDEN_COMPRA (CLIENTE_ID, FECHA_SOLICITUD)
    TABLESPACE VENTA_IDXS_TS;


-- Índice basado en funciones:
-- Este índice busca productos en el inventario por mes y año, usando la función EXTRACT.
CREATE INDEX PET_C_VENTA.INVENTARIO_PRODUCTO_MES_ANIO_IDX 
    ON PET_C_VENTA.INVENTARIO_PRODUCTO (EXTRACT(MONTH FROM FECHA), EXTRACT(YEAR FROM FECHA))
    TABLESPACE VENTA_IDXS_TS;


-- Índice para una consulta frecuente:
-- Este índice busca clientes por su apellido paterno. 
CREATE INDEX PET_C_VENTA.CLIENTE_APELLIDO_PATERNO_IDX
    ON PET_C_VENTA.CLIENTE (AP_PATERNO)
    TABLESPACE VENTA_IDXS_TS;

-- Índice para buscar productos por nombre en el catálogo
CREATE INDEX PET_C_VENTA.CATALOGO_PRODUCTO_NOMBRE_IDX
    ON PET_C_VENTA.CATALOGO_PRODUCTO (NOMBRE)
    TABLESPACE VENTA_IDXS_TS;

-- Índice para buscar productos en inventario por número de inventario 
CREATE INDEX PET_C_VENTA.INVENTARIO_PRODUCTO_NUM_INV_IDX
    ON PET_C_VENTA.INVENTARIO_PRODUCTO (NUM_INVENTARIO)
    TABLESPACE VENTA_IDXS_TS;