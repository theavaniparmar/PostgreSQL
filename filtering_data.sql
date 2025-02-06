select first_name, last_name from customer where first_name = 'Jamie';
select first_name, last_name from customer where first_name='Jamie' and last_name='Rice';
select first_name, last_name from customer where first_name='Jamie' or last_name='Rice';
select first_name, last_name from customer where first_name in ('An', 'Anne');
select first_name from  customer where first_name like 'An%'; 
select first_name from customer where first_name != 'Ann';
select first_name, last_name from customer where last_name like 'Ric%' and first_name != 'Annie';

--AND examples
select true and  false as reult;
select false and null as result;
select null and null as result;
select title, rental_rate from film where rental_rate=0.99 and rental_rate=2.99;

--OR examples
select true or false as result;
select false or null as result;
select false or false as result;
select title, rental_rate from film where rental_rate=0.99 or rental_rate=2.99;

--limit clause
select film_id, title, release_year from film order by film_id limit 6;
select film_id, title, release_year from film order by film_id limit 7 offset 2;
select rental_rate from film order by rental_rate desc limit 5;

--fetch examples
select film_id, rental_rate from film order by film_id offset 2 rows fetch first 4 rows only;

--IN clause examples
select city_id, city from city where city_id in(4,7,10) order by city_id;
select city_id, city from city where city_id not in (1,2,3) order by city_id;

--between exammples
select * from payment;
select * from payment where payment_id between 17505 and 17509;
select * from payment where payment_id not between 17506 and 17509;

--like examples