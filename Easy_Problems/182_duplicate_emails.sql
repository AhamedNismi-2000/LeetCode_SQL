/* LeetCode Problem 182: Duplicate Emails
182. Duplicate Emails

Table: Person

+-------------+---------+
| Column Name | Type    |
+-------------+---------+
| id          | int     |
| email       | varchar |
+-------------+---------+
id is the primary key (column with unique values) for this table.
Each row of this table contains an email. The emails will not contain uppercase letters.

Write a solution to report all the duplicate emails. Note that it's guaranteed that the email field is not NULL.
Return the result table in any order.
The result format is in the following example.

Input: 
Person table:
+----+---------+
| id | email   |
+----+---------+
| 1  | a@b.com |
| 2  | c@d.com |
| 3  | a@b.com |
+----+---------+
Output: 
+---------+
| Email   |
+---------+
| a@b.com |
+---------+
Explanation: a@b.com is repeated two times.
*/
-- Step 0: Drop the table if it exists
DROP TABLE IF EXISTS Person;

-- Step 1: Create the table
CREATE TABLE Person (
    id INT PRIMARY KEY,
    email VARCHAR(100) NOT NULL
);

-- Step 2: Insert sample values
INSERT INTO Person (id, email) VALUES
(1, 'a@b.com'),
(2, 'c@d.com'),
(3, 'a@b.com');


--Solution 
SELECT * FROM Person 

SELECT email
FROM Person
GROUP BY email
HAVING COUNT(*) > 1


-- Solution 2 

SELECT p1.email AS Email
FROM Person p1
JOIN Person p2
ON p1.email = p2.email
AND p1.id <> p2.id;


