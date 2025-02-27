-- trigger 
select current_schema();
select  current_database();

drop table if exists employees cascade;

create table employees(
id serial primary key,
name varchar(50),
department text
); --first table

create table employees_archieve(
id serial primary key,
employees_id int,
name varchar(50),
department text,
deleted_at timestamp default now()
); --second table

--trigger fn
create function deleted_employee()
returns trigger as 
$$
begin 
insert into employees_archieve(employees_id, name, department, deleted_at)
values (old.id, old.name, old.department, now());
return old;
end;
$$
language plpgsql;

--create trigger
create trigger before_delete
before delete on employees
for each row 
execute function deleted_employee();

insert into employees(name, department)
values ('avani', 'backend'), ('aman', 'designer'), ('saniya', 'frontend');

delete from employees where id=3;

select * from employees_archieve;
select * from employees;



