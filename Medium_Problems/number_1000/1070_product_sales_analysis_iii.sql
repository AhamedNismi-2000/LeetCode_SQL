/*
1070 Product Sales Analysis III


Table: Sales
+-------------+-------+
| Column Name | Type  |
+-------------+-------+
| sale_id     | int   |
| product_id  | int   |
| year        | int   |
| quantity    | int   |
| price       | int   |
+-------------+-------+
(sale_id, year) is the primary key (combination of columns with unique values) of this table.
Each row records a sale of a product in a given year.
A product may have multiple sales entries in the same year.
Note that the per-unit price.

Write a solution to find all sales that occurred in the first year each product was sold.

For each product_id, identify the earliest year it appears in the Sales table.

Return all sales entries for that product in that year.

Return a table with the following columns: product_id, first_year, quantity, and price.
Return the result in any order.

 

Example 1:

Input: 
Sales table:
+---------+------------+------+----------+-------+
| sale_id | product_id | year | quantity | price |
+---------+------------+------+----------+-------+ 
| 1       | 100        | 2008 | 10       | 5000  |
| 2       | 100        | 2009 | 12       | 5000  |
| 7       | 200        | 2011 | 15       | 9000  |
+---------+------------+------+----------+-------+

Output: 
+------------+------------+----------+-------+
| product_id | first_year | quantity | price |
+------------+------------+----------+-------+ 
| 100        | 2008       | 10       | 5000  |
| 200        | 2011       | 15       | 9000  |
+------------+------------+----------+-------+


*/

  -- filename: 1070_product_sales_analysis_iii.sql

CREATE TABLE Sales (
    sale_id INT,
    product_id INT,
    year INT,
    quantity INT,
    price INT,
    PRIMARY KEY (sale_id, year)
);

INSERT INTO Sales (sale_id, product_id, year, quantity, price) VALUES
(1, 100, 2008, 10, 5000),
(2, 100, 2009, 12, 5000),
(7, 200, 2011, 15, 9000);


 --Solution 1 CTE 

    WITH min_sales AS (   
      SELECT product_id,
            MIN(year) AS first_year
      FROM Sales
      GROUP BY product_id
  )
  SELECT s.product_id,
        ms.first_year,
        s.quantity,
        s.price
  FROM Sales s
  JOIN min_sales ms
    ON s.product_id = ms.product_id
    AND s.year=ms.first_year
  

  -- Solution 2 SubQuery 

    SELECT product_id,
           year AS first_year,
           quantity,
           price
FROM Sales 
WHERE year = (
    SELECT MIN(year)
    FROM Sales s
    WHERE product_id = s.product_id
);