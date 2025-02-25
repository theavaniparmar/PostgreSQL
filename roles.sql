--role memebership
create role sales; --group role
grant sales to alice;

grant select on rental to sales;

select count(*) from rental;

revoke sales from alice;

select current_user;

create role bob 
login 
password 'welcome@123';

set role bob;

select current_user;

select session_user;

--listing roles
SELECT usename AS role_name,
  CASE
     WHEN usesuper AND usecreatedb THEN
	   CAST('superuser, create database' AS pg_catalog.text)
     WHEN usesuper THEN
	    CAST('superuser' AS pg_catalog.text)
     WHEN usecreatedb THEN
	    CAST('create database' AS pg_catalog.text)
     ELSE
	    CAST('' AS pg_catalog.text)
  END role_attributes
FROM pg_catalog.pg_user
ORDER BY role_name desc;

SELECT rolname, rolcreaterole FROM pg_roles WHERE rolname = current_user;

ALTER ROLE bob CREATEROLE;
SELECT rolname, rolcreaterole FROM pg_roles WHERE rolname = current_user;

--RLS
create table employees(
id serial primary key,
name varchar,
password text,
);

insert into employees(name,password)
values
('avani', 'welcome'),
('saniya', '123'),
('aman', 'AP');

alter table employees enable row level security;

create policy emp
on employees
for select using(name = current_user);


create role avani superuser login password 'avani123';
create role saniya login password 'saniya123';
create role aman login password 'aman123';

drop role avani;
drop role saniya;

set role avani;
GRANT SELECT ON employees TO avani, saniya, aman;


ALTER TABLE employees FORCE ROW LEVEL SECURITY;


--new one
CREATE TABLE employees1 (
    id SERIAL PRIMARY KEY,
    name TEXT,
    department TEXT,
    salary INT,
    user_name TEXT  -- This will store who owns the row
);

set role postgres;

INSERT INTO employees1 (name, department, salary, user_name) 
VALUES 
    ('Alice', 'HR', 60000, 'alice'),
    ('Bob', 'IT', 70000, 'bob'),
    ('Charlie', 'Finance', 80000, 'charlie');

ALTER TABLE employees ENABLE ROW LEVEL SECURITY;

CREATE POLICY employee_policy 
ON employees1
FOR SELECT 
USING (user_name = current_user);

ALTER TABLE employees1 FORCE ROW LEVEL SECURITY;


drop role alice;
drop role bob;

CREATE ROLE alice LOGIN PASSWORD 'alice123';
CREATE ROLE bob LOGIN PASSWORD 'bob123';
CREATE ROLE charlie LOGIN PASSWORD 'charlie123';

GRANT SELECT ON employees1 TO alice, bob, charlie;

set role postgres;

SET ROLE alice;
SELECT * FROM employees1;


SELECT tablename, tableowner 
FROM pg_tables 
WHERE tablename = 'employees1';

ALTER TABLE employees1 OWNER TO alice;
GRANT ALL PRIVILEGES ON TABLE employees1 TO alice;

select current_user;
select current_schema;







	









