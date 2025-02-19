create table data(
person_id serial primary key,
salary bigint,
birth_date date, 
name varchar(19),
availability boolean not null
);

insert into data(salary, birth_date, name, availability)
values 
(50000, '2002-11-19','avani', 'yes'),
(35000, '20003-10-3', 'nirav', 'yes');

select * from data;

update data 
set availability = 'no' where person_id = 2;

select * from data;

select current_time;

select current_date;

select timeofday();

-- new example 
create table users(
user_id serial primary key,
full_name varchar(100) not null,
email text unique,
age smallint check (age>=0),
salary decimal(10,2),
is_active boolean default true,
signup_date date default current_date,
last_login timestamp default now(),
ip_address inet,
mac_address macaddr,
preferences jsonb,
skills text[],
profile_picture bytea,
unique_id uuid default gen_random_uuid(),
work_duration interval,
created_at timestamptz default now()
);

insert into users(full_name, email,age,salary, is_active,ip_address, mac_address, preferences, skills , work_duration)
values 
('John Doe',
    'john.doe@example.com',
    30,
    75000.50,
    TRUE,
    '192.168.1.100',
    '08:00:2b:01:02:03',
    '{"theme": "dark", "notifications": true}',
    ARRAY['Python', 'SQL', 'Java'],
    '5 years 3 months'
);

select * from users;



