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







