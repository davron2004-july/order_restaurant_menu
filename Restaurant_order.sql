-- VIEW menu_items table 
SELECT *
FROM menu_items;
-- to find number of items on menu
SELECT COUNT(*)
FROM menu_items;
-- what are the least and nost expensive items on the menu?
SELECT *
FROM menu_items
WHERE price IN (SELECT MAX(price) FROM menu_items ) ;

SELECT *
FROM menu_items
WHERE price IN (SELECT MIN(price) FROM menu_items ) ;
-- How many Italian dishes are on the menu? What are the least and most expensive Italian dishes on the menu?
SELECT menu_item_id
FROM menu_items
WHERE category="Italian";

SELECT *
FROM menu_items
WHERE category="Italian" AND price =(SELECT MAX(price) FROM menu_items);

SELECT *
FROM menu_items
WHERE category="Italian" AND price =(SELECT MIN(price) FROM menu_items);

-- How many dishes are in each category? What is the average dish price within each category?
SELECT category,COUNT(*)
FROM menu_items
GROUP BY category;

SELECT category,AVG(price)
FROM menu_items
GROUP BY category;
-- View the order_details table. What is the date range of the table?
SELECT *
FROM order_details;

SELECT 
MAX(order_date) AS start_date,
MIN(order_date) AS end_date,
DATEDIFF(MAX(order_date),MIN(order_date)) AS date_range
FROM order_details;
-- How many orders were made within this date range? How many items were ordered within this date range?
SELECT COUNT(*) AS total_orders
FROM order_details
WHERE order_date BETWEEN (SELECT MIN(order_date) FROM order_details) AND (SELECT MAX(order_date) FROM order_details);

SELECT COUNT(item_id) AS total_items
FROM order_details
WHERE order_date BETWEEN (SELECT MIN(order_date) FROM order_details) AND (SELECT MAX(order_date) FROM order_details);

-- Which orders had the most number of items?
SELECT order_id,COUNT(item_id) AS number_of_items
FROM order_details
GROUP BY order_id
ORDER BY COUNT(item_id) DESC ;

-- How many orders had more than 12 items?
SELECT order_id,COUNT(item_id) AS number_of_items
FROM order_details
GROUP BY order_id
HAVING number_of_items>12
ORDER BY COUNT(item_id) DESC;

-- Combine the menu_items and order_details tables into a single table
SELECT *
FROM menu_items
JOIN order_details
ON menu_items.menu_item_id=order_details.item_id;

-- What were the least and most ordered items? What categories were they in?
SELECT menu_items.category,COUNT(order_details.item_id) AS total_items
FROM menu_items
JOIN order_details 
ON menu_items.menu_item_id=order_details.item_id
GROUP BY menu_items.category
ORDER BY total_items DESC;

SELECT menu_items.category,COUNT(order_details.item_id) AS total_items
FROM menu_items
JOIN order_details 
ON menu_items.menu_item_id=order_details.item_id
GROUP BY menu_items.category
ORDER BY total_items;

-- What were the top 5 orders that spent the most money?
SELECT order_details.order_id,SUM(menu_items.price) AS total_spent
FROM menu_items 
JOIN order_details 
ON menu_items.menu_item_id=order_details.item_id
GROUP BY order_details.order_id 
ORDER BY total_spent DESC
LIMIT 5;

-- View the details of the highest spend order. Which specific items were purchased?
SELECT order_details.order_id,SUM(menu_items.price) AS total_spent,menu_items.item_name
FROM menu_items 
JOIN order_details 
ON menu_items.menu_item_id=order_details.item_id
GROUP BY order_details.order_id,menu_items.item_name
ORDER BY total_spent DESC;






















