select last_name, length(last_name) as len from customer order by len desc;
select first_name from customer order by first_name asc nulls first;

--create a new table 
create table sort_demo(num INT);

--insert a new data 
insert into sort_demo(num)
values
(2),
(3),
(4),
(null);

select num from sort_demo order by num;
select num from sort_demo order by num desc nulls first;
select num from sort_demo order by num asc  nulls last;

--create new table color
create table colors(
id serial primary key,
bcolor varchar,
fcolor varchar
);

--insert values in color table
insert into colors(bcolor, fcolor)
values 
('red', 'green'),
('red', 'yellow'),
(null, 'yellow'),
('blue', null),
('red', 'yellow');

select * from colors;

select distinct bcolor from colors order by bcolor;
select distinct bcolor, fcolor from colors;
select distinct bcolor,fcolor from colors order by bcolor, fcolor;

--create new table 
create table marksheet(
id serial primary key,
maths int,
science int,
english int,
status varchar);

--insert values in this table
insert into marksheet(maths, science,english,status)
values
(45,45,45,'pass'),
(54,89,67,'pass'),
(34,23,12,'fail'),
(45,45,45,'pass'),
(15,23,78,'fail');

select distinct maths,english,status from marksheet;
select distinct * from marksheet;
alter table marksheet
drop column id;