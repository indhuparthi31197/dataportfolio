--Show all orders with customer name and employee name

SELECT o.*,c.full_name as 'Customer Name',e.full_name as 'employee name'
 FROM orders o LEFT JOIN employees e ON e.employee_id = o.employee_id
 LEFT JOIN customers c ON o.customer_id = c.customer_id;
--Show each order wiath total order value
select * from order_items;
select * from payments;
SELECT o.*,(p.amount*o.quantity) as totals FROM order_items o JOIN payments p ON p.order_id = o.order_id;
--List all customers and their orders (including customers with no orders)
SELECT c.full_name,o.* FROM customers c LEFT JOIN orders o on c.customer_id = o.customer_id ;
--Show products that have never been ordered
SELECT p.product_name from products p LEFT JOIN order_items o ON p.product_id = o.product_id where o.product_id is NULL
--Show employees and how many orders each handled
SELECT e.employee_id,e.full_name,COUNT(o.order_id) as counts 
 FROM employees e left JOIN orders o ON e.employee_id = o.employee_id GROUP BY e.employee_id,e.full_name;
--Find customers who spent more than the average customer spending
SELECT c.customer_id,c.full_name FROM customers c JOIN orders o on c.customer_id = o.customer_id JOIN payments p ON p.order_id = o.order_id
GROUP BY c.customer_id,c.full_name
HAVING SUM(p.amount) > 
(SELECT AVG(totals) FROM
(SELECT c.customer_id,SUM(p.amount) as totals  FROM customers c JOIN orders o ON c.customer_id = o.customer_id
 JOIN payments p ON p.order_id = o.order_id group by c.customer_id) as t);
--Find products that are more expensive than the average price in their category
SELECT p.product_id,p.product_name FROM products p WHERE p.price >
(SELECT AVG(p2.price) FROM products p2 WHERE p2.category_id = p.category_id);

--Find orders that contain at least one product priced above the overall average product price

SELECT ord.*,p.price FROM order_items o JOIN products p ON p.product_id = o.product_id JOIN orders ord ON o.order_id = ord.order_id where o.product_id IN (
 select product_id FROM products where price > (select AVG(price) FROM products));
--Find the customer who made the most orders.
SELECT c.customer_id,full_name FROM customers c JOIN orders o on c.customer_id = o.customer_id  GROUP BY c.customer_id,c.full_name
 HAVING COUNT(o.order_id) = (SELECT MAX(counts) as highest FROM
 (SELECT COUNT(order_id) as counts  FROM orders GROUP BY customer_id));
--Find categories whose total sales value is higher than the overall average category sales
SELECT c.category_id,c.category_name fROM categories c JOIN products p on c.category_id = p.category_id
 GROUP BY c.category_id,c.category_name HAVING SUM(p.price) > (select AVG(totals) as average FROM
 (SELECT SUM(price) as totals from products GROUP BY category_id));
