connect sys/system as sysdba
alter session set container=petcare_pdb_rh;
connect pet_c_rh/rh123@PDB_RH
whenever sqlerror exit rollback;

insert into ESTILISTA (EMPLEADO_ID, RESENIA) values (1, 'Other juvenile arthritis, knee');
insert into ESTILISTA (EMPLEADO_ID, RESENIA) values (2, 'Unspecified focal traumatic brain injury with loss of consciousness of 6 hours to 24 hours');
insert into ESTILISTA (EMPLEADO_ID, RESENIA) values (3, 'Laceration with foreign body of right shoulder, subsequent encounter');
insert into ESTILISTA (EMPLEADO_ID, RESENIA) values (4, 'Acute hematogenous osteomyelitis, left shoulder');
insert into ESTILISTA (EMPLEADO_ID, RESENIA) values (5, 'Displaced fracture of neck of unspecified talus, subsequent encounter for fracture with routine healing');
insert into ESTILISTA (EMPLEADO_ID, RESENIA) values (6, 'Puncture wound without foreign body of left front wall of thorax with penetration into thoracic cavity, initial encounter');
insert into ESTILISTA (EMPLEADO_ID, RESENIA) values (7, 'Coma scale, eyes open, to sound, unspecified time');
insert into ESTILISTA (EMPLEADO_ID, RESENIA) values (8, 'Open bite of unspecified thumb with damage to nail');
insert into ESTILISTA (EMPLEADO_ID, RESENIA) values (9, 'Abrasion of forearm');
insert into ESTILISTA (EMPLEADO_ID, RESENIA) values (10, 'Corticobasal degeneration');
insert into ESTILISTA (EMPLEADO_ID, RESENIA) values (11, 'Unspecified injury of unspecified part of colon');
insert into ESTILISTA (EMPLEADO_ID, RESENIA) values (12, 'Infective myositis, unspecified hand');
insert into ESTILISTA (EMPLEADO_ID, RESENIA) values (13, 'Toxic effect of nitrogen oxides, assault, subsequent encounter');
insert into ESTILISTA (EMPLEADO_ID, RESENIA) values (14, 'Corrosion of third degree of left elbow');
insert into ESTILISTA (EMPLEADO_ID, RESENIA) values (15, 'Pathological fracture in neoplastic disease, left shoulder, subsequent encounter for fracture with routine healing');
insert into ESTILISTA (EMPLEADO_ID, RESENIA) values (16, 'Rheumatoid heart disease with rheumatoid arthritis of hip');
insert into ESTILISTA (EMPLEADO_ID, RESENIA) values (17, 'Disorders of iris and ciliary body in diseases classified elsewhere');
insert into ESTILISTA (EMPLEADO_ID, RESENIA) values (18, 'Unspecified fracture of upper end of right radius, subsequent encounter for open fracture type IIIA, IIIB, or IIIC with delayed healing');
insert into ESTILISTA (EMPLEADO_ID, RESENIA) values (19, 'Displaced comminuted fracture of shaft of unspecified tibia, subsequent encounter for open fracture type IIIA, IIIB, or IIIC with routine healing');
insert into ESTILISTA (EMPLEADO_ID, RESENIA) values (20, 'Infection and inflammatory reaction due to internal fixation device of unspecified site, sequela');
