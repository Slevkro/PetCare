connect sys/system as sysdba
alter session set container=petcare_pdb_venta;
connect pet_c_venta/venta123@PDB_VENTA
whenever sqlerror exit rollback;

insert into PET_C_VENTA.CATALOGO_CATEGORIA (CATALOGO_CATEGORIA_ID, NOMBRE, CATEGORIA) values (1, 'Books', 'Fusion of Cervical Vertebral Joint, Posterior Approach, Anterior Column, Open Approach');
insert into PET_C_VENTA.CATALOGO_CATEGORIA (CATALOGO_CATEGORIA_ID, NOMBRE, CATEGORIA) values (2, 'Shoes', 'Insertion of Stimulator Lead into Left Internal Carotid Artery, Percutaneous Endoscopic Approach');
insert into PET_C_VENTA.CATALOGO_CATEGORIA (CATALOGO_CATEGORIA_ID, NOMBRE, CATEGORIA) values (3, 'Garden', 'Occlusion of Left Lower Lobe Bronchus with Intraluminal Device, Percutaneous Endoscopic Approach');
insert into PET_C_VENTA.CATALOGO_CATEGORIA (CATALOGO_CATEGORIA_ID, NOMBRE, CATEGORIA) values (4, 'Automotive', 'Supplement Ulnar Nerve with Autologous Tissue Substitute, Percutaneous Approach');
insert into PET_C_VENTA.CATALOGO_CATEGORIA (CATALOGO_CATEGORIA_ID, NOMBRE, CATEGORIA) values (5, 'Computers', 'Drainage of Uterine Supporting Structure, Percutaneous Approach, Diagnostic');
insert into PET_C_VENTA.CATALOGO_CATEGORIA (CATALOGO_CATEGORIA_ID, NOMBRE, CATEGORIA) values (6, 'Beauty', 'Insertion of Internal Fixation Device into Lumbar Vertebral Joint, Percutaneous Endoscopic Approach');
insert into PET_C_VENTA.CATALOGO_CATEGORIA (CATALOGO_CATEGORIA_ID, NOMBRE, CATEGORIA) values (7, 'Toys', 'Release Left Nipple, Percutaneous Approach');
insert into PET_C_VENTA.CATALOGO_CATEGORIA (CATALOGO_CATEGORIA_ID, NOMBRE, CATEGORIA) values (8, 'Electronics', 'Abortion of Products of Conception, Percutaneous Approach');