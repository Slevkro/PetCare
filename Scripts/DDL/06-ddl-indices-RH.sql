--@Autor: Jorge Francisco Pereda Ceballos, Brandon Cervantes Rubí,  Alexis Isaac Alcocer Diaz
--@Fecha: 03/11/2024
--@Descripción: Creación de indices para el módulo de RH

Prompt Conectando a petcare_pdb_rh
connect sys/system as sysdba
alter session set container=petcare_pdb_rh;
connect pet_c_rh/rh123@PDB_RH

-- Índices para llaves foráneas
--
-- Índice para EMPLEADO.SUPERVISOR_ID
CREATE INDEX PET_C_RH.EMPLEADO_SUPERVISOR_ID_IDX
    ON PET_C_RH.EMPLEADO (SUPERVISOR_ID)
    TABLESPACE EMPLEADO_IDXS_TS;

-- Índice para CURSO.CATALOGO_CURSO_ID
CREATE INDEX PET_C_RH.CURSO_CATALOGO_CURSO_ID_IDX
    ON PET_C_RH.CURSO (CATALOGO_CURSO_ID)
    TABLESPACE EMPLEADO_IDXS_TS;

-- Índice para CURSO.EMPLEADO_ID
CREATE INDEX PET_C_RH.CURSO_EMPLEADO_ID_IDX
    ON PET_C_RH.CURSO (EMPLEADO_ID)
    TABLESPACE EMPLEADO_IDXS_TS;

-- Índice para VETERINARIA.EMPLEADO_ID
CREATE INDEX PET_C_RH.VETERINARIA_EMPLEADO_ID_IDX
    ON PET_C_RH.VETERINARIA (EMPLEADO_ID)
    TABLESPACE EMPLEADO_IDXS_TS;


-- Índice compuesto:  
-- Este índice  busca por apellido paterno y materno del empleado,  
-- útil para buscar empleados por nombre completo.
CREATE INDEX PET_C_RH.EMPLEADO_NOMBRE_COMPLETO_IDX
    ON PET_C_RH.EMPLEADO (AP_PATERNO, AP_MATERNO)
    TABLESPACE EMPLEADO_IDXS_TS;


-- Índice basado en funciones:
-- Este índice se basa en la función UPPER para buscar empleados sin importar mayúsculas o minúsculas.
CREATE INDEX PET_C_RH.EMPLEADO_NOMBRE_UPPER_IDX 
    ON PET_C_RH.EMPLEADO (UPPER(NOMBRE))
    TABLESPACE EMPLEADO_IDXS_TS;


-- Índice para una consulta frecuente:
-- Este índice podría usarse para una consulta que busca veterinarios titulados en un rango de fechas. 
CREATE INDEX PET_C_RH.VETERINARIO_FECHA_TITULACION_IDX
    ON PET_C_RH.VETERINARIO (FECHA_TITULACION)
    TABLESPACE EMPLEADO_IDXS_TS;

-- Índice para buscar veterinarias por nombre
CREATE INDEX PET_C_RH.VETERINARIA_NOMBRE_IDX
    ON PET_C_RH.VETERINARIA (NOMBRE)
    TABLESPACE EMPLEADO_IDXS_TS;

-- Índice para buscar cursos por fecha
CREATE INDEX PET_C_RH.CURSO_FECHA_IDX
    ON PET_C_RH.CURSO (FECHA)
    TABLESPACE EMPLEADO_IDXS_TS;