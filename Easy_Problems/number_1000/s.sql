/*

1667. Fix Names in a Table

Table: Users

+----------------+---------+
| Column Name    | Type    |
+----------------+---------+
| user_id        | int     |
| name           | varchar |
+----------------+---------+
user_id is the primary key (column with unique values) for this table.
This table contains the ID and the name of the user. The name consists of only lowercase and uppercase characters.
 

Write a solution to fix the names so that only the first character is uppercase and the rest are lowercase.

Return the result table ordered by user_id.

The result format is in the following example.

 

Example 1:

Input: 
Users table:
+---------+-------+
| user_id | name  |
+---------+-------+
| 1       | aLice |
| 2       | bOB   |
+---------+-------+
Output: 
+---------+-------+
| user_id | name  |
+---------+-------+
| 1       | Alice |
| 2       | Bob   |
+---------+-------+


*/
DROP TABLE Users

 CREATE TABLE Users(
     user_id INT,
     name    TEXT
    
 )

 INSERT INTO Users (user_id,name) VALUES 
 (1,'aLice'),
 (2,'bOB');


-- Solution 1 CTE 
    WITH lower_name AS (
    SELECT user_id,
            LOWER(name) AS name
        FROM      
        Users
    )
    SELECT user_id,
        INITCAP(name)
    FROM lower_name    



