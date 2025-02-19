--alter table 
create table library (
book_id serial primary key,
book_title varchar(25),
book_price numeric,
pages bigint
);

insert into library(book_title, book_price, pages)
values
('herry_potter', 200, 23 ),
('comic', 300, 50),
('spiderman', 150, 12)
returning *;

alter table library 
add column status text;

select * from library;

alter table library 
drop column status;

alter table library 
rename column pages
to no_of_pages;

select * from library;

alter table library
rename to library_books;

truncate table library_books;

select * from library_books;

drop table library_books;

--temp table 
create temp table person(
name text,
contact_no numeric);

select * from person;






