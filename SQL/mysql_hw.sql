####### SQL HOMEWORK ######;


USE sakila;

#1a. Display the first and last names of all actors from the table actor.;
SELECT first_name, last_name 
FROM actor;

#1b. Display the first and last name of each actor in a single column in upper case letters. Name the column Actor Name.;
SELECT first_name, last_name, CONCAT(first_name, last_name) AS Actor_name
FROM actor;

#2a. You need to find the ID number, first name, and last name of an actor, of whom you know only the first name, "Joe.";
SELECT actor_id, first_name, last_name
FROM actor
WHERE first_name = 'Joe';

#2b. Find all actors whose last name contain the letters GEN;
SELECT first_name, last_name
FROM actor
WHERE last_name LIKE '%GEN';

#2cFind all actors whose last names contain the letters LI. This time, order the rows by last name and first name, in that order:;
SELECT  last_name, first_name
FROM actor
WHERE last_name LIKE '%i' OR last_name LIKE '%l';

#2d. Using IN, display the country_id and country columns of the following countries: Afghanistan, Bangladesh, and China:;
SELECT country_id, country
FROM country
WHERE country_id IN (
	SELECT country_id
    FROM country
    WHERE country = 'Afghanistan' OR country = 'Bangladesh' OR country = 'China')
;

#3a. Add a middle_name column to the table actor. Position it between first_name and last_name.;
ALTER TABLE actor ADD COLUMN middle_name VARCHAR(50) AFTER `first_name`;

######
#3b. You realize that some of these actors have tremendously long last names. Change the data type of the middle_name column to blobs.;
ALTER TABLE actor ALTER COLUMN middle_name blob;

#3c. Now delete the middle_name column;
ALTER TABLE actor DROP COLUMN middle_name;

#4a. List the last names of actors, as well as how many actors have that last name.
SELECT last_name, COUNT(last_name) FROM actor GROUP BY last_name;

#4b. List last names of actors and the number of actors who have that last name, but only for names that are shared by at least two actors
SELECT last_name,
COUNT(*) COUNT
FROM actor
GROUP BY last_name
HAVING COUNT(*) >= 2;

/*4c. Oh, no! The actor HARPO WILLIAMS was accidentally entered in the actor table as GROUCHO WILLIAMS, 
the name of Harpo's second cousin's husband's yoga teacher. Write a query to fix the record.*/
UPDATE actor
	SET first_name = 'HARPO'
    WHERE first_name = 'GROUCHO' AND last_name = 'WILLIAMS';

#checking to make sure query worked properly    
SELECT first_name,last_name from actor where first_name = 'HARPO';

#########
/*4d. If the first name of the actor is currently HARPO, change it to GROUCHO. 
Otherwise, change the first name to MUCHO GROUCHO*/ 


#6a.Use JOIN to display the first and last names, as well as the address, of each staff member. Use the tables staff and address:;
SELECT * FROM staff;
SELECT * FROM address;

SELECT s.first_name, s.last_name, a.address
FROM staff as s
INNER JOIN address as a ON
s.address_id = a.address_id;


#6b. Use JOIN to display the total amount rung up by each staff member in August of 2005. Use tables staff and payment.;
SELECT * FROM staff;
SELECT * FROM payment;

SELECT s.first_name, s.last_name,p.payment_date, SUM(p.amount) as Total
FROM staff as s
INNER JOIN payment as p ON
s.staff_id=p.staff_id
GROUP BY p.staff_id , p.payment_date
HAVING p.payment_date BETWEEN "2005-08-01 00:00:00" and "2005-8-31 11:59:59";

#6c. List each film and the number of actors who are listed for that film. Use tables film_actor and film. Use inner join.;

SELECT * FROM film_actor;
SELECT * FROM film;

SELECT f.title, COUNT(fa.actor_id) as number_actors 
FROM film as f 
INNER JOIN film_actor as fa on 
f.film_id = fa.film_id
GROUP BY f.film_id;

#6d. How many copies of the film Hunchback Impossible exist in the inventory system?;
SELECT * FROM inventory;
SELECT * FROM film;

SELECT f.title, COUNT(i.inventory_id) as copies
FROM inventory as i
INNER JOIN film as f on 
i.film_id = f.film_id
GROUP BY i.film_id
HAVING title = 'Hunchback Impossible';

#ANSWER:6 copies of Hunchback Impossible;

/*6e. Using the tables payment and customer and the JOIN command, list the total paid by each customer. 
List the customers alphabetically by last name*/
SELECT * FROM payment;
SELECT * FROM customer;

SELECT c.first_name, c.last_name, SUM(p.amount) as Total
FROM customer as c
INNER JOIN payment as p ON
c.customer_id=p.customer_id
GROUP BY p.customer_id;

#7a.Use subqueries to display the titles of movies starting with the letters K and Q whose language is English.;
SELECT * FROM film;
SELECT * FROM language;

SELECT title
FROM film
WHERE language_id IN (
	SELECT language_id 
    FROM language
    WHERE language_id = 1 and  (title LIKE 'k%' OR title LIKE 'q%')
    );

#7b. Use subqueries to display all actors who appear in the film Alone Trip.;
SELECT * FROM film_actor;
SELECT * FROM film;
SELECT * FROM actor; 

SELECT first_name, last_name
FROM actor
WHERE actor_id IN (
	SELECT actor_id
    FROM film_actor
    WHERE film_id IN (
		SELECT film_id
        FROM film
        WHERE title = 'Alone Trip'
        )
	)
; 

#7c.you will need the names and email addresses of all Canadian customers. Use joins to retrieve this information.;
SELECT * FROM address;
SELECT * FROM country;
SELECT * FROM customer;
SELECT * FROM city;

SELECT c.email, co.country
FROM customer as c, country as co , city as ci, address as a
WHERE c.address_id = a.address_id and a.city_id=ci.city_id and ci.country_id=co.country_id and co.country_id=20;

#7d.Identify all movies categorized as famiy films;
SELECT * FROM film_category;
SELECT * FROM film;
SELECT * FROM category;

SELECT title
FROM film
WHERE film_id IN (
	SELECT film_id
    FROM film_category
    WHERE category_id IN (
		SELECT category_id
        FROM category
        WHERE name = 'family'
        )
	)
; 


#7e. Display the most frequently rented movies in descending order.

SELECT * FROM rental;
SELECT * FROM film;
SELECT * FROM inventory;

SELECT f.title, COUNT(r.rental_id) as rental_amount
FROM film as f inner join inventory as i on f.film_id = i.film_id
	inner join rental as r on r.inventory_id=i.inventory_id
GROUP BY f.title
ORDER By rental_amount DESC;





#7f. Write a query to display how much business, in dollars, each store brought in.

SELECT * FROM store;
SELECT * FROM rental;
SELECT * FROM payment;
SELECT * FROM staff; 

SELECT
	s.store_id,
    SUM(p.amount) as revenue
FROM store as s
	INNER JOIN staff as st on st.store_id = s.store_id
    INNER JOIN rental as r on r.staff_id = st.staff_id
    INNER JOIN payment as p on p.rental_id = r.rental_id
GROUP BY s.store_id;

#7g. Write a query to display for each store its store ID, city, and country.;
SELECT * FROM store;
SELECT * FROM city;
SELECT * FROM country;
SELECT * FROM address;

SELECT 
	s.store_id,
    c.city,
    co.country
FROM store as s 
	INNER JOIN address as a on a.address_id=s.address_id
    INNER JOIN city as c on c.city_id=a.city_id
    INNER JOIN country as co on co.country_id = c.country_id
GROUP BY s.store_id; 


/*7h. List the top five genres in gross revenue in descending order. 
(Hint: you may need to use the following tables: category, film_category, inventory, payment, and rental.)*/

SELECT * FROM category;
SELECT * FROM film_category;
SELECT * FROM inventory;
SELECT * FROM payment;
SELECT * FROM rental;

SELECT
	c.name,
    SUM(p.amount) AS revenue
FROM
	category as c
    INNER JOIN film_category as fc ON fc.category_id=c.category_id
    INNER JOIN inventory as i ON i.film_id = fc.film_id
    INNER JOIN rental as r ON r.inventory_id = i.inventory_id
    INNER JOIN payment as p ON p.rental_id = r.rental_id
GROUP BY c.name
ORDER By revenue DESC
LIMIT 5;


#8a.  Use the solution from the problem above to create a view.;
CREATE VIEW vw_op_five_genres AS
SELECT
	c.name,
    SUM(p.amount) AS revenue
FROM
	category as c
    INNER JOIN film_category as fc ON fc.category_id=c.category_id
    INNER JOIN inventory as i ON i.film_id = fc.film_id
    INNER JOIN rental as r ON r.inventory_id = i.inventory_id
    INNER JOIN payment as p ON p.rental_id = r.rental_id
GROUP BY c.name
ORDER By revenue DESC
LIMIT 5;
 
#8b. How would you display the view that you created in 8a?
SELECT  * FROM vw_op_five_genres; 


#8c. You find that you no longer need the view top_five_genres. Write a query to delete it.;
DROP VIEW IF EXISTS vw_op_five_genres;