select now();
select email from customer;
select  first_name, last_name, email from customer;
Select first_name|| ' '|| last_name as full_name from customer;
Select first_name || last_name as full_name from customer;

select first_name, last_name "surname" from customer;
select first_name, last_name as surname from customer;
select * from customer;
select  first_name from customer order by first_name asc;
select first_name, last_name from customer order by last_name desc;
select first_name, last_name from customer order by first_name asc, last_name desc;