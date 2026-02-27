--Insert a new customer and create a new order for them with at least 2 products.
INSERT INTO customers VALUES(6,'Patrick Willson','patrick.w@example.com','Vienna','2025-11-02');
INSERT INTO orders VALUES
(7, 6, 2, '2025-12-01', 'Completed'),(8,6,2,'2025-12-24','Completed');
--Add a new product category and 2 products inside it.
INSERT INTO categories VALUES
(5, 'Stationery');
INSERT INTO products VALUES (8, 'Pen', 5, 5.00),(9,'Paint',5,10.00);
--Update the price of all books by +10%
UPDATE products SET price =(price * 1.1) where category_id=2;
SELECT * FROM products;
--Change the status of all “Pending” orders to “Completed”.
UPDATE orders SET status = 'Completed' WHERE status = 'Pending';
--Update a customer’s city to gdansk for id 1
UPDATE customers SET city = 'Gdansk' WHERE customer_id = 1;
select * from customers;