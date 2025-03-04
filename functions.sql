--functions

SELECT ARRAY_AGG(department) FROM employees;
select * from employees;
select * from car_models;

select tablename from pg_catalog.pg_tables;

select * from users;

SELECT STATEMENT_TIMESTAMP();
select localtime;

select localtime(2);

select localtimestamp;

select date_part('year', now());

select timeofday();

select extract (month from now());

select to_date('20170103', 'yyyymmdd');

select make_time(22,50,60);

select make_date(25,3,5);

select current_date , age(current_timestamp, '2002-11-19');

select justify_days(interval '35 days'),
       justify_hours(interval '45 hours');

select make_interval();

select timestamp '2025-03-03 15:10' at time zone 'america/new_york';

select date_trunc('hour', current_timestamp);

select pg_sleep(5);

select isfinite(interval '4 days');

select isfinite(interval 'infinity');

select to_jsonb(10:: int), to_jsonb(3.678 :: numeric);

select to_jsonb(array ['red', 'pink', 'blue']) as json_array;

select json_build_array(name, department, salary) from employees;

CREATE TABLE users1 (
    id SERIAL PRIMARY KEY,
    details JSONB
);

INSERT INTO users1 (details) VALUES
('{"name": "Alice", "age": 25, "skills": ["SQL", "Python"], "address": {"city": "New York", "zip": "10001"}}'),
('{"name": "Bob", "age": 30, "skills": ["Java", "C++"], "address": {"city": "Los Angeles", "zip": "90001"}}');

SELECT details->'name' AS json_name, 
       details->>'name' AS text_name 
FROM users1;

SELECT details->'skills', jsonb_exists(details, 'skills') 
FROM users1;

CREATE TABLE employees2 (
    id SERIAL PRIMARY KEY,
    details JSONB
);

INSERT INTO employees2 (details) VALUES
('{"name": "Alice", "age": 25, "skills": ["SQL", "Python"], "address": {"city": "New York", "zip": "10001"}}'),
('{"name": "Bob", "age": 30, "skills": ["Java", "C++"], "address": {"city": "Los Angeles", "zip": "90001"}}');

update employees2
set details = jsonb_set(details, '{age}', '28')
where details ->> 'name' = 'Alice';

select * from employees2;

update employees2
set details = jsonb_insert(details, '{salary}', '3400':: jsonb, true)
where details ->> 'name' = 'Bob';

update employees2 
set details = details - 'age'
where details ->> 'name' = 'Alice';

update employees2
set details = details - '{address,city}'
where details ->> 'name' = 'Bob';

update employees2
set details = jsonb_strip_nulls(details);

select jsonb_pretty(details) from employees2;

-----------------------------------------------------

drop table employees cascade;

create table employees(
id serial primary key,
details jsonb
);

insert into employees (details) values
('{"name" : "avani", "skills" : ["sql", "csharp", "java"]}'),
('{"name" : "aman", "skills" : ["C++", "python"]}');

select jsonb_array_elements(details ->'skills') as skills
from employees 
where details ->> 'name' = 'aman';

select jsonb_array_elements_text(details ->'skills') as skills
from employees 
where details ->> 'name' = 'avani';

select jsonb_array_length(details ->'skills') as skills
from employees 
where details ->> 'name' = 'aman';

select jsonb_agg(details) from employees;

UPDATE employees
SET details = jsonb_set(details, '{skills}', 
       (SELECT jsonb_agg(elem)
        FROM jsonb_array_elements(details->'skills') elem
        WHERE elem <> '"sql"'))
WHERE details->>'name' = 'avani'
RETURNING *;

--for deleting particular element in skill using value base method

--utility functions

select jsonb_typeof('[]');
select jsonb_typeof('1' :: jsonb);

--math functions
create table students(
id serial primary key,
student_name text,
marks bigint
);

insert into students(student_name, marks)
values
('simran', 79),
('saniya', 34),
('man', 95),
('naitik', 12),
('krishna', 65);


select student_name, marks,
width_bucket(marks, 0, 100, 4) as grade_bucket
from students;

select student_name, marks, width_bucket(marks,0,100,4) as grade_bucket,
case 
when width_bucket(marks,0,100,4) = 1 then 'fail'
when width_bucket(marks,0,100,4) = 2 then 'average' 
when width_bucket(marks,0,100,4) = 3 then 'good' 
when width_bucket(marks,0,100,4) = 4 then 'best'
else 'out of range' 
end as grade
from students;

--string functions

select length('avani');

select concat('avani ', 'parmar');

select initcap('avani parmar');

select substring('useful', 1,3);

select position('ful' in 'useful');

select repeat('divya ', 5);

--windows function

CREATE TABLE sales (
    id SERIAL PRIMARY KEY,
    salesperson VARCHAR(50),
    region VARCHAR(50),
    sales_amount INT
);

INSERT INTO sales (salesperson, region, sales_amount) VALUES
('Alice', 'North', 500),
('Bob', 'North', 300),
('Charlie', 'South', 400),
('David', 'South', 600),
('Eve', 'West', 700),
('Frank', 'West', 450);


--row_number fn
select salesperson,region, sales_amount,
row_number() over(partition by region order by sales_amount desc) as ranking
from sales;

update sales 
set sales_amount = 500
where salesperson = 'Eve';

--rank fn
select *, rank() over(partition by region order by sales_amount desc) as rank
from sales;

update sales 
set sales_amount = 500
where salesperson = 'Frank';

select *, dense_rank() over(partition by region order by sales_amount desc) AS ORDER
from sales;

insert into sales(salesperson, region, sales_amount) 
values 
('akash', 'west', 500),
('vikas', 'west' , 900)
returning *;

select * from sales;

insert into sales(salesperson, region, sales_amount) 
values 
('param', 'West', 500),
('meet', 'West' , 900);

insert into sales(salesperson, region, sales_amount) 
values
('rutvi', 'West', 300);


--new example for ranking 

create table t(
id serial primary key,
value varchar(10)
);

insert into t(value)
values 
('a'),
('b'),
('b'),
('c'),
('d'),
('d'),
('d'),
('e');

select * from t;


--ntile fn
select *, ntile(3) over (partition by region order by sales_amount desc) as bucket
from sales;

--first value fn
select *, first_value(sales_amount) over (partition by region order by sales_amount desc) as highest_sales
from sales;

select *, first_value(sales_amount) over (partition by region order by sales_amount ) as lowest_sales
from sales;

select *, nth_value(sales_amount,2) over (partition by region order by sales_amount desc rows between unbounded preceding and unbounded following) as second_highest_sales
from sales;



--last value fn
select *, last_value(sales_amount) over (partition by region order by sales_amount desc rows between unbounded preceding and unbounded following ) as lowest_sales
from sales;

select *, last_value(sales_amount) over (partition by region order by sales_amount desc ) as lowest_sales
from sales;

--sum fn
SELECT salesperson, region, sales_amount,
       SUM(sales_amount) OVER (PARTITION BY region ORDER BY sales_amount) AS running_total
FROM sales;



































