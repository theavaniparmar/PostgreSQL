create table person_details(
id serial primary key,
email text,
address text
);

insert into person_details(id , email, address)
values 
(1,'@abc', 'lal park'),
(2,'@cvd', 'reliance'),
(3, '@tnx', 'sargasan')
returning *;

update person_details set address = 'kudasan' where address = 'sargasan'
returning *;

--merge

create table order_items(
order_id int primary key,
product_name text,
status text
);

insert into order_items(order_id, product_name, status)
values 
(1, 'mobile', 'cancelled'),
(2, 'laptop', 'cancelled'),
(3, 'key', 'confirmed')
returning *;

merge into order_items as o
using (values (4,'tv','shipped'),(3,'key','confirmed')) as new_added(order_id,product_name,status)
on o.order_id = new_added.order_id
when matched and new_added.status = 'confirmed'  then
delete
when matched  then
update set status = new_added.status 
when not matched then
insert (product_name, status) values (new_added.product_name, new_added.status)
returning *;

--new example for Merge  
create table customer_info(
id serial primary key,
name text,
email text,
city text
);

insert into customer_info(id, name, email,city)
values 
(1,'avani','@abc','rajkot'),
(2, 'nil', '@srf', 'jamnagar');

MERGE INTO customer_info AS c
USING (VALUES 
    (1, 'Alice', 'alice@example.com', 'Chicago'),  -- Update needed
    (3, 'Charlie', 'charlie@example.com', 'Miami') -- Insert needed
) AS new_data(id, name, email, city)
ON c.id = new_data.id
WHEN MATCHED THEN
    UPDATE SET city = new_data.city  -- Update city if ID matches
WHEN NOT MATCHED THEN
    INSERT (id, name, email, city) 
    VALUES (new_data.id, new_data.name, new_data.email, new_data.city); -- Insert new customer
