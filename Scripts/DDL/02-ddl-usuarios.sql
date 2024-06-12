--@Autor: Jorge Francisco Pereda Ceballos/ Brandon Cervantes Rubí / Alexis Isaac Alcocer Diaz
--@Fecha creación: 03/06/2024
--@Descripción: Creación de tablespaces para cada pdb.


--@Autor: Jorge Francisco Pereda Ceballos/ Brandon Cervantes Rubí / Alexis Isaac Alcocer Diaz
--@Fecha creación: 03/06/2024
--@Descripción: Creación de tablespaces para cada pdb.

--whenever sqlerror exit rollback;

Prompt Creando usuario para el modulo de VENTA
Prompt conectando a petcare_pdb_venta
connect sys/system as sysdba
alter session set container=petcare_pdb_venta;
--startup

drop user pet_c_venta cascade;
create user pet_c_venta identified by venta123
  default tablespace venta_ts
  temporary tablespace venta_temp_ts
  quota unlimited on venta_idxs_ts
  quota unlimited on venta_ts
  ;

grant create session, create table, create any index to pet_c_venta;
grant sysbackup to pet_c_venta;

--drop user backup_usr cascade;
--create user backup_usr identified by backup123 
--  quota unlimited on users;

Prompt Creando usuario para el modulo de Servicio 
Prompt conectando a petcare_pdb_servicio
connect sys/system as sysdba
alter session set container=petcare_pdb_servicio;
--startup

drop user pet_c_servicio cascade;
create user pet_c_servicio identified by servicio123 
  default tablespace servicio_ts
  temporary tablespace servicio_temp_ts
  quota unlimited on servicio_idxs_ts
  quota unlimited on servicio_lob_ts
  quota unlimited on servicio_ts;


grant create session, create table, create any index to pet_c_servicio;
grant sysbackup to pet_c_servicio;

Prompt Creando usuario para el modulo de RH 
Prompt conectando a petcare_pdb_rh
connect sys/system as sysdba
alter session set container=petcare_pdb_rh;
--startup

drop user pet_c_rh cascade;
create user pet_c_rh identified by rh123 
  default tablespace empleado_ts
  temporary tablespace empleado_temp_ts
  quota unlimited on empleado_idxs_ts
  quota unlimited on empleado_lob_ts
  quota unlimited on empleado_ts;

grant create session, create table, create any index to pet_c_rh;
grant sysbackup to pet_c_rh;



-- Para eliminar algun tablespace  
-- drop tablespace venta_ts including contents and datafiles;
-- select username from dba_users;



