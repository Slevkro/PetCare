--@Autor: Jorge Francisco Pereda Ceballos, Brandon Cervantes Rubí,  Alexis Isaac Alcocer Diaz
--@Fecha: 03/11/2024
--@Descripción: Procedimiento encargado de creación de usuarios con multiples tablespaces
set serveroutput on 
whenever sqlerror exit rollback;
create or replace procedure p_crea_usuario(
  p_username in varchar2, 
  p_tablespaces IN dbms_sql.varchar2_table
) is 
  v_count number;
  v_sql_stmt varchar2(2000);
  v_tablespace varchar2(30);
  v_temp_tablespace varchar2(30); 
begin
  select count(*) into v_count from all_users where username = UPPER(p_username);

  if v_count > 0 then
    execute immediate 'drop user ' || p_username || ' cascade';
  end if;

  v_sql_stmt := 'create user ' || p_username || ' identified by ' || p_username;

  v_temp_tablespace := NULL; 
  FOR i IN 1 .. p_tablespaces.COUNT LOOP
    IF p_tablespaces(i) LIKE '%_TEMP_TS' THEN
      v_temp_tablespace := p_tablespaces(i);
      EXIT; 
    END IF;
  END LOOP;

  FOR i IN 1 .. p_tablespaces.COUNT LOOP
    v_tablespace := p_tablespaces(i);

    IF i = 1 THEN
      v_sql_stmt := v_sql_stmt || ' default tablespace ' || v_tablespace;
    ELSIF v_tablespace = v_temp_tablespace THEN
      v_sql_stmt := v_sql_stmt || ' temporary tablespace ' || v_temp_tablespace; 
    ELSIF v_tablespace != v_temp_tablespace THEN 
      v_sql_stmt := v_sql_stmt || ' quota unlimited on ' || v_tablespace;
    END IF;
  END LOOP;

  execute immediate v_sql_stmt;
  
  dbms_output.put_line('Usuario ' || p_username || ' creado correctamente.');

exception
  WHEN OTHERS THEN
    dbms_output.put_line('Error al crear el usuario ' || p_username || ': ' || SQLERRM);
    rollback;
end;
/