--role memebership
create role sales; --group role
grant sales to alice;

grant select on rental to sales;

select count(*) from rental;

revoke sales from alice;

select current_user;

create role bob 
login 
password 'welcome@123';

set role bob;

select current_user;

select session_user;

