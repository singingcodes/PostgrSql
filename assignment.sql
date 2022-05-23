-- SELECT all columns from film table.
SELECT * FROM film;
-- SELECT district,phone,postal_code from “address” table.
SELECT district,phone,postal_code FROM address;
--SELECT address,district,postal_code and concat them and get as “full_address”.
SELECT 
	address || district || postal_code as full_address
FROM address;
--SELECT customers that their name starts with “J”
SELECT * FROM customers WHERE first_name LIKE 'J%';
-- SELECT payments that amount value is between 3 and 5
SELECT * FROM payments WHERE amount BETWEEN 3 AND 5;
-- SELECT payments that happened between 2007-02-15 and 2007-02-20
SELECT * FROM payments WHERE payment_date BETWEEN '2007-02-15' AND '2007-02-20';
--SELECT movies that in inventory. (hint : use sub-query)
SELECT * FROM 
		film
WHERE  
		film_id
IN (SELECT film_id FROM inventory);
--SELECT payments  that amounts between 4-6 order desc by payment_date
SELECT * FROM payment WHERE amount BETWEEN 4 AND 6 ORDER BY payment_date DESC;
--SELECT first 5 customers ORDER by name DESC
SELECT * FROM customer ORDER BY first_name DESC LIMIT 5;
--SELECT first 5 customers ORDER by name ASC  but skip first 10
SELECT * FROM customer ORDER BY first_name ASC LIMIT 5 OFFSET 10;
--Insert 5 customers to database.
INSERT INTO customer (first_name,last_name,email,address_id) VALUES ('John','Doe','johndoe@gmail.com',8);
INSERT INTO customer (first_name,last_name,email,address_id) VALUES ('James','Brown','jbrown@gmail.com',9);
INSERT INTO customer (first_name,last_name,email,address_id) VALUES ('Clara','Tom','claratom@gmail.com',10);
INSERT INTO customer (first_name,last_name,email,address_id) VALUES ('Thomas','Edison','tedison@gmail.com',11);

'
-- Edit second customer’s name
UPDATE customer SET first_name = 'Jane' WHERE customer_id = 2;
--Delete last customer
DELETE FROM customers WHERE customer_id = 5;
-- List the total spend that are above the total average spend by grouping them with the customer_id.
SELECT 
	customer_id,
	SUM(amount) AS total_spent_by_customer,
	ROUND((SELECT AVG(amount)FROM payment),2) AS average
	FROM
	payment
	GROUP BY customer_id
	HAVING SUM(amount) > (
	SELECT AVG(amount) FROM payment
	)
    ORDER BY customer_id;
--Get total payment that is above the average of all payments, join staff who made rental and customer information.
SELECT 
    staff.first_name AS staff_first_name,
    staff.last_name AS staff_last_name,
    customer.first_name AS customer_first_name,
    customer.last_name As customer_last_name,
	SUM(payment.amount) As total_paid
FROM
    customer
     JOIN payment
        ON payment.customer_id = customer.customer_id
     JOIN staff
        ON payment.staff_id = staff.staff_id
		
GROUP BY customer.customer_id,staff.staff_id,payment.payment_id
HAVING 
SUM (payment.amount) > (
        SELECT
            AVG(amount)
        FROM
            payment
    )
ORDER BY
    total_paid DESC;
-- select all payments which happened between 2007-02-15 - 2007-02-20 and join customers who made payment
SELECT 
  *
FROM
    payment
    JOIN customer
        ON payment.customer_id = customer.customer_id
WHERE
    payment.payment_date BETWEEN '2007-02-15' AND '2007-02-20';
--select all films and sort by title
SELECT 
   *
FROM
    film
ORDER BY
    title;
-- select  all payments where amount between 2-5 join staff and customer
SELECT 
    staff.first_name AS staff_first_name,
    staff.last_name AS staff_last_name,
    customer.first_name AS customer_first_name,
    customer.last_name AS customer_last_name,
    payment.amount AS payment_amount
FROM
    payment
    JOIN customer
        ON payment.customer_id = customer.customer_id
    JOIN staff
        ON payment.staff_id = staff.staff_id
WHERE
    payment.amount BETWEEN 2 AND 5;
