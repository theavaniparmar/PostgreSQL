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


-------------------------------------------------------------------------------------

--bank account trigger 

create table bank_accounts(
id serial primary key,
account_holder text,
balance numeric check (balance>=0)
);


insert into bank_accounts(account_holder, balance)
values 
('satish', 1200),
('nirav', 1500),
('daxit', 1000);

create function prevent_negative_balance()
returns trigger as $$
begin 
if new.balance<0 then
raise exception 'insufficient balance!';
end if;
return new;
end;
$$ language plpgsql;

create trigger check_balance_before_update
before update on bank_accounts
for each row
execute function prevent_negative_balance();

update bank_accounts set balance = balance - 1100 where account_holder = 'daxit';

update bank_accounts set balance = balance - 500 where account_holder = 'daxit';

select * from bank_accounts;

------------------------------------------------------------------

alter trigger check_balance_before_update on bank_accounts
rename to check_balance;

-------------------------------------------------------------------

--before insert trigger example (automatic change name in proper case)

create table users(
id serial primary key,
name varchar(50)
);

create function format_username()
returns trigger as 
$$
begin 
new.name = initcap(new.name);
return new;
end;
$$ 
language plpgsql;

create trigger before_insert 
before insert on users
for each row 
execute function format_username();

insert into users (name) values ('avani parmar');

select * from users;

---------------------------------------------------------

--after update trigger example 

create table employee_info(
id serial primary key,
name varchar(50),
salary numeric 
);

create table employee_logtable(
id serial primary key,
employee_id int,
old_salary numeric,
new_salary numeric,
difference numeric generated always as (new_salary - old_salary) stored,
changed_date timestamp default now()
);

create function salary_change()
returns trigger as 
$$
begin 
insert into employee_logtable(employee_id, old_salary, new_salary,changed_date)
values (old.id, old.salary, new.salary, now());
return new;
end;
$$
language plpgsql;

create trigger after_update 
after update on employee_info
for each row
execute function salary_change();

insert into employee_info(name, salary)
values ('avani', 4000), ('aman', 5000);

update employee_info set salary = 10000 where name = 'avani';

select * from employee_logtable;

-----------------------------------------------------------









