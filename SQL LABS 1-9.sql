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

