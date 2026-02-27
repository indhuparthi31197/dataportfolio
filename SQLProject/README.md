
📌 Project Overview
Project Overview

This project demonstrates intermediate to advanced SQL skills using a realistic e-commerce / sales database built in SQLite.

The focus is on data analysis, business logic, and query design, beyond simple SELECT statements.
It simulates real-world analytics tasks encountered in enterprise databases.

** Tech Stack
**
SQLite – relational database

SQL – SELECT, JOINs, aggregations, subqueries, window functions

Python / Pandas (optional for ETL or validation)

** Database Schema**

The database contains the following tables:

Table	Description
customers--->	Customer details
employees--->	Employees handling orders
categories--->	Product categories
products--->	Product catalog
orders--->	Customer orders
order_items--->	Items within each order
payments--->	Payments made for orders
**Entity Relationships**

One customer → many orders

One order → many order items

One product → belongs to one category

One employee → handles many orders

🚀** Features / Queries
SQL Fundamentals**

SELECT, INSERT, UPDATE

Filtering with WHERE

Grouping with GROUP BY and HAVING

**Joins**

INNER JOIN, LEFT JOIN

Anti-joins to find missing data

**Subqueries**

Nested and correlated subqueries

Aggregate-of-aggregate queries

**Window Functions**

RANK(), DENSE_RANK(), ROW_NUMBER()

LAG()

Running totals using SUM() OVER()
