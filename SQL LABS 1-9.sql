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
