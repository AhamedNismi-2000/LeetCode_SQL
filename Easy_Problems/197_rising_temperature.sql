/*
Table: Weather

197. Rising Temperature
+---------------+---------+
| Column Name   | Type    |
+---------------+---------+
| id            | int     |
| recordDate    | date    |
| temperature   | int     |
+---------------+---------+
id is the column with unique values for this table.
There are no different rows with the same recordDate.
This table contains information about the temperature on a certain day.
 

Write a solution to find all dates' id with higher temperatures compared to its previous dates (yesterday).

Return the result table in any order.

The result format is in the following example.

 

Example 1:

Input: 
Weather table:
+----+------------+-------------+
| id | recordDate | temperature |
+----+------------+-------------+
| 1  | 2015-01-01 | 10          |
| 2  | 2015-01-02 | 25          |
| 3  | 2015-01-03 | 20          |
| 4  | 2015-01-04 | 30          |
+----+------------+-------------+
Output: 
+----+
| id |
+----+
| 2  |
| 4  |
+----+
Explanation: 
*/

-- Create Weather table
DROP TABLE IF EXISTS Weather

CREATE TABLE Weather (
    id INT PRIMARY KEY,
    recordDate DATE,
    temperature INT
);

-- Insert sample data into Weather
INSERT INTO Weather (id, recordDate, temperature) VALUES
(1, '2015-01-01', 10),
(2, '2015-01-02', 25),
(3, '2015-01-03', 20),
(4, '2015-01-04', 30);


--Solution All Join Are Working here 
SELECT w1.id,
       w1.temperature,
       w1.recorddate
FROM Weather w1 
INNER JOIN Weather w2 ON
w1.recorddate=w2.recorddate + INTERVAL '1 day'
WHERE w1.temperature > w2.temperature 

-- Solution Using CTE 
WITH prev_day AS (
    SELECT
        id,
        temperature,
        LAG(temperature) OVER (ORDER BY recorddate) AS prev_temp
    FROM Weather
)
SELECT id
FROM prev_day
WHERE temperature > prev_temp;





