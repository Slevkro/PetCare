set serveroutput on 
whenever sqlerror exit rollback;
create or replace procedure p_crea_usuario(p_username in  varchar2) is 
v_count number;
begin
  select count(*) into v_count from all_users where username= UPPER(p_username);

    if v_count >0 then
        execute immediate 'drop user '|| p_username || ' cascade';
    else
        dbms_output.put_line('El usuario ' || p_username  || ' no existe');
    end if;

 execute immediate 'create user ' || p_username || ' identified by ' || p_username || ' quota unlimited on users';
end;
/

show errors