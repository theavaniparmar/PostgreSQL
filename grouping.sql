--grouping data

create table companydetails(
id serial primary key,
company_name varchar(30),
product_name varchar(10),
no_of_products int);

insert  into companydetails(company_name,product_name,no_of_products)
values
('zignut','website',3),
('evision', 'website',1),
('tata','salt',10),
('tata', 'motors',4),
('adani','app',2);

select * from companydetails;

select company_name, count(no_of_products) as total
from companydetails
group by company_name;

