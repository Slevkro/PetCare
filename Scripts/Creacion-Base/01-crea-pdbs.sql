

Prompt iniciar petcare
!sh s-030-start-cdb.sh petcare02 system

Prompt conectando petcare
connect sys/system@petcare02 as sysdba

Prompt crear PDB petcare_pdb_venta
Prompt Configurando OMF
alter system set db_create_file_dest='+VENTA' scope=memory; 
create pluggable database petcare_pdb_venta admin user admin_venta identified by admin;

Prompt crear PDB petcare_pdb_rh
Prompt Configurando OMF
alter system set db_create_file_dest='+RH' scope=memory; 
create pluggable database petcare_pdb_rh admin user admin_rh identified by admin;

Prompt crear PDB petcare_pdb_servicio
Prompt Configurando OMF
alter system set db_create_file_dest='+SERVICIO' scope=memory; 
create pluggable database petcare_pdb_servicio admin user admin_servicio identified by admin;

Prompt Abrir  petcare_pdb_venta
alter pluggable database petcare_pdb_venta open read write;

Prompt Abrir  petcare_pdb_rh
alter pluggable database petcare_pdb_rh open read write;

Prompt Abrir  petcare_pdb_servicio
alter pluggable database petcare_pdb_servicio open read write;

/* Prompt Iniciando limpieza 
alter pluggable database petcare_pdb_venta close;
drop pluggable database petcare_pdb_venta including datafiles;

alter pluggable database petcare_pdb_rh close;
drop pluggable database petcare_pdb_rh including datafiles;

alter pluggable database petcare_pdb_venta close;
drop pluggable database petcare_pdb_venta including datafiles; */