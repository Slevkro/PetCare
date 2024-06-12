--@Autor: Jorge Francisco Pereda Ceballos / Brandon Cervantes Rubí / Alexis Isaac Alcocer Diaz
--@Fecha: 03/11/2024
--@Descripción: DDL para creación de tablas para el módulo SERVICIOS

Prompt Creando TABLAS para el modulo de SERVICIO
Prompt conectando a petcare_pdb_servicio
alter session set container=petcare_pdb_servicio;

--------------------- TABLAS DE SERVICIO ----------------------------

-- 
-- TABLE: CATALOGO_DIAGNOSTICO 
--
CREATE TABLE PET_C_SERVICIO.CATALOGO_DIAGNOSTICO(
    CATALOGO_DIAGNOSTICO_ID    NUMBER(10, 0)    NOT NULL,
    CLAVE                      CHAR(10),
    NIVEL_GRAVEDAD             NUMBER(1, 0)     NOT NULL,
    COSTO                      NUMBER(8, 2)     NOT NULL,
    NOMBRE                     VARCHAR2(40)     NOT NULL,
    DESCRIPCION                VARCHAR2(100)    NOT NULL,
    CONSTRAINT CATALOGO_DIAGNOSTICO_PK PRIMARY KEY (CATALOGO_DIAGNOSTICO_ID)
    USING INDEX  TABLESPACE SERVICIO_IDXS_TS
) TABLESPACE SERVICIO_TS
;


-- 
-- TABLE: SERVICIO 
--

CREATE TABLE PET_C_SERVICIO.SERVICIO(
    SERVICIO_ID    NUMBER(10, 0)    NOT NULL,
    ES_MEDICO      CHAR(1)          NOT NULL,
    ES_PASEO       CHAR(1)          NOT NULL,
    ES_ESTETICA    CHAR(1)          NOT NULL,
    CONSTRAINT SERVICIO_PK PRIMARY KEY (SERVICIO_ID)
    USING INDEX TABLESPACE SERVICIO_IDXS_TS      
) TABLESPACE SERVICIO_TS
;

-- 
-- TABLE: GALERIA_ESTETICA 
--

CREATE TABLE PET_C_SERVICIO.GALERIA_ESTETICA(
    GALERIA_ESTETICA_ID    NUMBER(10, 0)    NOT NULL,
    SERVICIO_ID            NUMBER(10, 0),
    EVIDENCIA              BLOB,
    CONSTRAINT GALERIA_ESTETICA_PK PRIMARY KEY (GALERIA_ESTETICA_ID) 
    USING INDEX TABLESPACE SERVICIO_IDXS_TS,        
    CONSTRAINT SERVICIO_GALERIA_ESTETICA_SERVICIO_ID_FK  FOREIGN KEY (SERVICIO_ID)
    REFERENCES PET_C_SERVICIO.SERVICIO(SERVICIO_ID)    
) TABLESPACE SERVICIO_TS
LOB (EVIDENCIA) STORE AS SECUREFILE (TABLESPACE SERVICIO_LOB_TS)
;

TABLE: GALERIA_MASCOTA 


CREATE TABLE PET_C_SERVICIO.GALERIA_MASCOTA(
    GALERIA_MASCOTA_ID    NUMBER(10, 0)    NOT NULL,
    FOTO                  BLOB             NOT NULL,
    MASCOTA_ID            NUMBER(10, 0)    NOT NULL,
    CONSTRAINT GALERIA_MASCOTA_PK PRIMARY KEY (GALERIA_MASCOTA_ID)
    USING INDEX TABLESPACE SERVICIO_IDXS_TS
) TABLESPACE SERVICIO_TS
LOB (FOTO) STORE AS SECUREFILE (TABLESPACE SERVICIO_LOB_TS)
;

-- 
-- TABLE: MASCOTA 
--

CREATE TABLE PET_C_SERVICIO.MASCOTA(
    MASCOTA_ID          NUMBER(10, 0)    NOT NULL,
    RAZA                VARCHAR2(20)     NOT NULL,
    PESO                VARCHAR2(2)      NOT NULL,
    RASGOS              VARCHAR2(40),
    NOMBRE              VARCHAR2(40)     NOT NULL,
    EDAD                NUMBER(2, 0)     NOT NULL,
    FECHA_NACIMIENTO    DATE             NOT NULL,
    CONSTRAINT MASCOTA_PK PRIMARY KEY (MASCOTA_ID)
    USING INDEX TABLESPACE SERVICIO_IDXS_TS
) TABLESPACE SERVICIO_TS
;


-- 
-- TABLE: ESTETICA 
--

CREATE TABLE PET_C_SERVICIO.ESTETICA(
    SERVICIO_ID    NUMBER(10, 0)    NOT NULL,
    PRECIO         NUMBER(10, 0)    NOT NULL,
    FECHA          DATE             NOT NULL,
    DESCRIPCION    BLOB             NOT NULL,
    EMPLEADO_ID    NUMBER(10, 0)    NOT NULL,
    MASCOTA_ID     NUMBER(10, 0)    NOT NULL,
    CONSTRAINT ESTETICA_PK PRIMARY KEY (SERVICIO_ID)  USING INDEX TABLESPACE SERVICIO_IDXS_TS,      
    CONSTRAINT SERVICIO_ESTETICA_SERVICIO_ID_FK  FOREIGN KEY (SERVICIO_ID)
    REFERENCES PET_C_SERVICIO.SERVICIO(SERVICIO_ID),        
    CONSTRAINT MASCOTA_ESTETICA_MASCOTA_ID_FK  FOREIGN KEY (MASCOTA_ID)
    REFERENCES PET_C_SERVICIO.MASCOTA(MASCOTA_ID)
) TABLESPACE SERVICIO_TS
LOB (DESCRIPCION) STORE AS SECUREFILE (TABLESPACE SERVICIO_LOB_TS)
;





-- 
-- TABLE: MEDICO 
--

CREATE TABLE PET_C_SERVICIO.MEDICO(
    SERVICIO_ID                NUMBER(10, 0)    NOT NULL,
    FECHA_REVISION             DATE             NOT NULL,
    DESCRIPCION_PROBLEMA       VARCHAR2(100)    NOT NULL,
    COSTO                      NUMBER(10, 2),
    MASCOTA_ID                 NUMBER(10, 0)    NOT NULL,
    CATALOGO_DIAGNOSTICO_ID    NUMBER(10, 0)    NOT NULL,
    EMPLEADO_ID                NUMBER(10, 0)    NOT NULL,
    CONSTRAINT MEDICO_PK PRIMARY KEY (SERVICIO_ID)
    USING INDEX TABLESPACE SERVICIO_IDXS_TS,        
    CONSTRAINT SERVICIO_MEDICO_SERVICIO_ID_FK  FOREIGN KEY (SERVICIO_ID)
    REFERENCES PET_C_SERVICIO.SERVICIO(SERVICIO_ID),            
    CONSTRAINT CATALOGO_DIAGNOSTICO_MEDICO_CATALOGO_DIAGNOSTICO_ID_FK  FOREIGN KEY (CATALOGO_DIAGNOSTICO_ID)
    REFERENCES PET_C_SERVICIO.CATALOGO_DIAGNOSTICO(CATALOGO_DIAGNOSTICO_ID),        
    CONSTRAINT MASCOTA_MEDICO_MASCOTA_ID_FK  FOREIGN KEY (MASCOTA_ID)
    REFERENCES PET_C_SERVICIO.MASCOTA(MASCOTA_ID)
) TABLESPACE SERVICIO_TS
;



-- 
-- TABLE: PASEO 
--

CREATE TABLE PET_C_SERVICIO.PASEO(
    SERVICIO_ID     NUMBER(10, 0)    NOT NULL,
    FECHA_INICIO    TIMESTAMP(6)     NOT NULL,
    FECHA_FIN       TIMESTAMP(6)     NOT NULL,
    EMPLEADO_ID     NUMBER(10, 0)    NOT NULL,
    CONSTRAINT PASEO_PK PRIMARY KEY (SERVICIO_ID)
    USING INDEX TABLESPACE SERVICIO_IDXS_TS,        
    CONSTRAINT SERVICIO_PASEO_SERVICIO_ID_FK  FOREIGN KEY (SERVICIO_ID)
    REFERENCES PET_C_SERVICIO.SERVICIO(SERVICIO_ID)
) TABLESPACE SERVICIO_TS
;



-- 
-- TABLE: PASEO_MASCOTA 
--

CREATE TABLE PET_C_SERVICIO.PASEO_MASCOTA(
    PASEO_MASCOTA_ID    NUMBER(10, 0)    NOT NULL,
    COSTO               NUMBER(10, 2),
    SERVICIO_ID         NUMBER(10, 0)    NOT NULL,
    MASCOTA_ID          NUMBER(10, 0)    NOT NULL,
    CONSTRAINT PASEO_MASCOTA_PK PRIMARY KEY (PASEO_MASCOTA_ID)
    USING INDEX TABLESPACE SERVICIO_IDXS_TS,            
    CONSTRAINT SERVICIO_PASEO_MASCOTA_SERVICIO_ID_FK  FOREIGN KEY (SERVICIO_ID)
    REFERENCES PET_C_SERVICIO.SERVICIO(SERVICIO_ID),        
    CONSTRAINT MASCOTA_PASEO_MASCOTA_MASCOTA_ID_FK  FOREIGN KEY (MASCOTA_ID)
    REFERENCES PET_C_SERVICIO.MASCOTA(MASCOTA_ID)        
) TABLESPACE SERVICIO_TS
;




-- 
-- TABLE: UBICACION_EMPLEADO 
--

CREATE TABLE PET_C_SERVICIO.UBICACION_EMPLEADO(
    UBICACION_EMPLEADO_ID    NUMBER(10, 0)    NOT NULL,
    FECHA                    DATE             NOT NULL,
    HORA                     NUMBER(2, 0)     NOT NULL,
    SEGUNDO                  NUMBER(10, 0)    NOT NULL,
    MINUTO                   NUMBER(2, 0)             NOT NULL,
    LATITUD                  VARCHAR2(10)     NOT NULL,
    LONGITUD                 VARCHAR2(10)     NOT NULL,
    SERVICIO_ID              NUMBER(10, 0)    NOT NULL,
    CONSTRAINT UBICACION_EMPLEADO_PK PRIMARY KEY (UBICACION_EMPLEADO_ID)
    USING INDEX TABLESPACE SERVICIO_IDXS_TS,        
    CONSTRAINT SERVICIO_UBICACION_EMPLEADO_SERVICIO_ID_FK  FOREIGN KEY (SERVICIO_ID)
    REFERENCES PET_C_SERVICIO.PASEO(SERVICIO_ID)       
) TABLESPACE SERVICIO_TS
;



