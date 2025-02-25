--view 
create view staff_login as 
select username, password from staff;

select * from staff_login;

--view inside another view
drop view password_details;

create view password_details as 
select password from staff_login where username = 'Mike';

select * from password_details;


--updatable view

create table social_media(
id serial primary key,
username text,
password text,
posts bigint,
followers bigint
);

insert into social_media(username, password, posts, followers)
values
('theavaniparmar', 'welcome@123', 19, 800),
('dp_26_07', 'daxit123', 10, 700),
('np_nirav_parmar', 'np@456', 300, 1300);

select * from social_media;



create view login as
select id, username, password from social_media where id>=2;

select * from login order by id;

update login set password = 'dp$123' where id = 2;

insert into login(id, username, password)
values 
(4, 'sp_satish_parmar', 'sp%90');

--instead of trigger (forcefully make a updatable view)
create table employee(
id serial primary key,
name varchar,
department varchar,
salary numeric
);


insert into employee(name, department, salary)
values 
('a', 'it', 45000),
('b', 'computer', 50000),
('c', 'civil', 20000);

create view employee_view as
select id, name, department from employee;

--trigger
create function employee_view_update()
returns trigger as $$
begin

if TG_OP = 'update'  then
update employee
set name = new.name, department = new.department
where id = new.id;
return new;
end if;

if TG_OP = 'insert' then
insert into employee (name, department, salary)
values (new.name, new.department, 50000);
return new;

end if ;

return null;

end;
$$ language plpgsql;


create trigger employee_view_trigger
instead of insert or update on employee_view
for each row execute function employee_view_update(); 

insert into employee_view(name, department)
values 
('d', 'hr');


--materialized view

create materialized view high_salary_employees as 
select id, name, department, salary
from employee
where salary <50000
with data;

INSERT INTO employee(name, department, salary)
VALUES ('e', 'chemical', 12000);

REFRESH MATERIALIZED VIEW high_salary_employees;

SELECT * FROM high_salary_employees;

--recursive view 
drop table employees;

create table employees(
id serial primary key,
name varchar,
manager_id int references employees(id)
);

insert into employees(name, manager_id)
values
('a',null),
('b', 1),
('c', 1),
('d',2);

create view employee_query as 
with recursive employee_hierarchy as(
select id, name, manager_id , 1 as level
from employees 
where manager_id is null

union all

select e.id, e.name, e.manager_id, h.level +1
from employees e
join employee_hierarchy h on e.manager_id = h.id
)

select * from employee_hierarchy;

select * from employee_query;

select * from pg_matviews;    --listing views

alter materialized view high_salary_employees 
rename to low_salary_employees;

select table_name, table_schema from information_schema.views;
















