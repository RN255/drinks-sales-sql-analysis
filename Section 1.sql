-- Section 1 - Understand the munu items

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

	



	



	