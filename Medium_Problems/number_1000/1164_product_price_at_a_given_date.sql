/*
1164. Product Price at a Given Date


Table: Products
+---------------+---------+
| Column Name   | Type    |
+---------------+---------+
| product_id    | int     |
| new_price     | int     |
| change_date   | date    |
+---------------+---------+
(product_id, change_date) is the primary key (combination of columns with unique values) of this table.
Each row of this table indicates that the price of some product was changed to a new price at some date.
Initially, all products have price 10.

Write a solution to find the prices of all products on the date 2019-08-16.

Return the result table in any order.

The result format is in the following example.

 

Example 1:

Input: 
Products table:
+------------+-----------+-------------+
| product_id | new_price | change_date |
+------------+-----------+-------------+
| 1          | 20        | 2019-08-14  |
| 2          | 50        | 2019-08-14  |
| 1          | 30        | 2019-08-15  |
| 1          | 35        | 2019-08-16  |
| 2          | 65        | 2019-08-17  |
| 3          | 20        | 2019-08-18  |
+------------+-----------+-------------+
Output: 
+------------+-------+
| product_id | price |
+------------+-------+
| 2          | 50    |
| 1          | 35    |
| 3          | 10    |
+------------+-------+

*/



CREATE TABLE Products (
    product_id INT,
    new_price INT,
    change_date DATE,
    PRIMARY KEY (product_id, change_date)
);

INSERT INTO Products (product_id, new_price, change_date) VALUES
(1, 20, '2019-08-14'),
(2, 50, '2019-08-14'),
(1, 30, '2019-08-15'),
(1, 35, '2019-08-16'),
(2, 65, '2019-08-17'),
(3, 20, '2019-08-18');




-- ### Solution 1



       SELECT 
       p.product_id,
       COALESCE(p2.new_price, 10) AS price
       FROM 
       (SELECT DISTINCT product_id FROM Products) p
       LEFT JOIN Products p2
       ON p.product_id = p2.product_id
       AND p2.change_date = (
       SELECT MAX(change_date)
       FROM Products
       WHERE product_id = p.product_id
       AND change_date <= '2019-08-16'
       );


     -- ### Solution 2 CTE 

     WITH latest AS (
    SELECT 
        product_id,
        MAX(change_date) AS last_date
    FROM Products
    WHERE change_date <= '2019-08-16'
    GROUP BY product_id
),
price_data AS (
    SELECT 
        p.product_id,
        p.new_price
    FROM Products p
    JOIN latest l
    ON p.product_id = l.product_id
    AND p.change_date = l.last_date
)
SELECT 
    p.product_id,
    COALESCE(pd.new_price, 10) AS price
FROM 
    (SELECT DISTINCT product_id FROM Products) p
LEFT JOIN price_data pd
ON p.product_id = pd.product_id;  


  -- ### Solution 3 CTE + Window 
    WITH latest AS (
        SELECT 
            product_id,
            new_price,
            ROW_NUMBER() OVER (
                PARTITION BY product_id
                ORDER BY change_date DESC
            ) AS rn
        FROM Products
        WHERE change_date <= '2019-08-16'
    )
    SELECT 
        DISTINCT p.product_id,
        COALESCE(l.new_price, 10) AS price
    FROM Products p
    LEFT JOIN latest l
    ON p.product_id = l.product_id
    AND l.rn = 1;

    