--Rank customers by total spending (highest to lowest).
with ord_amounts as
(select c.customer_id,c.full_name,t.totals FROM customers c JOIN 
(SELECT ord.customer_id,(p.price*o.quantity) as totals FROM order_items o JOIN products p ON p.product_id = o.product_id 
JOIN orders ord ON ord.order_id = o.order_id) as t
ON c.customer_id = t.customer_id)

select customer_id,full_name,totals,rank() OVer(Order by totals desc) as ranks from ord_amounts;
--Show each order with a running total of sales over time (by order_date)

with  ord_totals as (
SELECT ord.order_id,(p.price*o.quantity) as totals,ord.order_date FROM order_items o JOIN products p ON p.product_id = o.product_id 
JOIN orders ord ON ord.order_id = o.order_id)
select order_id,totals,SUM(totals) OVER(ORDER BY order_date) as sum_overtime FROM ord_totals;
--For each category, rank products by price
WITH category_prod as (
SELECT c.*,p.price FROM categories c JOIN products p ON c.category_id = p.category_id)
SELECT *, RANK() OVER(PARTITION BY category_name ORDER BY price) as 'rank category' FROM category_prod;
--Show each employee’s orders with row number per employee ordered by date
select * from employees;

with emp_ords as (
select e.employee_id,e.full_name,o.order_date FROM employees e JOIN orders o ON e.employee_id = o.employee_id)
SELECT *,ROW_NUMBER() OVER(PARTITION BY employee_id ORDER BY order_date ) as 'rows' FROM emp_ords
--For each customer, show their orders and the difference in days from their previous order
WITH cust_ords AS (
SELECT c.customer_id,c.full_name,o.order_date FROM customers c JOIN orders o ON c.customer_id = o.customer_id
)
SELECT customer_id,full_name,order_date,LAG(order_date) OVER (PARTITION BY customer_id ORDER BY order_date) AS previous_order_date,(strftime('%s', order_date) 
        - strftime('%s', LAG(order_date) OVER (PARTITION BY customer_id ORDER BY order_date))
       ) / 86400 AS days_previous_order
FROM cust_ords
ORDER BY customer_id, order_date;
