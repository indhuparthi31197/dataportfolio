--Top 3 best-selling products by quantity
with prods as 
(SELECT p.product_id,p.product_name,p.price,o.quantity FROM products p JOIN order_items o ON p.product_id = o.product_id)
Select product_name,sum(quantity) as counts from prods group by product_name ORDER BY counts DESC LIMIT 3;
--Monthly revenue summary
SELECT * from orders;
SELECT * from products;
SELECT * From order_items;
With monthly_rev as 
(SELECT o.order_id,o.order_date,oi.quantity,p.price,(oi.quantity * p.price) as totals
  FROM orders o JOIN order_items oi ON o.order_id = oi.order_id JOIN products p ON p.product_id = oi.product_id)
SELECT order_id,order_date,totals,SUM(totals) OVER(PARTITION BY strftime('%m',order_date)) as 'monthly Revenue' FROM monthly_rev;
--Percentage contribution of each category to total revenue

with cat_rev as 
(SELECT c.category_id,c.category_name,(oi.quantity * p.price) as rev
  FROM orders o JOIN order_items oi ON o.order_id = oi.order_id JOIN products p ON p.product_id = oi.product_id 
  JOIN categories c on c.category_id = p.category_id
  ),
total_revenue AS (
    SELECT SUM(rev) AS grand_total
    FROM cat_rev
)
SELECT cr.category_id,cr.category_name,cr.rev,ROUND((cr.rev * 100.0) / tr.grand_total, 2) AS percentage_revenue
FROM cat_rev cr JOIN total_revenue tr ORDER BY percentage_revenue DESC;
 