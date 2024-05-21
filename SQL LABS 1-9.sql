use sakila;

# -> lab 1 

# Get all the data from tables actor, film and customer.
select * from actor;

select * from film;

select * from customer;

# Get film titles.
select title from film;

# Get unique list of film languages under the alias language. 
select distinct name as language from language;

# 5.1 Find out how many stores does the company have?
select count(store_id) from store;

# 5.2 Find out how many employees staff does the company have?
select count(staff_id) from staff;

# 5.3 Return a list of employee first names only?
select first_name from staff;

# -> lab 2 

# 1. Select all the actors with the first name ‘Scarlett’.
select * from actor where first_name = "Scarlett";

# 2. Select all the actors with the last name ‘Johansson’.        
select * from actor where last_name = "Johansson";

# 3. How many films (movies) are available for rent?
select * from rental where return_date is NULL;
select count(rental_id) from rental;
select count(rental_id) from rental where return_date is NULL;

# 4. How many films have been rented?
select count(rental_id) from rental where return_date is not NULL;

# 5. What is the shortest and longest rental period?
select * from film;
select min(rental_duration) as shortest_rental, max(rental_duration) as longest_rental from film;

# 6. What are the shortest and longest movie duration? Name the values max_duration and min_duration.
select * from film; 
select min(length) as min_duration, max(length) as max_duration from film;

# 7. What's the average movie duration?
select avg(length) from film;

# 8. What's the average movie duration expressed in format (hours, minutes)?
SELECT 
    CONCAT(
        FLOOR(AVG(length) / 60), ' hours ',
        AVG(length) % 60, ' minutes'
    ) AS average_length 
FROM 
    film;
    
# 9. How many movies longer than 3 hours?
select * from film;
select count(*) from film where length > 180;

# 10. Get the name and email formatted. Example: Mary SMITH - mary.smith@sakilacustomer.org.
select concat(customer.first_name, ' ', (customer.last_name), ' - ', lower(customer.email)) as formatted from customer;

# 11. What's the length of the longest film title?
select MAX(length(title)) as longest_title from film;

# -> lab 3 

# 1. How many distinct (different) actors' last names are there?
select * from actor; 
select count(distinct last_name) from actor; 

# 2. In how many different languages where the films originally produced? (Use the column language_id from the film table)
select * from film;
select count(distinct language_id) from film;

# 3. How many movies were released with "PG-13" rating?
select * from film;
select count(*) from film where rating="PG-13";

# 4. Get 10 the longest movies from 2006.
select * from film;
select * from film order by length desc limit 10;

# 5. How many days has been the company operating (check DATEDIFF() function)?
select * from rental;
select max(rental_date) from rental;
select min(rental_date) from rental; 
select datediff("2006-02-23", "2005-05-24") as comp_operating_days; 

# 6. Show rental info with additional columns month and weekday. Get 20

select
    *,
    MONTHNAME(rental_date) AS month,
    DAYNAME(rental_date) AS weekday_name
from 
    rental
limit 20;

# 7. Add an additional column day_type with values 'weekend' and 'workday' depending on the rental day of the week.

select
	*,
    MONTHNAME(rental_date) AS month,
    DAYNAME(rental_date) AS weekday_name,
    case 
        when DAYOFWEEK(rental_date) in (1,7) then 'weekend'
        else 'workday'
    end as day_type
from 
    rental
limit 20; 

# 8. How many rentals were in the last month of activity?
select * from rental;
select count(rental_id) as last_month_rentals from rental where rental_date >= "2006-02-1";

# -> lab 4

# 1. How many distinct (different) actors' last names are there?

select distinct rating from film; 
    
# 2. Get release years.
select distinct release_year from film;

# 3. Get all films with ARMAGEDDON in the title.
select * from film where title like "%ARMAGEDDON%";

 # 4. Get all films with APOLLO in the title.   
select * from film where title like "%APOLLO%";

# 5. Get all films which title ends with APOLLO.
 select * from film where title like "%APOLLO";
 
# 6. Get all films with word DATE in the title.
select * from film where title like "%DATE%";

# 7. Get 10 films with the longest title.
select title from film order by length(title) desc limit 10;

# 8. Get 10 the longest films.
select * from film order by length desc limit 10;

# 9. How many films include Behind the Scenes content?
select count(*) from film where special_features like "%Behind the Scenes%";

# 10. List films ordered by release year and title in alphabetical order.
select title, release_year from film order by title, release_year desc;

# -> Lab 5

alter table staff
	drop column picture;
  
  
select * from customer where last_name = "Sanders";
INSERT INTO staff (first_name, last_name, email, address_id, store_id, active, username, password, last_update)
VALUES ('Tammy', 'Sanders', 'tammy.sanders@example.com', 79, 1, 1, 'tammy_sanders', 'password', NOW());


select * from rental;
select * from customer where last_name = "Hunter"; -- customer_id 130
select * from film where title = "Academy Dinosaur"; -- film_id 1
select * from inventory where film_id = "1"; -- inventory_id 1
select * from staff where last_name = "Hillyer"; -- staff_id 1
INSERT INTO rental (rental_date, inventory_id, customer_id, return_date, staff_id)
VALUES (NOW(), 1, 130, NULL, 1);


select * from customer;
create table deleted_users (
    deleted_user_id int auto_increment PRIMARY KEY,
    customer_id int,
    email varchar(255),
    deletion_date timestamp default current_timestamp
);

insert into deleted_users (customer_id, email)
	select customer_id, email
		from customer
			where active = 0;

select * from deleted_users;

delete from customer
	where active = 0; -- safe mode on, I dont want to disable it so to not delete the database by accident :D 
    
select count(active) 
	from customer 
		where active = 0;
       
# -> Lab 6


CREATE TABLE `films_2020` (
  `film_id` smallint(5) unsigned NOT NULL AUTO_INCREMENT,
  `title` varchar(255) NOT NULL,
  `description` text,
  `release_year` year(4) DEFAULT NULL,
  `language_id` tinyint(3) unsigned NOT NULL,
  `original_language_id` tinyint(3) unsigned DEFAULT NULL,
  `rental_duration` varchar(255) DEFAULT NULL,
  `rental_rate` varchar(255) DEFAULT NULL,
  `length` smallint(5) unsigned DEFAULT NULL,
  `replacement_cost` varchar(255) DEFAULT NULL,
  `rating` enum('G','PG','PG-13','R','NC-17') DEFAULT NULL,
  PRIMARY KEY (`film_id`),
  CONSTRAINT FOREIGN KEY (`original_language_id`) REFERENCES `language` (`language_id`) ON DELETE RESTRICT ON UPDATE CASCADE
) ENGINE=InnoDB AUTO_INCREMENT=1003 DEFAULT CHARSET=utf8;

select * from films_2020;

update films_2020
	set 
		rental_duration = 3,
		rental_rate = 2.99,
		replacement_cost = 8.99;
        
# -> Lab 7


select last_name, group_concat(first_name) AS first_names
	from actor
		group by last_name
			having count(*) = 1;

select last_name, group_concat(first_name) AS first_names
	from actor
		group by last_name
			having count(*) > 1;                

select staff_id, count(*)
	from rental
		group by staff_id;
        
select release_year , count(*) as films_released
	from film 
		group by release_year;

select rating, count(*)
	from film
		group by rating;
        
select rating, round(avg(length), 2) as mean_length
	from film
		group by rating;
        
select rating, round(avg(length), 2) as mean_length
	from film
		group by rating
			having mean_length > 120;
            
# -> Lab 8

select title, length, rank() over(order by length desc) as ranking
	from film
		where length is not NULL and length >0;
        
select title, length, rating, rank() over(order by length desc) as ranking
	from film
		where length is not NULL and length >0
        order by rating;
        
select c.name as category, count(fc.film_id) as number_of_films
	from category c
		join film_category fc on c.category_id = fc.category_id
			group by c.category_id, c.name
				order by number_of_films desc;

select a.actor_id, a.first_name, a.last_name, count(fa.film_id) as num_appearances
	from actor a
		join film_actor fa on a.actor_id = fa.actor_id
			group by a.actor_id, a.first_name, a.last_name
				order by num_appearances desc
				limit 1;

select c.customer_id, c.first_name, c.last_name, count(r.rental_id) as num_rentals
	from customer c
		join rental r on c.customer_id = r.customer_id
			group by c.customer_id, c.first_name, c.last_name
				order by num_rentals desc
				limit 1;
                
select f.title as film_title, count(r.rental_id) as num_rentals
	from film f 
		join inventory i on f.film_id = i.film_id
			join rental r on i.inventory_id = r.inventory_id
				group by f.title
					order by num_rentals desc
					limit 1;
                    
# -> Lab 9

create table rentals_may as
	select *
		from rental
			where month(rental_date) = 5;
select * from rentals_may;

create table rentals_june as
	select *
		from rental
			where month(rental_date) = 6;
select * from rentals_june;

select customer_id, count(*)
	from rentals_may
		group by customer_id 
        order by count(*) desc;
        
select customer_id, count(*)
	from rentals_june
		group by customer_id
        order by count(*) desc;
        