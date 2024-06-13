
--@Autor: Jorge Francisco Pereda Ceballos/ Brandon Cervantes Rubí / Alexis Isaac Alcocer Diaz
--@Fecha creación: 03/06/2024
--@Descripción: Consultas necesarias para validar ciertos aspectos de la base.
set linesize window

--Consulta que muestre la distribución de todos sus datafiles
Prompt TABLESPACES
col FILE_NAME format a30
col TABLESPACE_NAME format a20

Prompt Para la CDB 
connect sys/system as sysdba
SELECT * FROM dba_data_files;

Prompt Para la PDB RH
alter session set container=petcare_pdb_rh;
SELECT * FROM dba_data_files;

Prompt Para la PDB SERVICIO
alter session set container=petcare_pdb_servicio;
SELECT * FROM dba_data_files;

Prompt Para la PDB VENTA
alter session set container=petcare_pdb_venta;
SELECT * FROM dba_data_files;

--Consulta que muestre las ubicaciones de los grupos de Redo Logs [ME PARECE QUE LOS REDO SE GUARDAN A NIVEL DE CDB]
col MEMBER format a20
Prompt Para la CDB 
connect sys/system as sysdba
SELECT * FROM v$logfile;

/* Prompt Para la PDB RH
alter session set container=petcare_pdb_rh;
SELECT * FROM v$logfile;

Prompt Para la PDB SERVICIO
alter session set container=petcare_pdb_servicio;
SELECT * FROM v$logfile;

Prompt Para la PDB VENTA
alter session set container=petcare_pdb_venta;
SELECT * FROM v$logfile; */

--Preparar una consulta que muestre las ubicaciones de los archive Redo logs
col archive_log_file format a40

Prompt Para la CDB 
connect sys/system as sysdba
SELECT 
    name AS archive_log_file,
    FIRST_CHANGE# AS first_change,
    NEXT_CHANGE# AS next_change,
    SEQUENCE# AS sequence
FROM 
    v$archived_log;

--Preparar una consulta que muestre la configuración y uso de la FRA
Prompt Para la CDB 
connect sys/system as sysdba
SELECT * FROM v$recovery_area_usage;


--Preparar una consulta que muestre un resumen simple de los backups realizados
Prompt Para la CDB 
connect sys/system as sysdba
SELECT * FROM  v$backup_set;

--Preparar una consulta que muestre la cantidad en MB que se han almacenado 
--para los diferentes segmentos de la base de datos. Se deberá realizar una
-- consulta por PDB.
alter session set container=petcare_pdb_rh;
connect pet_c_rh/rh123@PDB_RH

SELECT 
    s.segment_type,
    SUM(s.bytes) / 1024 / 1024 AS size_mb
FROM 
    user_segments s
GROUP BY 
    s.segment_type
ORDER BY 
    s.segment_type;

alter session set container=petcare_pdb_venta;
connect pet_c_venta/venta123@PDB_VENTA

SELECT 
    s.segment_type,
    SUM(s.bytes) / 1024 / 1024 AS size_mb
FROM 
    user_segments s
GROUP BY 
    s.segment_type
ORDER BY 
    s.segment_type;

alter session set container=petcare_pdb_servicio;
connect pet_c_servicio/servicio123@PDB_SERVICIO

SELECT 
    s.segment_type,
    SUM(s.bytes) / 1024 / 1024 AS size_mb
FROM 
    user_segments s
GROUP BY 
    s.segment_type
ORDER BY 
    s.segment_type;


-- CONTROL FILES MULTIPLEXADOS
show parameter control_file

-- MODO ARCHIVED
archive log list

-- Una copia de los archived Redo Logs deberá ubicarse en la FRA
col DEST_NAME format a40
col DESTINATION format a40
select DEST_NAME, DESTINATION from v$archive_dest;