--sequence example 
create sequence my
increment 3
start 34;

select * from my;

select nextval('my');
select currval('my');

--new one 
create sequence seq
increment by -3
start with 10
maxvalue 10
minvalue 1
cycle;

select * from seq;
select nextval('seq');

--new one 
create sequence seq1
increment by -1
start with 5 
maxvalue 5
minvalue 1;

select nextval('seq1');
select currval('seq1');

SELECT
    relname sequence_name
FROM
    pg_class
WHERE
    relkind = 'S';

--new 
create sequence sq
start with 4
increment 1 ;

drop sequence sq;

--identity and generated column
create table social_media(
user_id int generated always as identity primary key,
user_name text,
password text,
no_of_accounts numeric,
login_time numeric,
scroll_time numeric,
screen_time numeric generated always as ((login_time+scroll_time)/no_of_accounts) stored
);

insert into social_media(user_name, password, no_of_accounts, login_time, scroll_time)
values 
('theavaniparmar', '@123', 3 , 3,6),
('saniya_mahek', '$345', 5,12,13);

select * from social_media;

