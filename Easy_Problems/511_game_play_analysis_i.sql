/*
511. Game Play Analysis I 
Table: Activity


+--------------+---------+
| Column Name  | Type    |
+--------------+---------+
| player_id    | int     |
| device_id    | int     |
| event_date   | date    |
| games_played | int     |


+--------------+---------+
(player_id, event_date) is the primary key (combination of columns with unique values) of this table.
This table shows the activity of players of some games.
Each row is a record of a player who logged in and played a number of games (possibly 0) before logging out on someday using some device.
 

Write a solution to find the first login date for each player.

Return the result table in any order.

The result format is in the following example.

 

Example 1:


Input: 
Activity table:
+-----------+-----------+------------+--------------+
| player_id | device_id | event_date | games_played |
+-----------+-----------+------------+--------------+
| 1         | 2         | 2016-03-01 | 5            |
| 1         | 2         | 2016-05-02 | 6            |
| 2         | 3         | 2017-06-25 | 1            |
| 3         | 1         | 2016-03-02 | 0            |
| 3         | 4         | 2018-07-03 | 5            |
+-----------+-----------+------------+--------------+


Output: 
+-----------+-------------+
| player_id | first_login |
+-----------+-------------+
| 1         | 2016-03-01  |
| 2         | 2017-06-25  |
| 3         | 2016-03-02  |
+-----------+-------------+

*/




-- Create Activity table
CREATE TABLE Activity (
    player_id INT,
    device_id INT,
    event_date DATE,
    games_played INT,
    PRIMARY KEY (player_id, event_date)
);

SELECT * FROM activity

-- Insert sample data into Activity
INSERT INTO Activity (player_id, device_id, event_date, games_played) VALUES
(1, 2, '2016-03-01', 5),
(1, 2, '2016-05-02', 6),
(2, 3, '2017-06-25', 1),
(3, 1, '2016-03-02', 0),
(3, 4, '2018-07-03', 5);


-- Solution 1


SELECT player_id,

       MIN(event_date) AS first_login
FROM Activity
GROUP BY player_id
ORDER BY player_id



-- Solution 2 

SELECT player_id, event_date AS first_login,prev_login
FROM (
    SELECT player_id,
           event_date,
           LAG(event_date) OVER(PARTITION BY player_id ORDER BY event_date) AS prev_login
    FROM Activity
) t
WHERE prev_login IS NULL;



-- Solution 3 

WITH prev_date AS (
    SELECT player_id,
           event_date,
           ROW_NUMBER() OVER (PARTITION BY player_id ORDER BY event_date) AS rn 
    FROM Activity

)
SELECT player_id,
       event_date AS first_login ,
       rn 
FROM  prev_date 
WHERE rn=1


-- Solutoin 4 
WITH prev_log AS (
SELECT
    player_id,
    MIN(event_date) OVER(PARTITION BY player_id ORDER BY event_date ) AS first_login
    FROM Activity
)
SELECT player_id,
       first_login
       FROM prev_log
       GROUP BY player_id ,first_login
       ORDER BY player_id



-- Solution 4 

WITH prev_log AS (
SELECT
    player_id,
    event_date,
    MIN(event_date) OVER(PARTITION BY player_id ORDER BY event_date ) AS first_login
    FROM Activity   
)
SELECT player_id,
       first_login
FROM prev_log
WHERE event_date = first_login