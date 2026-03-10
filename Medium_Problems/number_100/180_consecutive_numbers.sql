/*
180. Consecutive Numbers


Table: Logs
+-------------+---------+
| Column Name | Type    |
+-------------+---------+
| id          | int     |
| num         | varchar |
+-------------+---------+
In SQL, id is the primary key for this table.
id is an autoincrement column starting from 1.
 

Find all numbers that appear at least three times consecutively.

Return the result table in any order.

The result format is in the following example.

 

Example 1:

Input: 
Logs table:
+----+-----+
| id | num |
+----+-----+
| 1  | 1   |
| 2  | 1   |
| 3  | 1   |
| 4  | 2   |
| 5  | 1   |
| 6  | 2   |
| 7  | 2   |
+----+-----+
Output: 
+-----------------+
| ConsecutiveNums |
+-----------------+
| 1               |
+-----------------+
Explanation: 1 is the only number that appears consecutively for at least three times.
 

*/


    CREATE TABLE Logs (
        id INT PRIMARY KEY GENERATED ALWAYS AS IDENTITY,
        num VARCHAR(255)
    );

    INSERT INTO Logs (num) VALUES
    ('1'),
    ('1'),
    ('1'),
    ('2'),
    ('1'),
    ('2'),
    ('2');

 

-- Solution LEAD() 

   WITH consecutive AS (
      SELECT num,
      LEAD(num,1) OVER(ORDER BY id)  AS prev1,
      LEAD(num,2) OVER(ORDER BY id)  AS prev2
      FROM logs
   )
   SELECT num 
   FROM consecutive
   WHERE num = prev1 AND num = prev2
   

-- Solution LAG() 
   WITH consecutive AS (
      SELECT num,
       LAG(num,1) OVER(ORDER BY id)  AS prev1,
       LAG(num,2) OVER(ORDER BY id)  AS prev2
      FROM logs

   )
   SELECT num 
   FROM consecutive
   WHERE num = prev1 AND num = prev2
   

