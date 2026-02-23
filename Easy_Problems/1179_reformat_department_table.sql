/*
1179. Reformat Department


Table: Department
+-------------+---------+
| Column Name | Type    |
+-------------+---------+
| id          | int     |
| revenue     | int     |
| month       | varchar |
+-------------+---------+
In SQL,(id, month) is the primary key of this table.
The table has information about the revenue of each department per month.
The month has values in ["Jan","Feb","Mar","Apr","May","Jun","Jul","Aug","Sep","Oct","Nov","Dec"].
 

Reformat the table such that there is a department id column and a revenue column for each month.

Return the result table in any order.

The result format is in the following example.

 

Example 1:

Input: 
Department table:
+------+---------+-------+
| id   | revenue | month |
+------+---------+-------+
| 1    | 8000    | Jan   |
| 2    | 9000    | Jan   |
| 3    | 10000   | Feb   |
| 1    | 7000    | Feb   |
| 1    | 6000    | Mar   |
+------+---------+-------+
Output: 
+------+-------------+-------------+-------------+-----+-------------+
| id   | Jan_Revenue | Feb_Revenue | Mar_Revenue | ... | Dec_Revenue |
+------+-------------+-------------+-------------+-----+-------------+
| 1    | 8000        | 7000        | 6000        | ... | null        |
| 2    | 9000        | null        | null        | ... | null        |
| 3    | null        | 10000       | null        | ... | null        |
+------+-------------+-------------+-------------+-----+-------------+
*/



-- Create Department table
CREATE TABLE Department (
    id INT,
    revenue INT,
    month VARCHAR(3),
    PRIMARY KEY (id, month)
);

-- Insert sample data into Department
INSERT INTO Department (id, revenue, month) VALUES
(1, 8000, 'Jan'),
(2, 9000, 'Jan'),
(3, 10000, 'Feb'),
(1, 7000, 'Feb'),
(1, 6000, 'Mar');

SELECT * FROM department


-- Soulution 1

SELECT
    id,
    MIN(CASE WHEN month = 'Jan' THEN revenue END) AS Jan_Revenue,
    MAX(CASE WHEN month = 'Feb' THEN revenue END) AS Feb_Revenue,
    MAX(CASE WHEN month = 'Mar' THEN revenue END) AS Mar_Revenue,
    MAX(CASE WHEN month = 'Apr' THEN revenue END) AS Apr_Revenue,
    MAX(CASE WHEN month = 'May' THEN revenue END) AS May_Revenue,
    MAX(CASE WHEN month = 'Jun' THEN revenue END) AS Jun_Revenue,
    MAX(CASE WHEN month = 'Jul' THEN revenue END) AS Jul_Revenue,
    MAX(CASE WHEN month = 'Aug' THEN revenue END) AS Aug_Revenue,
    MAX(CASE WHEN month = 'Sep' THEN revenue END) AS Sep_Revenue,
    MAX(CASE WHEN month = 'Oct' THEN revenue END) AS Oct_Revenue,
    MAX(CASE WHEN month = 'Nov' THEN revenue END) AS Nov_Revenue,
    MAX(CASE WHEN month = 'Dec' THEN revenue END) AS Dec_Revenue
FROM Department
GROUP BY id;




-- Solution 2

SELECT DISTINCT
    d.id,
    j.revenue AS Jan_Revenue,
    f.revenue AS Feb_Revenue,
    m.revenue AS Mar_Revenue,
    a.revenue AS Apr_Revenue,
    ma.revenue AS May_Revenue,
    jn.revenue AS Jun_Revenue,
    jl.revenue AS Jul_Revenue,
    au.revenue AS Aug_Revenue,
    s.revenue AS Sep_Revenue,
    o.revenue AS Oct_Revenue,
    n.revenue AS Nov_Revenue,
    d2.revenue AS Dec_Revenue
FROM Department d
LEFT JOIN Department j  ON d.id = j.id AND j.month = 'Jan'
LEFT JOIN Department f  ON d.id = f.id AND f.month = 'Feb'
LEFT JOIN Department m  ON d.id = m.id AND m.month = 'Mar'
LEFT JOIN Department a  ON d.id = a.id AND a.month = 'Apr'
LEFT JOIN Department ma ON d.id = ma.id AND ma.month = 'May'
LEFT JOIN Department jn ON d.id = jn.id AND jn.month = 'Jun'
LEFT JOIN Department jl ON d.id = jl.id AND jl.month = 'Jul'
LEFT JOIN Department au ON d.id = au.id AND au.month = 'Aug'
LEFT JOIN Department s  ON d.id = s.id AND s.month = 'Sep'
LEFT JOIN Department o  ON d.id = o.id AND o.month = 'Oct'
LEFT JOIN Department n  ON d.id = n.id AND n.month = 'Nov'
LEFT JOIN Department d2 ON d.id = d2.id AND d2.month = 'Dec';