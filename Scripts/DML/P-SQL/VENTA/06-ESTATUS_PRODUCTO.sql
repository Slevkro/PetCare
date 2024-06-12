connect sys/system as sysdba
alter session set container=petcare_pdb_venta;
connect pet_c_venta/venta123@PDB_VENTA
whenever sqlerror exit rollback;

insert into ESTATUS_PRODUCTO (ESTATUS_PRODUCTO_ID, VALOR, FECHA_ESTATUS) values (1, 'en_inventario', to_date('19/05/2023', 'dd/mm/yyyy'));
insert into ESTATUS_PRODUCTO (ESTATUS_PRODUCTO_ID, VALOR, FECHA_ESTATUS) values (2, 'vendido', to_date('19/05/2023', 'dd/mm/yyyy'));
insert into ESTATUS_PRODUCTO (ESTATUS_PRODUCTO_ID, VALOR, FECHA_ESTATUS) values (3, 'caduco', to_date('19/05/2023', 'dd/mm/yyyy'));
insert into ESTATUS_PRODUCTO (ESTATUS_PRODUCTO_ID, VALOR, FECHA_ESTATUS) values (4, 'retirado', to_date('19/05/2023', 'dd/mm/yyyy'));