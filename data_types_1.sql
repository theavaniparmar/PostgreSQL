-- composite type example 
create type address_type as(
street text,
city varchar,
state varchar
);

create table address_details(
person_id serial primary key,
name varchar,
address address_type
);


insert into address_details(name, address)
values 
('avani', row('1','rajkot','gujarat')),
('saniya', row('2','gandhinagar', 'kerala'));

select * from address_details;

select person_id, (address).city from address_details;
select (address).* from address_details;

--bytea example 

create table files(
id serial primary key,
file_name text,
file_data bytea
);

insert into files(file_name, file_data)
values 
('test.txt', E'\\x48656c6c6f20576f726c64'),
('images.jpg', pg_read_binary_file('C:\Users\Avani\source\repos\PostgreSQl\images.jpg'));

--binary data to base 64 (convert)
SELECT encode(file_data, 'base64') FROM files WHERE file_name = 'images.jpg';

--enum example
create type color as enum('black', 'white', 'red');

create table car_model(
name varchar,
color color 
);

insert into car_model(name, color)
values
('BMW','red'),
('maruti', 'white');

select * from car_model;

alter type color add	 value 'pink';	

insert into car_model(name, color)
values
('i20','pink');

select * from car_model;

drop type color cascade;

drop table car_model;

--array example 
create table students(
name varchar,
phone_number text[]
);

insert into students(name , phone_number)
values
('aman', array['2334556774','4974984588899','30908958605']),
('saniya', array['4327798769','3899758956']);
('avani', array['95379333984','74875757439']);

select * from students;

update students
set phone_number = array_append(phone_number, '448758768978')
where name = 'avani'
returning *;

select * from students where '4327798769' = any(phone_number);

--hstore example 
create extension if not exists hstore;

create table products(
id serial primary key,
name text not null,
attributes hstore
);

insert into products(name, attributes)
values
('pen','color=>"blue", brand => "marko",'),
('laptop', 'brand => "hp", RAM => "16 GB", storage => "1 tb"');

select * from products;