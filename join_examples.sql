# This SQL query retrieves the top 10 countries with the highest number of customers for Rockbuster.

SELECT D.country, COUNT(A.customer_id) AS customer_count
FROM customer A
INNER JOIN address B ON A.address_id = B.address_id INNER JOIN city C ON B.city_id = C.city_id
INNER JOIN country D ON C.country_id = D.country_id GROUP BY D.country
ORDER BY customer_count DESC
LIMIT 10;



# This SQL query retrieves the top 10 cities with the highest number of customers within the top 10 countries identified earlier.

SELECT C.city, D.country, COUNT(A.customer_id) AS customer_count
FROM customer A
INNER JOIN address B ON A.address_id = B.address_id INNER JOIN city C ON B.city_id = C.city_id
INNER JOIN country D ON C.country_id = D.country_id WHERE D.country IN (
SELECT country FROM (
SELECT D.country
FROM customer A
INNER JOIN address B ON A.address_id = B.address_id INNER JOIN city C ON B.city_id = C.city_id
INNER JOIN country D ON C.country_id = D.country_id GROUP BY D.country
ORDER BY COUNT(A.customer_id) DESC
LIMIT 10
) AS top_countries )
GROUP BY C.city, D.country ORDER BY customer_count DESC LIMIT 10;



# This SQL query retrieves the top 5 customers from the top 10 cities who have paid the highest total amount to Rockbuster.

SELECT A.customer_id, A.first_name, A.last_name, D.country, C.city, SUM(E.amount) AS total_amount_paid
FROM customer A
INNER JOIN address B ON A.address_id = B.address_id INNER JOIN city C ON B.city_id = C.city_id
INNER JOIN country D ON C.country_id = D.country_id INNER JOIN payment E ON A.customer_id = E.customer_id WHERE C.city IN (
SELECT city FROM (
SELECT C.city
FROM customer A
INNER JOIN address B ON A.address_id = B.address_id INNER JOIN city C ON B.city_id = C.city_id
INNER JOIN country D ON C.country_id = D.country_id GROUP BY C.city
ORDER BY COUNT(A.customer_id) DESC
LIMIT 10
) AS top_cities )
GROUP BY A.customer_id, A.first_name, A.last_name, D.country, C.city
ORDER BY total_amount_paid DESC
LIMIT 5;
