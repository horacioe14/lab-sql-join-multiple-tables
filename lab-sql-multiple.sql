#1. Write a query to display for each store its store ID, city, and country.
use sakila;
select s.store_id, c.city, co.country
from sakila.store as s
join sakila.address as a
on s.address_id = a.address_id
join sakila.city as c
on a.city_id = c.city_id
join sakila.country as co
on c.country_id = co.country_id
group by s.store_id, c.city, co.country;

#2. Write a query to display how much business, in dollars, each store brought in.
use sakila;
select s.store_id, CONCAT('$', sum(p.amount)) as total_amount_dollars
from sakila.store as s
join sakila.staff as st
on s.store_id = st.store_id
join sakila.payment as p
on st.staff_id = p.staff_id
group by s.store_id;

#3. What is the average running time of films by category?
use sakila;
select c.name, round(avg(f.length),2) as average_length_per_film_category
from sakila.category as c
join sakila.film_category as fc
on c.category_id = fc.category_id
join sakila.film as f
on f.film_id = fc.film_id
group by c.name;



#4. Which film categories are longest?
use sakila;
select c.name, round(avg(f.length),2) as average_length_per_film_category
from sakila.category as c
join sakila.film_category as fc
on c.category_id = fc.category_id
join sakila.film as f
on f.film_id = fc.film_id
group by c.name
order by  round(avg(f.length),2) desc;


#5. Display the most frequently rented movies in descending order.
use sakila;
select f.title, count(r.rental_id) as most_rented_movies, f.film_id
from sakila.film as f
join sakila.inventory as i
on f.film_id = i.film_id
join sakila.rental as r
on i.inventory_id = r.inventory_id
group by f.title, f.film_id
order by count(r.rental_id) desc;


select count(inventory_id) as number_of_copies, film_id
from sakila.inventory
where inventory.film_id = 103;


select count(inventory_id) as number_of_copies, film_id
from sakila.rental
where inventory.film_id = 103;

#6. List the top five genres in gross revenue in descending order.
use sakila;
select c.name, sum(p.amount) as gross_revenue
from sakila.category as c
join sakila.film_category as fc
on c.category_id = fc.category_id
join sakila.inventory as i
on fc.film_id = i.film_id
join sakila.rental as r
on i.inventory_id = r.inventory_id
join sakila.payment as p
on r.rental_id = p.rental_id
group by c.name
order by sum(p.amount) desc
limit 5;

#Other queries
use sakila;
select c.name, count(i.inventory_id) as films_per_category
from sakila.category as c
join sakila.film_category as fc
on c.category_id = fc.category_id
join sakila.film as f
on f.film_id = fc.film_id
join sakila.inventory as i
on f.film_id = i.film_id
group by c.name;


select c.name, f.title
from sakila.category as c
join sakila.film_category as fc
on c.category_id = fc.category_id
join sakila.film as f
on f.film_id = fc.film_id
join sakila.inventory as i
on f.film_id = i.film_id
group by c.name, f.title;


#7. Is "Academy Dinosaur" available for rent from Store 1?
#Yes 
use sakila;
select f.title, i.inventory_id, i.store_id, r.return_date, i.last_update
from sakila.film as f
join sakila.inventory as i
on f.film_id = i.film_id
join sakila.rental as r
on i.inventory_id = r.inventory_id
where f.title = 'ACADEMY DINOSAUR' AND i.store_id = 1;
