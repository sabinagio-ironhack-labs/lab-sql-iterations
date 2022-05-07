USE sakila;

# 1. Write a query to find what is the total business done by each store.
SELECT 
	store_id, 
	ROUND(SUM(amount)) AS total_business 
FROM 
	payment
JOIN staff USING (staff_id)
GROUP BY store_id;

# 2. Convert the previous query into a stored procedure.
DELIMITER //
CREATE PROCEDURE total_biz()
BEGIN
SELECT 
	store_id, 
	ROUND(SUM(amount)) AS total_business 
FROM 
	payment
JOIN staff USING (staff_id)
GROUP BY store_id;
END //

CALL total_biz();

# 3. Convert the previous query into a stored procedure that takes the input for store_id 
# and displays the total sales for that store.
DELIMITER //
CREATE PROCEDURE total_biz_per_store(in store_no int)
BEGIN
SELECT 
	store_id, 
	ROUND(SUM(amount)) AS total_business 
FROM 
	payment
JOIN staff USING (staff_id)
WHERE store_id = store_no
GROUP BY store_id;
END //

CALL total_biz_per_store(1);

# 4. Update the previous query. Declare a variable total_sales_value of float type, 
# that will store the returned result (of the total sales amount for the store). 
# Call the stored procedure and print the results.
DELIMITER //
CREATE PROCEDURE total_store_biz(in store_no int)
BEGIN
DECLARE total_sales_amount FLOAT;
SELECT total_business INTO total_sales_amount
FROM
(SELECT 
	store_id, 
	ROUND(SUM(amount)) AS total_business 
FROM 
	payment
JOIN staff USING (staff_id)
WHERE store_id = store_no
GROUP BY store_id) AS table1;
-- SELECT total_sales_amount;
END //
DELIMITER ;

DROP PROCEDURE total_store_biz;

CALL total_store_biz(1);
SELECT @amount;

# 5. In the previous query, add another variable flag. If the total sales value for the store is over 30.000, 
# then label it as green_flag, otherwise label is as red_flag. Update the stored procedure that 
# takes an input as the store_id and returns total sales value for that store and flag value.
DELIMITER //
CREATE PROCEDURE total_store_biz(in store_no int)
BEGIN
DECLARE total_sales_amount FLOAT;
SELECT total_business INTO total_sales_amount
FROM
(SELECT 
	store_id, 
	ROUND(SUM(amount)) AS total_business 
FROM 
	payment
JOIN staff USING (staff_id)
WHERE store_id = store_no
GROUP BY store_id) AS table1;
-- SELECT total_sales_amount;
END //
DELIMITER ;


