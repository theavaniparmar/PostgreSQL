--transaction
create table account (
id serial primary key,
name text,
balance numeric
);

insert into account(name, balance)
values 
('nirav', 1000),
('satish',3000),
('daxit', 5000);

select * from account;

rollback;

--transfer 500 rs from nirav to daxit
begin;
update account set balance = balance - 500 where name = 'nirav';
update  account set balance = balance + 500 where name = 'daxit';
commit;

select * from account;

