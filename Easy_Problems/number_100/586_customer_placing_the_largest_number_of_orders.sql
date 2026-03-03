/*
586. Customer Placing the Largest Number of Orders


Table: Orders
+-----------------+----------+
| Column Name     | Type     |
+-----------------+----------+
| order_number    | int      |
| customer_number | int      |
+-----------------+----------+

order_number is the primary key (column with unique values) for this table.
This table contains information about the order ID and the customer ID.
 

Write a solution to find the customer_number for the customer who has placed the largest number of orders.

The test cases are generated so that exactly one customer will have placed more orders than any other customer.

The result format is in the following example.

 

Example 1:

Input: 
Orders table:
+--------------+-----------------+
| order_number | customer_number |
+--------------+-----------------+
| 1            | 1               |
| 2            | 2               |
| 3            | 3               |
| 4            | 3               |
+--------------+-----------------+
Output: 
+-----------------+
| customer_number |
+-----------------+
| 3               |
+-----------------+

*/


-- File: 586_customer_placing_the_largest_number_of_orders.sql


DROP TABLE IF EXISTS Orders;

-- Create Orders table
CREATE TABLE Orders (
    order_number INT PRIMARY KEY,
    customer_number INT
);

-- Insert sample data into Orders
INSERT INTO Orders (order_number, customer_number) VALUES
(1, 1),
(2, 2),
(3, 3),
(4, 3);


-- Solution 1

SELECT customer_number
FROM Orders
GROUP BY customer_number
ORDER BY COUNT(*) DESC
LIMIT 1

-- Solution 2 Using CTE 

WITH high_order AS(
    SELECT customer_number,
    COUNT(*) OVER(PARTITION BY customer_number) AS order_count 
    FROM Orders
)
SELECT customer_number
FROM high_order
ORDER BY  order_count DESC
LIMIT 1 ;

-- Solution 2 Using Subquery

SELECT customer_number
FROM (
    SELECT customer_number,
           COUNT(*) OVER (PARTITION BY customer_number) AS order_count
    FROM Orders
) t
ORDER BY order_count DESC
LIMIT 1;



