--@Autor: Jorge Francisco Pereda Ceballos/ Brandon Cervantes Rubí / Alexis Isaac Alcocer Diaz
--@Fecha creación: 03/06/2024
--@Descripción: Creación de usuarios para cada pdb.

clear screen
prompt Inciando creacion/eliminacion de usuarios.
prompt =====================================
prompt Creando usuario en petcare_venta
prompt =====================================
prompt Conectándose a pc_rh como usuario SYS
connect sys/system@petcare_venta as sysdba

@p-crea-usuario.sql

DECLARE
  v_tablespaces dbms_sql.varchar2_table;
BEGIN
  v_tablespaces(1) := 'VENTA_TS';
  v_tablespaces(2) := 'VENTA_IDXS_TS';
  v_tablespaces(3) := 'VENTA_TEMP_TS';
 
  exec p_crea_usuario('pc_venta', v_tablespaces);
END;
/

prompt Asignando privilegios a pc_venta
grant create type,create any directory,create database link,create trigger, 
create synonym, create view, create table, create session, 
create sequence, create procedure to pc_venta;


prompt =====================================
prompt Creando usuario en petcare_rh
prompt =====================================
prompt Conectándose a pc_rh como usuario SYS
connect sys/system@pc_rh as sysdba

@p-crea-usuario.sql


DECLARE
  v_tablespaces dbms_sql.varchar2_table;
BEGIN
  v_tablespaces(1) := 'EMPLEADO_TS';
  v_tablespaces(2) := 'EMPLEADO_IDXS_TS';
  v_tablespaces(3) := 'EMPLEADO_TEMP_TS';
  v_tablespaces(4) := 'EMPLEADO_LOB_TS';
 
  exec p_crea_usuario('pc_rh', v_tablespaces);
END;
/


prompt Asignando privilegios a netmax_bdd
grant create type,create any directory,create database link,create trigger, 
create synonym, create view, create table, create session, 
create sequence, create procedure to pc_venta;


prompt =====================================
prompt Creando usuario en pc_servicio
prompt =====================================
prompt Conectándose a pc_servicio como usuario SYS
connect sys/system@pc_servicio as sysdba

@p-crea-usuario.sql


DECLARE
  v_tablespaces dbms_sql.varchar2_table;
BEGIN
  v_tablespaces(1) := 'SERVICIO_TS';
  v_tablespaces(2) := 'SERVICIO_IDXS_TS';
  v_tablespaces(3) := 'SERVICIO_TEMP_TS';
   v_tablespaces(3) := 'SERVICIO_LOB_TS';

  exec p_crea_usuario('pc_servicio', v_tablespaces);
END;
/


prompt Asignando privilegios a pc_servicio
grant create type,create any directory,create database link,create trigger, 
create synonym, create view, create table, create session, 
create sequence, create procedure to pc_servicio;

prompt Listo!

  --CREAR PDB BASE 
  --ASIGNAR EN DEST +ASM
  --DEWNTRO DE LA PDB SE ASIGNA EN NUEVO GRUPO 