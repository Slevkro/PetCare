
--@Autor: Jorge Francisco Pereda Ceballos/ Brandon Cervantes Rubí / Alexis Isaac Alcocer Diaz
--@Fecha creación: 03/06/2024
--@Descripción: Creación de tablespaces para cada pdb.

whenever sqlerror exit rollback;
connect sys/system as sysdba

Prompt conectando a petcare_pdb_venta
alter session set container=petcare_pdb_venta;
startup

Prompt Configurando OMF
alter system set db_create_file_dest='+VENTA_TS' scope=memory;
create tablespace venta_ts datafile size 20m autoextend on next 15m;
Prompt Configurando OMF
alter system set db_create_file_dest='+VENTA_AUX' scope=memory;
create tablespace venta_idxs_ts datafile size 10m autoextend on next 5m;
create temporary tablespace venta_temp_ts tempfile size 15m autoextend on next 10m;

Prompt conectando a petcare_pdb_servicio
alter session set container=petcare_pdb_servicio;
startup

Prompt Configurando OMF
alter system set db_create_file_dest='+SERVICIO_TS' scope=memory;
create tablespace servicio_ts datafile size 20m autoextend on next 15m;
Prompt Configurando OMF
alter system set db_create_file_dest='+SERVICIO_LOB' scope=memory;
create tablespace servicio_lob_ts datafile size 100m autoextend on next 50m;
Prompt Configurando OMF
alter system set db_create_file_dest='+SERVICIO_AUX' scope=memory;
create tablespace servicio_idxs_ts datafile size 10m autoextend on next 5m;
create temporary tablespace servicio_temp_ts tempfile size 15m autoextend on next 10m;

Prompt conectando a petcare_pdb_rh
alter session set container=petcare_pdb_rh;
startup

Prompt Configurando OMF
alter system set db_create_file_dest='+EMPLEADO_TS' scope=memory;
create tablespace empleado_ts datafile size 20m autoextend on next 15m;
Prompt Configurando OMF
alter system set db_create_file_dest='+EMPLEADO_LOB' scope=memory;
create tablespace empleado_lob_ts datafile size 100m autoextend on next 50m;
Prompt Configurando OMF
alter system set db_create_file_dest='+EMPLEADO_AUX' scope=memory;
create tablespace empleado_idxs_ts datafile size 10m autoextend on next 5m;
create temporary tablespace empleado_temp_ts tempfile size 15m autoextend on next 10m;



-- Para eliminar algun tablespace  
-- drop tablespace venta_ts including contents and datafiles;



