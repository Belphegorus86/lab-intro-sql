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