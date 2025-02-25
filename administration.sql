--list of databases
select datname from pg_database;

--list of tables
select * from pg_catalog.pg_tables;

select version();

select setting from pg_settings where name = 'server_version';

--administration

select datname from pg_database;

create database testdb 
owner postgres
encoding 'UTF8';

DROP DATABASE testdb;

----------------------------------

create role pista
with login
password 'pista@123';

grant all privileges on database testdb to pista;

create role admin_user with superuser createdb createrole login password 'adminpass';

select rolname from pg_roles;

-----------------------------------------

create schema private;

create table private.books(
id serial primary key,
book_title varchar, 
price numeric,
description text
);

select tablename from pg_tables where schemaname = 'private';

select tablename, schemaname from pg_tables;

grant all privileges on schema private to pista;

grant select on all tables in schema private to pista;

set role pista;

select * from private.books;

alter table private.books
add column quantity int;

set role postgres;

select * from private.books;

revoke all privileges on database testdb from pista;

alter user pista with password '@123';

select pg_size_pretty(pg_database_size('testdb'));

--------------------------------------------------------------



