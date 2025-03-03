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


