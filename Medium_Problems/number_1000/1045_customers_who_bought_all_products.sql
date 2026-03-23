/*
1045 Customers Who Bought All Products


Table: Customer
+-------------+---------+
| Column Name | Type    |
+-------------+---------+
| customer_id | int     |
| product_key | int     |
+-------------+---------+
This table may contain duplicates rows. 
customer_id is not NULL.
product_key is a foreign key (reference column) to Product table.
 

Table: Product

+-------------+---------+
| Column Name | Type    |
+-------------+---------+
| product_key | int     |
+-------------+---------+
product_key is the primary key (column with unique values) for this table.
 

Write a solution to report the customer ids from the Customer table that bought all the products in the Product table.

Return the result table in any order.

The result format is in the following example.

 

Example 1:

Input: 
Customer table:
+-------------+-------------+
| customer_id | product_key |
+-------------+-------------+
| 1           | 5           |
| 2           | 6           |
| 3           | 5           |
| 3           | 6           |
| 1           | 6           |
+-------------+-------------+
Product table:
+-------------+
| product_key |
+-------------+
| 5           |
| 6           |
+-------------+
Output: 
+-------------+
| customer_id |
+-------------+
| 1           |
| 3           |
+-------------+
Explanation: 
The customers who bought all the products (5 and 6) are customers with IDs 1 and 3.


*/
 


CREATE TABLE Product (
    product_key INT PRIMARY KEY
);

CREATE TABLE Customer (
    customer_id INT NOT NULL,
    product_key INT,
    FOREIGN KEY (product_key) REFERENCES Product(product_key)
);

INSERT INTO Product (product_key) VALUES
(5),
(6);

INSERT INTO Customer (customer_id, product_key) VALUES
(1, 5),
(2, 6),
(3, 5),
(3, 6),
(1, 6);


 -- ### Solution 1 SubQuery 

        SELECT customer_id
    FROM Customer c
    JOIN Product p ON c.product_key = p.product_key
    GROUP BY customer_id
    HAVING COUNT(DISTINCT c.product_key) = (
        SELECT COUNT(*)
        FROM Product
    )
    ORDER BY customer_id;

    
    --Solution 2 CTE 
   
     WITH total_product AS (
        SELECT COUNT(product_key) AS total
        FROM product
     )
     SELECT customer_id
     FROM Customer c
     GROUP BY customer_id
     HAVING COUNT(customer_id) = (
         SELECT total FROM total_product
     )
     ORDER BY customer_id
