-- 1. View the order_details table.
SELECT * FROM order_details;

-- 2. When did the orders take place?
SELECT MAX (order_date), MIN (order_date) FROM order_details;

-- 3. How many orders were there?
SELECT COUNT (DISTINCT order_id) FROM order_details;

-- 4. How many items were ordered?
SELECT COUNT(*) FROM order_details;

-- 5. Which orders involved the most number of items?
SELECT order_id, COUNT (item_id) AS num_items
FROM order_details
GROUP BY order_id
ORDER BY num_items DESC;

-- 6. How many orders had more than 12 items?
SELECT COUNT (*) FROM (
SELECT order_id, COUNT (item_id) AS num_items
FROM order_details
GROUP BY order_id
HAVING COUNT (item_id) > 12
ORDER BY num_items DESC);



