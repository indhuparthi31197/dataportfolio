
📌 Project Overview

This project demonstrates intermediate to advanced SQL skills using a realistic sales database built in SQLite.
The focus is on data analysis, business logic, and query design, rather than simple SELECT statements.

The project covers:

Multi-table joins

Aggregations and subqueries

Window functions

Common business analytics use cases

Clean, readable, and production-style SQL

** Database Schema**

The database simulates an e-commerce / sales system with the following tables:

customers – customer details

employees – employees handling orders

categories – product categories

products – product catalog

orders – customer orders

order_items – items within each order

payments – payments made for orders

Entity Relationships

One customer → many orders

One order → many order items

One product → belongs to one category

One employee → handles many orders

🧪 Skills Demonstrated
🔹 SQL Fundamentals

SELECT, INSERT, UPDATE

Filtering with WHERE

Grouping with GROUP BY and HAVING

🔹 Joins

INNER JOIN

LEFT JOIN

Anti-joins (finding missing data)

🔹 Subqueries

Nested subqueries

Correlated subqueries

Aggregate-of-aggregate patterns

🔹 Window Functions

RANK(), DENSE_RANK()

ROW_NUMBER()

LAG()

Running totals using SUM() OVER()

 **Business Questions Answered
 Data Manipulation**

Insert new customers, products, and orders

Update product prices and order statuses

🔗 Joins & Aggregations

Orders with customer and employee names

Order totals and customer spending

Products that were never ordered

Employees and number of orders handled

 **Analytical Queries**

Customers who spent more than the average customer

Products priced above their category average

Categories with above-average total sales

Top-selling products by quantity

Monthly revenue summary

Percentage contribution of each category to total revenue

** Window Function Analytics**

Rank customers by total spending

Rank products by price within category

Running total of revenue over time
