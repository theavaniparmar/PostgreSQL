create table book(
title text,
price numeric,
quantity int
);

insert into book(title, price, quantity)
values
('herry potter', 1000,3),
('ramayan',700,2),
('comic', 500, null),
('positive thoughts', null,4),
('avengers',null, null),
('the way of life', 1346, 10);

select * from book;

--CTE
with expensive_book as(
select title from book where price>=1000
order by price)

select * from expensive_book;

--recursive CTE 
create table folder(
id serial primary key,
name text,
parent_id int
);

insert into folder(id,name,parent_id)
values
(1, 'root', null),
(2, 'documents', 1),
(3, 'pics',1),
(4, 'images', 2),
(5,'music',3),
(6,'movies',2),
(7,'downloads',3);

--recursive CTE
with recursive folder_hierchy as(
select id, name, parent_id, 1 as level from folder where  parent_id is null

union all 

select f.id,f.name,f.parent_id,fh.level+1
from folder f join folder_hierchy fh on f.parent_id=fh.id
)

select * from folder_hierchy;




