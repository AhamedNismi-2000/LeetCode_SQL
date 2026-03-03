/*
LeetCode Problem 196: Delete Duplicate Emails
Difficulty: Easy

Table: Person
+-------------+---------+
| Column Name | Type    |
+-------------+---------+
| id          | int     |
| email       | varchar |
+-------------+---------+
id is the primary key (unique values).
Each row contains an email (lowercase only).

Task:
Delete all duplicate emails, keeping only the row with the smallest id.
After running the DELETE, the Person table should only have unique emails.

Example:

Input: 
Person table:
+----+------------------+
| id | email            |
+----+------------------+
| 1  | john@example.com |
| 2  | bob@example.com  |
| 3  | john@example.com |
+----+------------------+

Output:
+----+------------------+
| id | email            |
+----+------------------+
| 1  | john@example.com |
| 2  | bob@example.com  |
+----+------------------+
*/

DROP TABLE IF EXISTS Person;  

CREATE TABLE Person (
    id INT PRIMARY KEY,
    email VARCHAR(100)
);

INSERT INTO Person VALUES
(1,'john@example.com'),
(2,'bob@example.com'),
(3,'john@example.com');


-- Solution 1 

WITH cte AS (
    SELECT id,
           ROW_NUMBER() OVER (
               PARTITION BY email
               ORDER BY id
           ) AS rn
    FROM Person
)
DELETE FROM Person
WHERE id IN (
    SELECT id
    FROM cte
    WHERE rn > 1
);


SELECT * FROM Person

--Solution 2 Using 
DELETE FROM Person
WHERE id NOT IN (
    SELECT MIN(id)
    FROM Person
    GROUP BY email
);






