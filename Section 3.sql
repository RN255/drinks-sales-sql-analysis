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







	