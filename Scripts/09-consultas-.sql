
--@Autor: Jorge Francisco Pereda Ceballos/ Brandon Cervantes Rubí / Alexis Isaac Alcocer Diaz
--@Fecha creación: 03/06/2024
--@Descripción: Consultas necesarias para validar ciertos aspectos de la base.


--Consulta que muestre la distribución de todos sus datafiles
SELECT * FROM dba_data_files;

--Consulta que muestre las ubicaciones de los grupos de Redo Logs
SELECT * FROM v$logfile;

--Preparar una consulta que muestre las ubicaciones de los archive Redo logs
SELECT 
    name AS archive_log_file,
    FIRST_CHANGE# AS first_change,
    NEXT_CHANGE# AS next_change,
    SEQUENCE# AS sequence
FROM 
    v$archived_log;

--Preparar una consulta que muestre la configuración y uso de la FRA
SELECT * FROM v$recovery_area_usage;


--Preparar una consulta que muestre un resumen simple de los backups realizados
SELECT * FROM  v$backup_set;

--Preparar una consulta que muestre la cantidad en MB que se han almacenado 
--para los diferentes segmentos de la base de datos. Se deberá realizar una
-- consulta por PDB.
alter session set container=petcare_pdb_rh;

SELECT 
    s.segment_type,
    SUM(s.bytes) / 1024 / 1024 AS size_mb
FROM 
    dba_segments s
GROUP BY 
    s.segment_type
ORDER BY 
    s.segment_type;

alter session set container=petcare_pdb_venta;

SELECT 
    s.segment_type,
    SUM(s.bytes) / 1024 / 1024 AS size_mb
FROM 
    dba_segments s
GROUP BY 
    s.segment_type
ORDER BY 
    s.segment_type;

alter session set container=petcare_pdb_servicio;

SELECT 
    s.segment_type,
    SUM(s.bytes) / 1024 / 1024 AS size_mb
FROM 
    dba_segments s
GROUP BY 
    s.segment_type
ORDER BY 
    s.segment_type;