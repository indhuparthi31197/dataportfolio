-- Customers
CREATE TABLE customers (
    customer_id INTEGER PRIMARY KEY,
    full_name TEXT NOT NULL,
    email TEXT UNIQUE,
    city TEXT,
    signup_date DATE
);

-- Employees (who handle orders)
CREATE TABLE employees (
    employee_id INTEGER PRIMARY KEY,
    full_name TEXT NOT NULL,
    hire_date DATE,
    department TEXT
);

-- Categories
CREATE TABLE categories (
    category_id INTEGER PRIMARY KEY,
    category_name TEXT NOT NULL
);

-- Products
CREATE TABLE products (
    product_id INTEGER PRIMARY KEY,
    product_name TEXT NOT NULL,
    category_id INTEGER,
    price REAL,
    FOREIGN KEY (category_id) REFERENCES categories(category_id)
);

-- Orders
CREATE TABLE orders (
    order_id INTEGER PRIMARY KEY,
    customer_id INTEGER,
    employee_id INTEGER,
    order_date DATE,
    status TEXT,
    FOREIGN KEY (customer_id) REFERENCES customers(customer_id),
    FOREIGN KEY (employee_id) REFERENCES employees(employee_id)
);

-- Order Items
CREATE TABLE order_items (
    order_item_id INTEGER PRIMARY KEY,
    order_id INTEGER,
    product_id INTEGER,
    quantity INTEGER,
    FOREIGN KEY (order_id) REFERENCES orders(order_id),
    FOREIGN KEY (product_id) REFERENCES products(product_id)
);

-- Payments
CREATE TABLE payments (
    payment_id INTEGER PRIMARY KEY,
    order_id INTEGER,
    payment_date DATE,
    amount REAL,
    payment_method TEXT,
    FOREIGN KEY (order_id) REFERENCES orders(order_id)
);
-- Customers
INSERT INTO customers VALUES
(1, 'Anna Kowalska', 'anna.k@example.com', 'Warsaw', '2024-01-10'),
(2, 'John Smith', 'john.s@example.com', 'London', '2024-02-05'),
(3, 'Maria Garcia', 'maria.g@example.com', 'Madrid', '2024-02-20'),
(4, 'Piotr Nowak', 'piotr.n@example.com', 'Krakow', '2024-03-01'),
(5, 'Laura Müller', 'laura.m@example.com', 'Berlin', '2024-03-15');

-- Employees
INSERT INTO employees VALUES
(1, 'Tomasz Zielinski', '2023-05-01', 'Sales'),
(2, 'Emily Brown', '2023-06-15', 'Sales'),
(3, 'Carlos Ruiz', '2023-07-01', 'Support');

-- Categories
INSERT INTO categories VALUES
(1, 'Electronics'),
(2, 'Books'),
(3, 'Home'),
(4, 'Sports');

-- Products
INSERT INTO products VALUES
(1, 'Laptop', 1, 1200.00),
(2, 'Headphones', 1, 150.00),
(3, 'SQL Book', 2, 45.00),
(4, 'Python Book', 2, 50.00),
(5, 'Coffee Machine', 3, 300.00),
(6, 'Running Shoes', 4, 180.00),
(7, 'Dumbbells', 4, 80.00);

-- Orders
INSERT INTO orders VALUES
(1, 1, 1, '2024-04-01', 'Completed'),
(2, 2, 2, '2024-04-02', 'Completed'),
(3, 1, 1, '2024-04-10', 'Pending'),
(4, 3, 3, '2024-04-12', 'Completed'),
(5, 4, 2, '2024-04-15', 'Completed'),
(6, 5, 1, '2024-04-20', 'Cancelled');

-- Order Items
INSERT INTO order_items VALUES
(1, 1, 1, 1),
(2, 1, 2, 2),
(3, 2, 3, 1),
(4, 2, 4, 1),
(5, 3, 6, 1),
(6, 4, 5, 1),
(7, 4, 3, 2),
(8, 5, 7, 2),
(9, 5, 2, 1),
(10, 6, 1, 1);

-- Payments
INSERT INTO payments VALUES
(1, 1, '2024-04-01', 1500.00, 'Card'),
(2, 2, '2024-04-02', 95.00, 'PayPal'),
(3, 4, '2024-04-12', 390.00, 'Card'),
(4, 5, '2024-04-15', 340.00, 'Card');
