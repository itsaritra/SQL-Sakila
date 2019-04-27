use sakila;
-- Question 1a
select first_name, last_name
from actor;
-- Question 1b
select upper(concat(first_name,' ', last_name)) as 'Actor Name'
from actor;
-- Question 2a
select actor_id, first_name, last_name
from actor
where first_name='Joe';
-- Question 2b
select actor_id, first_name, last_name
from actor
where last_name like'%gen%';
-- Question 2c
select last_name, first_name
from actor
where last_name like'%li%';
-- Question 2d
select country_id, country
from country
where country in ('Afghanistan', 'Bangladesh', 'China');
-- Question 3a
alter table actor
add description varchar(200) after last_name;
alter table actor
modify description blob;

-- Question 3b
alter table actor
drop description; 

-- Question 4a
select last_name,
count(*) as count
from actor group by last_name;
-- Question 4b
select last_name,
count(*) as count
from actor group by last_name
having count >1;

-- Question 4c
set sql_safe_updates = 0;
UPDATE actor
SET first_name = 'HARPO'
WHERE actor_id = 172;

-- Question 4d
UPDATE actor
SET first_name = 'GROUCHO'
WHERE actor_id = 172; 

-- Question 5a
SHOW CREATE TABLE address;

-- Question 6a
select staff.first_name, staff.last_name, address.address
from staff
join address on staff.address_id = address.address_id;

-- Question 6b
select staff.first_name 'First Name', staff.last_name 'Last Name', sum(payment.amount) 'Total Amount'
from staff
join payment on staff.staff_id = payment.staff_id
where payment.payment_date like '%2005-08%'
group by staff.first_name, staff.last_name;

-- Question 6c
select title 'Film', count(actor_id) 'Total Actors'
from film
inner join film_actor on film.film_id = film_actor.film_id
group by title;

-- Question 6d
select title, count(inventory_id) 'Number of copies'
from film
join inventory on film.film_id = inventory.film_id
where title = 'Hunchback Impossible';

-- Question 6e
select first_name, last_name, sum(amount) 'Total Amount Paid'
from customer c
join payment p on c.customer_id = p.customer_id
group by c.customer_id
order by last_name asc;

-- Question 7a
select title
from film
where title like '%k' or '%q' and language_id in
(
	select language_id
    from language
    where name = 'english'
);

-- Question 7b
select first_name, last_name
from actor
where actor_id in
(
	select actor_id
	from film_actor
	where film_id in
	(
		select film_id
		from film
		where title = 'Alone Trip'
	)
);

-- Question 7c
select first_name, last_name, email
from customer cu
join address ad on cu.address_id = ad.address_id
join city ci on ad.city_id = ci.city_id
join country co on ci.country_id = co.country_id
where co.country = 'Canada';

-- Question 7d

select title
from film f
join film_category fc on f.film_id = fc.film_id
join category c on fc.category_id = c.category_id
where name = 'Family';

-- Question 7e
select title, count(rental_id) 'Total Rentals'
from film f
join inventory i on i.film_id = f.film_id
join rental r on r.inventory_id = i.inventory_id
group by title
order by 'Total Rentals' desc;

-- Question 7f
select s.store_id, address, sum(amount) 'Total Sale($)'
from store s
join address ad on s.address_id = ad.address_id
join inventory i on i.store_id = s.store_id
join rental r on r.inventory_id = i.inventory_id
join payment p on p.rental_id = r.rental_id
group by s.store_id;

-- Question 7g
select store_id, address, city, country
from city c
join address ad on ad.city_id = c.city_id
join country co on co.country_id = c.country_id
join store s on s.address_id = ad.address_id
group by store_id;

-- Question 7h
select name as 'Genre', sum(amount) as 'Total Revenue'
from category c
join film_category fc on c.category_id = fc.category_id
join inventory i on i.film_id = fc.film_id
join rental r on r.inventory_id = i.inventory_id
join payment p on p.rental_id = r.rental_id
group by name
order by 'Total Revenue' desc
limit 5;

-- Question 8a
create view Top_5_Genres as
select name as 'Genre', sum(amount) as 'Total Revenue'
from category c
join film_category fc on c.category_id = fc.category_id
join inventory i on i.film_id = fc.film_id
join rental r on r.inventory_id = i.inventory_id
join payment p on p.rental_id = r.rental_id
group by name
order by 'Total Revenue' desc
limit 5; 

-- Question 8b
select * from Top_5_Genres;

-- Question 8c
drop view Top_5_Genres;
