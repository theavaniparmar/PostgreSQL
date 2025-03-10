--b tree index
create index idx_email on customer(email);

select email from customer;

explain select * from customer where email = 'virgil.wofford@sakilacustomer.org';

--hash index

create index idx_film_title on film using hash(title);

select title from film order by title asc;

select * from film where title = 'Airport Pollock';


-------------------------
select * from payment;

create index idx_payment on payment(amount, payment_date); 

explain select payment_id, amount, payment_date from payment where amount = '7.99' and payment_date = '2007-02-16 22:41:45.996577';

--index on expressions

create table cilent (
id serial primary key,
name varchar(50),
projects int,
profit numeric
);

insert into cilent(name, projects, profit)
values
('a', 4, 8900.5),
('b', 3, 10000),
('c', 6, 2390.89),
('d', 1, 450.78);

create index idx_pro on cilent((projects<4));

explain select  name, projects, profit from  cilent where (projects < 4) is false;

--partial index

create index idx_active_customer on customer(active);

set enable_seqscan = off; 
explain analyse select * from customer where active = 1;

reindex table customer;

select column_name, data_type from information_schema.columns where table_name = 'customer';


--DISPLAY INDEXES
select tablename, indexname from pg_indexes
where schemaname = 'public';

select indexname, indexdef from pg_indexes
where tablename = 'cilent';


--full text search
create table products(
id serial primary key,
name varchar(10),
specification text
);

insert into products(name, specification)
values
('Ipromax 16', 'this is a very popular smartphone.'),
('HP laptop', 'It is used by students.');

select * from products;

explain select * from products where to_tsvector(specification) @@ to_tsquery('popular');

create index idx_products on products using gin(to_tsvector('english', specification));

select name, ts_rank(to_tsvector(specification), to_tsquery('popular'))
from products 
where to_tsvector(specification) @@ to_tsquery('popular')
order by ts_rank desc;

--json index
drop table if exists car_models;

create table car_models(
id serial primary key,
name varchar(50),
features jsonb
);


insert into car_models(name, features)
values 
('swift','{"color": "white", "price": "1,00,000", "type": "EV"}'),
('BMW', '{"color": "grey", "price": "7,00,000", "type": "petrol"}'),
('creta', '{"color": "black", "price": "5,50,000", "type": "EV"}');

explain select name from car_models where features ->> 'type' = 'EV';

create index idx_car on car_models using gin(features); 

explain select name from car_models where features @> '{"type": "EV"}';



CREATE INDEX idx_car_price ON car_models((features->>'price'));

select * from car_models where features ->> 'price' = '7,00,000';   --for exact data match use b tree indexing








	










