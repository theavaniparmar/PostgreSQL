create table Employees(
id serial primary key,
name text
);

create table Manager(
id serial primary key,
name text
);

insert into Employees(name)
values
('avani'),
('nil'),
('aman'),
('saniya'),
('nil');

insert into Manager(name)
values
('avani'),
('aman'),
('saniya'),
('nil'),
('dev');


select * from Employees;
select *from Manager;

--union
select name from Employees 
union
select name from  Manager;

--union all
select name from Employees 
union all
select name from  Manager;

--intersect
select name from Employees 
intersect
select name from  Manager;

--except
select name from Employees 
except
select name from  Manager;

select name from Manager
except
select name from  Employees;





