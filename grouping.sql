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

--new examples
SELECT
  customer_id,
  staff_id,
  SUM(amount)
FROM
  payment
GROUP BY
  staff_id,
  customer_id
ORDER BY
  customer_id;

--having
select * from actor;
select 
first_name|| ' '||last_name as name,
count(actor_id)as actors
from actor
group by actor_id 
having actor_id>5
order by name;

--grouping sets
create table sales(
id serial primary key,
product varchar(34),
quantity int,
amount int,
region varchar(100)
);

insert into sales(id,product,quantity,amount,region)
values
(1,'laptop',30,1000,'west'),
(2,'mobile',12,4500,'east'),
(3,'pen drive', 34, 500, 'west'),
(4, 'laptop',12,3400,'east'),
(5,'bottle',null,1500,null),
(6,null,23,1000,'south');

select * from sales;

select product, region , sum(amount) as total_sales
from sales
group by grouping sets((region),(product), (region, product), ())
order by total_sales;

select region , sum(amount) as total_sales
from sales
group by region having region='east' 
order by total_sales;

select product,  sum(quantity) as no_of_products
from sales
group by product havig  product = 'laptop'
order by no_of_products;

--new example with all grouping data categories
create table salesdata(
region text,
categories text,
revenue numeric
);

insert into salesdata(region,categories,revenue)
values
('north','clothes',1000),
('south', 'plastics',3000),
('north', 'plastics', 4000),
('south', 'clothes', 500),
(null,null,null);

select * from salesdata;

--groupby
select categories, sum(revenue) as total_revenue
from salesdata
group by categories having categories = 'plastics'
order by total_revenue;

--grouping sets
select region, categories, sum(revenue) as total_revenue
from salesdata
group by grouping sets((region),(region,categories),())
order by total_revenue desc;

--rollup
select region ,sum(revenue) as total_revenue
from salesdata
group by rollup(region)
order by total_revenue;

--cube
select categories , sum(revenue) as total_revenue
from salesdata
group by cube(categories)
order  by total_revenue desc;

select region , categories , sum(revenue) as total_revenue
from salesdata
group by cube(region,categories)
order  by total_revenue desc;

--grouping()
select region, categories, sum(revenue) as total_revenue,
grouping(region) as is_region_grouped,
grouping(categories) as is_categories_grouped
from salesdata
group by rollup(region, categories);

