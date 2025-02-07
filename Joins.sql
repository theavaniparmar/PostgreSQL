create table basket1(
a int primary key,
fruit1 varchar(50) not null
);

create table basket2(
b int primary key,
fruit2 varchar(50) not null
);

insert into basket1(a,fruit1)
values
(1,'apple'),
(2, 'banana'),
(3, 'orange'),
(4,'strawberry'),
(5, 'guava');


select * from basket1;
select * from basket2;

--inner join 
select  * from basket1 inner join basket2 on fruit1=fruit2;

--left join
select * from basket1 left join basket2 on fruit1=fruit2;

--right join
select * from basket1 right join basket2 on fruit1=fruit2;

--full join
select * from basket1 full join basket2 on fruit1=fruit2;

--table alias
select * from language l;

select * from language l full join city c on l.language_id=c.city_id;
select l.name,c.city from language l full join city c on l.language_id=c.city_id;
select l.name,c.city from language l right join city c on l.language_id=c.city_id;
select l.name,c.city from language l left join city c on l.language_id=c.city_id;
select l.name,c.city from language l inner join city c on l.language_id=c.city_id;
select l.name,c.city from language l inner join city c on l.name=c.city;

--self join with table aliases
select * from film f1 inner join film f2 on f1.film_id=f2.film_id;


--inner join with using keyword
select * from 
customer c inner join payment p using (customer_id) order by payment_date;

--inner join to join three tables
select * from customer c inner join payment p on c.customer_id=p.customer_id 
inner join staff s using (staff_id) order by payment_date;

select 
c.customer_id,
c.first_name|| ' ' ||c.last_name as name,
p.payment_id,
s.staff_id,
p.payment_date
from customer c inner join payment p on c.customer_id=p.customer_id 
inner join staff s using (staff_id) order by payment_date;

--left join 
select * from film f left join film_actor fa using (film_id) order by film_id;

select 
f.film_id,
f.title,
f.release_year,
fa.actor_id
from 
film f left join film_actor fa using (film_id) 
order by film_id;

--right join
select f.film_id, f.title, i.inventory_id from film f right join inventory i using(film_id) order by film_id;

select f.film_id, f.title, i.inventory_id from film f right join inventory i using(film_id) 
where i.inventory_id = null order by film_id;

select f.film_id, f.title, i.inventory_id from inventory i right join film f using(film_id) 
where i.inventory_id is null order by film_id;

SELECT
  f.film_id,
  f.title,
  i.inventory_id
FROM
  inventory i
RIGHT JOIN film f USING(film_id)
WHERE i.inventory_id IS NULL
ORDER BY
  f.title;

--self join 
select f1.title, f2.title 
from film f1 inner join film f2 on f1.film_id  < f2.film_id where f1.length = f2.length;

--self join 
create table employee(
employee_id int primary key,
first_name varchar(50),
last_name varchar(50),
manager_id int,
foreign key(manager_id) references employee(employee_id));

insert into employee(employee_id, first_name, last_name, manager_id)
values 
(1,'avani','parmar',3),
(2,'nil','soni',4),
(3,'saniya','nayak',null),
(4,'aman','patel',1),
(5, 'het','upadhyay',5);

select * from employee;

--join performs
select
m.first_name|| ' ' ||m.last_name as manager
from 
employee e inner join employee m on e.manager_id = m.employee_id
where m.manager_id is null
order by manager;



--new example for full outer join
create table person(
id serial primary key,
name varchar(50),
company_id int,
role varchar(100)
);

create table company(
company_id int,
company_name varchar(500),
product varchar(100)

);

insert into person(name, company_id, role)
values
('avani',2,'developer'),
('saniya',null, 'designer'),
('aman', 1, 'HR'),
('nil', 3,'user'),
('nirav',2,'artist');

insert into company(company_id, company_name, product)
values
(null, 'evision','staffwise'),
(1,'zignut', 'chatgpt'),
(2,'zydus','medicine'),
(3,'tata','salt'),
(4, 'L&T','tier'),
(5, 'reliance','jiophone');

select * from person;
select *from company;

select p.name,c.company_name
from person p full join company c using(company_id)
order by company_id;

select p.name,c.company_name
from person p full join company c using(company_id)
where c.company_id is null
order by company_id;

--cross join example
create table value1(
label varchar(5)
);

create table value2(
number int
);

insert into value1(label)
values
('a'),
('b');

insert into value2(number)
values
(1),
(2);

select * from value1;
select *from value2;

select * from value1 cross join value2;
select * from value2 cross join value1;

--natural join example
select * from city natural join country;
select * from address natural join city;






