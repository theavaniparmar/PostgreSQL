--new database
create database sampledb;

alter database sampledb
rename to sample_db;

--role

alter database sample_db
owner to manager;

create role manager 
login createdb
password 'Welcome@123';

--tablespace

alter database sample_db
set tablespace manager_default;

create tablespace manager_default
owner manager
location 'C:\Users\Avani\Downloads\manager_tablespace';

--copy database 
create database sample_db_copy with template sample_db owner postgres;
-- this databse sample_db is not used by any users


--get the database size 
select pg_size_pretty (pg_database_size('dvdrental')) size;

--schema
select current_schema();

show search_path;

--schema new example

create schema products;

set search_path to products, public;

create table food(
id serial primary key,
name varchar,
price numeric
);

select * from food;

set search_path to public;

drop schema products cascade;


--new schema 

create schema avani;

--list all schemas
select * from pg_catalog.pg_namespace
order by nspname;

--for users to give access
create role hr
login
password 'Welcome@123';

create schema authorization hr;

create schema sales authorization hr;

CREATE SCHEMA scm
    CREATE TABLE deliveries(
        id SERIAL NOT NULL,
        customer_id INT NOT NULL,
        ship_date DATE NOT NULL
    )
    CREATE VIEW delivery_due_list AS
        SELECT ID, ship_date
        FROM deliveries
        WHERE ship_date <= CURRENT_DATE;

--roles and privileges

create role developer;

select rolname from pg_roles;

drop role developer;

--login role 

create role designer
login 
password 'avani@123';


--superuser role 
create role john
superuser
login
password 'welcome@123';

--database creation 
create role alice 
createdb
login 
password 'createdb';

--new role 
create role avani with 
login 
password 'welcome@123'
connection limit 10
valid until '2025-02-22';

--new one 
create role saniya 
login 
password 'Welcome@123


		




