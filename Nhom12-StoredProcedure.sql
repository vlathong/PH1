

conn ph1/123;
--3. Tao moi, xoa, sua User/Role
--3.1 Tao User
create or replace procedure sp_CreateUser(user_name in varchar2, password varchar2, tablespace_name varchar2, quota varchar2)
as
temp varchar2(100);
begin
    EXECUTE IMMEDIATE 'ALTER SESSION SET "_ORACLE_SCRIPT" = TRUE';
    temp:= 'CREATE USER ' || user_name || ' IDENTIFIED BY ' || password || ' default tablespace ' || tablespace_name || ' quota ' || quota || ' on ' || tablespace_name;
    EXECUTE IMMEDIATE temp;
    EXECUTE IMMEDIATE 'GRANT CREATE SESION TO '|| user_name;
end;
--3.2. Xoa User
create or replace procedure sp_DeleteUser(user_name in varchar2)
as
begin
    EXECUTE IMMEDIATE 'ALTER SESSION SET "_ORACLE_SCRIPT" = TRUE';
    EXECUTE IMMEDIATE 'DROP USER ' || user_name;
end;
--3.3. Doi Password User
create or replace procedure sp_UpdateUserPassword(user_name in varchar2, new_user_password in varchar2)
as
begin
    EXECUTE IMMEDIATE 'ALTER SESSION SET "_ORACLE_SCRIPT" = TRUE';
    EXECUTE IMMEDIATE 'ALTER USER ' || user_name || ' IDENTIFIED BY ' || new_user_password;
end;
--3.4. Doi Tablespace User
create or replace procedure sp_UpdateUserTablespace(user_name in varchar2, new_tablespace varchar2)
as
temp VARCHAR2(500);
temp1 VARCHAR2(100);
BEGIN
    temp1 := 'ALTER SESSION SET "_ORACLE_SCRIPT" = TRUE';
    EXECUTE IMMEDIATE temp1;
    temp := 'ALTER USER ' || user_name || ' default tablespace ' || new_tablespace;
    EXECUTE IMMEDIATE temp;
END;
--3.5. Doi Quota User
create or replace procedure sp_UpdateUserQuota(user_name in varchar2, new_Quota varchar2, tablespace_name varchar2)
as
temp VARCHAR2(500);
temp1 VARCHAR2(100);
BEGIN
    temp1 := 'ALTER SESSION SET "_ORACLE_SCRIPT" = TRUE';
    EXECUTE IMMEDIATE temp1;
    temp := 'ALTER USER ' || user_name || ' quota ' || new_Quota || ' on ' || tablespace_name;
    EXECUTE IMMEDIATE temp;
END;
--3.6. Tao Role
create or replace procedure sp_CreateRole(role_name in varchar2)
IS
begin
    EXECUTE IMMEDIATE 'ALTER SESSION SET "_ORACLE_SCRIPT" = TRUE';
    EXECUTE IMMEDIATE 'CREATE ROLE ' || role_name;
end;
--3.7. Xoa Role
create or replace procedure sp_DeleteRole(role_name in varchar2)
IS
begin
    EXECUTE IMMEDIATE 'ALTER SESSION SET "_ORACLE_SCRIPT" = TRUE';
    EXECUTE IMMEDIATE 'DROP ROLE ' || role_name;
end;
--4.1 Cap Role cho User
create or replace procedure sp_GrantRoleToUser(user_name in varchar2, role_name in varchar2)
as
temp VARCHAR2(500);
BEGIN
    temp := 'grant ' || role_name || ' TO ' || user_name;
    EXECUTE IMMEDIATE temp;
END;
--4.2. Cap quyen Select
create or replace procedure sp_GrantSelectOnTable(user_name in varchar2, table_name in varchar2, column_name in varchar2, grant_option in int)
as
    temp VARCHAR2(500);
    temp1 VARCHAR2(500);
BEGIN
    temp := 'CREATE or REPLACE VIEW ' || user_name || table_name || ' AS SELECT ' || column_name || ' FROM ' || table_name;
    EXECUTE IMMEDIATE temp;
    if grant_option=0 then
        temp1 := 'GRANT SELECT ON ' || user_name || table_name || ' TO ' || user_name;
    else
        temp1 := 'GRANT SELECT ON ' || user_name || table_name || ' TO ' || user_name || ' with grant option';
    end if;
    EXECUTE IMMEDIATE temp1;
END;
ALTER SESSION SET "_ORACLE_SCRIPT" = TRUE;

--4.3. Cap quyen Update
create or replace NONEDITIONABLE procedure sp_Update(user_name in varchar2, column_name in varchar2, table_name in varchar2, grant_option in int)
as
temp VARCHAR2(500);
BEGIN
    if grant_option=1 then
        temp := 'GRANT UPDATE(' || column_name  || ') ON ' || table_name || ' TO ' || user_name || ' with grant option';
    else
        temp := 'GRANT UPDATE(' || column_name  || ') ON ' || table_name || ' TO ' || user_name;
    end if;
    EXECUTE IMMEDIATE temp;
END;
--exec sp_Update('DUY','HOTEN','NHANVIEN',1)
--4.4. Cap quyen Select tren Table
create or replace procedure sp_prSelect(table_name in varchar2, user_name in varchar2)
as
BEGIN
        EXECUTE IMMEDIATE 'GRANT SELECT ON ' || table_name || ' TO ' || user_name;
END;
--4.5. Cap quyen delete
create or replace procedure sp_Delete(user_name in varchar2, table_name in varchar2, grant_option in int)
as
temp VARCHAR2(500);
BEGIN
    if grant_option=1 then
        temp := 'GRANT DELETE ' || 'ON ' || table_name || ' TO ' || user_name || ' with grant option';
    else
        temp := 'GRANT DELETE ' || 'ON ' || table_name || ' TO ' || user_name;
    end if;
    EXECUTE IMMEDIATE temp;
END;
--exec sp_Delete('DUY','PH1.dichvu',1)
--4.6. Cap quyen Insert
create or replace procedure sp_Insert(user_name in varchar2, table_name in varchar2, grant_option in int)
as
temp VARCHAR2(500);
BEGIN
    if grant_option = 1 then
        temp := 'GRANT INSERT ' || 'ON ' || table_name || ' TO ' || user_name || ' with grant option';
    else
        temp := 'GRANT INSERT ' || 'ON ' || table_name || ' TO ' || user_name;
    end if;
    EXECUTE IMMEDIATE temp;
END;
--5.1. Thu hoi quyen Select
create or replace procedure sp_RevokeSelect(user_name in varchar2, table_name in varchar2)
as
temp VARCHAR2(500);
BEGIN
    temp := 'REVOKE SELECT ' || 'ON ' || table_name || ' from ' || user_name;
    EXECUTE IMMEDIATE temp;
END;
--5.2. Thu hoi quyen Update
create or replace procedure sp_RevokeUpdate(user_name in varchar2, table_name in varchar2)
as
temp VARCHAR2(500);
BEGIN
    temp := 'REVOKE update ' || 'ON ' || table_name || ' from ' || user_name;
    EXECUTE IMMEDIATE temp;
END;
--5.3. Thu hoi quyen Delete
create or replace procedure sp_RevokeDelete(user_name in varchar2, table_name in varchar)
as
temp VARCHAR2(500);
BEGIN
    temp := 'REVOKE delete ' || 'ON ' || table_name || ' from ' || user_name;
    EXECUTE IMMEDIATE temp;
END;
--5.4. Thu hoi quyen Insert
create or replace procedure sp_RevokeInsert(user_name in varchar2, table_name in varchar2)
as
temp VARCHAR2(500);
BEGIN
    temp := 'REVOKE insert ' || 'ON ' || table_name || ' from ' || user_name;
    EXECUTE IMMEDIATE temp;
END;
--6.1. Kiem tra quyen cua User tren cot
create or replace procedure sp_CheckUserPrivilegeOnCollumn(user_name varchar2)
as
    temp sys_refcursor;
begin
    open temp for
        SELECT GRANTEE, TABLE_NAME, COLUMN_NAME, PRIVILEGE, GRANTABLE FROM USER_COL_PRIVS where grantee = user_name;
    DBMS_SQL.RETURN_RESULT(temp);
end;
--6.2. Kiem tra quyen cua User tren bang
create or replace procedure sp_CheckUserPrivilegeOnTable(user_name varchar2)
as
    temp sys_refcursor;
begin
    open temp for
        SELECT GRANTEE, TABLE_NAME, PRIVILEGE, GRANTABLE FROM USER_TAB_PRIVS where grantee = user_name;
    DBMS_SQL.RETURN_RESULT(temp);
end;
--6.3. Kiem tra quyen cua Role tren Bang
create or replace procedure sp_CheckRolePrivilegeOnTable(role_name varchar2)
as
    temp sys_refcursor;
begin
    open temp for
        SELECT ROLE, TABLE_NAME, COLUMN_NAME, PRIVILEGE, GRANTABLE FROM ROLE_TAB_PRIVS where ROLE = role_name;
    DBMS_SQL.RETURN_RESULT(temp);
end;
--7.1. Chinh sua quyen Update tren Cot
create or replace procedure sp_ModifyUpdate(user_name in varchar2, column_name in varchar2, table_name in varchar2, grant_option in int)
as
temp VARCHAR2(500);
BEGIN
    sp_RevokeUpdate(user_name,table_name);
    if grant_option=1 then
        temp := 'GRANT UPDATE(' || column_name  || ') ON ' || table_name || ' TO ' || user_name || ' with grant option';
    else
        temp := 'GRANT UPDATE(' || column_name  || ') ON ' || table_name || ' TO ' || user_name;
    end if;
    EXECUTE IMMEDIATE temp;
END;
--7.2. Chinh sua quyen Insert tren Bang
create or replace procedure sp_ModifyInsert(user_name in varchar2, table_name in varchar2, grant_option in int)
as
temp VARCHAR2(500);
BEGIN
    sp_RevokeInsert(user_name,table_name);
    if grant_option=1 then
        temp := 'GRANT INSERT ' || 'ON ' || table_name || ' TO ' || user_name || ' with grant option';
    else
        temp := 'GRANT INSERT ' || 'ON ' || table_name || ' TO ' || user_name;
    end if;
    EXECUTE IMMEDIATE temp;
END;
--7.3. Chinh sua quyen Delete tren Bang
create or replace procedure sp_ModifyDelete(user_name in varchar2, table_name in varchar2, grant_option in int)
as
temp VARCHAR2(500);
BEGIN
    sp_RevokeDelete(user_name,table_name);
    if grant_option=1 then
        temp := 'GRANT DELETE ' || 'ON ' || table_name || ' TO ' || user_name || ' with grant option';
    else
        temp := 'GRANT DELETE ' || 'ON ' || table_name || ' TO ' || user_name;
    end if;
    EXECUTE IMMEDIATE temp;
END;
--7.4. Chinh sua quyen Select tren Cot
create or replace procedure sp_ModifySelect(user_name in varchar2, table_name in varchar2, column_name in varchar2, grant_option in int)
as
    temp VARCHAR2(500);
    temp1 VARCHAR2(500);
BEGIN
    sp_RevokeSelect(user_name, user_name || table_name);
    temp := 'CREATE or REPLACE VIEW ' || user_name || table_name || ' AS SELECT ' || column_name || ' FROM ' || table_name;
    EXECUTE IMMEDIATE temp;
    if grant_option=0 then
        temp1 := 'GRANT SELECT ON ' || user_name || table_name || ' TO ' || user_name;
    else
        temp1 := 'GRANT SELECT ON ' || user_name || table_name || ' TO ' || user_name || ' with grant option';
    end if;
    EXECUTE IMMEDIATE temp1;
END;