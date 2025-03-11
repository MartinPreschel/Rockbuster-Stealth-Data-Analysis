# CTE Query to find the average amount paid by the top 5 customers.

SELECT AVG(total_amount_paid)
FROM
(SELECT A.customer_id,
	   A.first_name,
	   A.last_name,
	   C.city,
	   D.country,
SUM (E.amount) AS total_amount_paid
FROM customer A
INNER JOIN address B ON A.address_id = B.address_id
INNER JOIN city C ON B.city_id = C. city_id
INNER JOIN country D ON C.country_id = D.country_id
INNER JOIN payment E ON A.customer_id = E.customer_id
WHERE C.city IN ('Aurora','Acua','Citrus Heights','Iwaki','Ambattur',
		 'Shanwei','So Leopoldo','Teboksary','Tianjin','Cianjur')
GROUP BY A.customer_id,
	 A.first_name,
	 A.last_name,
	 C.city,
	 D.country
ORDER BY total_amount_paid DESC
LIMIT 5) AS average

#CTE Query to find out how many of the top 5 customers above are based in each country.

SELECT D.country, 
        COUNT (DISTINCT A. customer_id) AS all_customer_count,
        COUNT (top_5_customers) AS top_customer_count
FROM customer A
INNER JOIN address B ON A.address_ id = B.address_id
INNER JOIN city C ON B.city_id = C.city_id
INNER JOIN country D ON C.country_id = D.country_id
LEFT JOIN
(SELECT A.customer_id,
	   A.first_name,
	   A.last_name,
	   C.city,
	   D.country,
SUM (E.amount) AS total_amount_paid
FROM customer A
INNER JOIN address B ON A.address_id = B.address_id
INNER JOIN city C ON B.city_id = C. city_id
INNER JOIN country D ON C.country_id = D.country_id
INNER JOIN payment E ON A.customer_id = E.customer_id
WHERE C.city IN ('Aurora','Acua','Citrus Heights','Iwaki','Ambattur',
		 'Shanwei','So Leopoldo','Teboksary','Tianjin','Cianjur')
GROUP BY A.customer_id,
	 A.first_name,
	 A.last_name,
	 C.city,
	 D.country
ORDER BY total_amount_paid DESC
LIMIT 5) top_5_customers ON A.customer_id = top_5_customers.customer_id
GROUP BY D.country
ORDER BY all_customer_count DESC
LIMIT 5;
