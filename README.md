# Drink sales analysis

This was based on a tutorial by Maven Analytics. I adjusted the data to make it about cocktail drinks.

![Screenshot of a comment on a GitHub issue showing an image, added in the Markdown, of an Octocat smiling and raising a tentacle.](../main/Screenshot%202025-09-20%20210014.jpg)

Notes:

## Section 1 - Understand the munu items

-- 1. View the menu items table 

SELECT * FROM menu_items;

-- 2. Rename the 'category' column as 'origin' 

ALTER TABLE menu_items
RENAME COLUMN category TO origin;

-- 3. How many itmes are on the menu?

SELECT COUNT(*) FROM menu_items;

-- There are 32 items on the menu.

-- 4. What are the least and most expensive items on the menu?

SELECT * FROM menu_items
	ORDER BY price DESC;
 
-- The most expensive itme is "Last Word" at 19.95.

SELECT * FROM menu_items
	ORDER BY price;
 
-- The least expensive items are "Mai Tai", "Caipirinha", "Old Fashioned" and "Espresso Martini" at 9.95.

-- 5. How many drinks on the menu are from Italy?

SELECT COUNT (*) FROM menu_items
	WHERE origin = 'Italy';
	-- Three drinks items on the menu are from Italy.

SELECT * FROM menu_items
	WHERE origin = 'Italy';
	-- The drinks from Italy are "Negroni", "Cosmopolitan" and "Tom Collins".

-- 6. What are the most and least expensive British dishes?

SELECT * FROM menu_items
	WHERE origin = 'United Kingdom'
	ORDER BY price;
	-- The cheapest item from the UK is "Leviathan".

SELECT * FROM menu_items
	WHERE origin = 'United Kingdom'
	ORDER BY price DESC;
 
-- The most expensive items from the UK are "Gimlet" and "Mint Julep".

-- 7. How many drinks are there for each country?

SELECT origin, COUNT (*) 
FROM menu_items
GROUP BY origin;

-- The US has the most with 14 drinks. Malaysia, Bermuda, Puerto Rico and Brazil and have one.

-- 8. What is the average price of a drink for each counrty?

SELECT origin, ROUND(AVG(price),2)
FROM menu_items
GROUP BY origin;

-- The average price of a drink from the USA is 14.43.

## Section 2 - Understand the order details

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

## Section 3 - Understand the most popular items and most valuale orders

-- 1. Combine the menu_items and order_details tables into a single table.

SELECT * FROM menu_items;
SELECT * FROM order_details;

-- menu_items menu_item_id and order_details item_id seem to join. 

SELECT *
FROM order_details od LEFT JOIN menu_items mi
	ON od.item_id = mi.menu_item_id;

-- 2. What were the least and most ordered items? What were these cocktails from?

SELECT item_name, origin, COUNT(order_details_id) AS num_purchases
FROM order_details od LEFT JOIN menu_items mi
	ON od.item_id = mi.menu_item_id
GROUP BY item_name, origin
ORDER BY num_purchases DESC;

-- Martini (Gin or Vodka) (United States) was ordered the most with 622. Cosmopolitan (Italy) was ordered the least with 123.

-- 3. What were the top five spending orders?

SELECT order_id, SUM(price) AS total_spend
FROM order_details od LEFT JOIN menu_items mi
	ON od.item_id = mi.menu_item_id
GROUP BY order_id
HAVING SUM(price) IS NOT NULL
ORDER BY total_spend DESC
LIMIT 5;

-- The top five spending orders are; order 440 (219.05), order 443 (217.60), order 3473 (214.05), order 330 (212.60) and order 3583 (211.10).

-- 4. View the details from the highest order

SELECT *
FROM order_details od LEFT JOIN menu_items mi
	ON od.item_id = mi.menu_item_id
WHERE order_id = 440;

-- 5. View the details of the top 5 highest spend orders.

SELECT order_id, item_name, COUNT (item_id) AS num_items
FROM order_details od LEFT JOIN menu_items mi
	ON od.item_id = mi.menu_item_id
WHERE order_id IN(440, 443, 3473, 330, 3583)
GROUP BY order_id, item_name;
