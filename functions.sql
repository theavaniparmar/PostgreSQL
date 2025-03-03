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




















