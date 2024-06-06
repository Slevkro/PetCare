

Prompt iniciar bcrdip05
!sh s-030-start-cdb.sh petcare systemcdb

Prompt conectando petcare
connect sys/systemcdb@petcare as sysdba

Prompt Configurando OMF

alter system set db_create_file_dest='+VENTA' scope=memory; 

Prompt crear PDB petcare_pdb_venta

create pluggable database petcare_pdb_venta
 admin user admin_venta identified by admin;

Prompt Abrir  petcare_pdb_venta
alter pluggable database petcare_pdb_venta open read write;

Prompt Iniciando limpieza 
alter pluggable database petcare_pdb_venta close;
drop pluggable database petcare_pdb_venta including datafiles;