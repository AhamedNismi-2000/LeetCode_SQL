/*
-- LeetCode Problem: Employees Earning More Than Their Managers
-- Table: Employee
-- +----+-------+--------+-----------+      
-- | id | name  | salary | managerId |
-- +----+-------+--------+-----------+
-- | 1  | Joe   | 70000  | 3         |
-- | 2  | Henry | 80000  | 4         |
-- | 3  | Sam   | 60000  | NULL      |
-- | 4  | Max   | 90000  | NULL      |
-- +----+-------+--------+-----------+


-- Find employees who earn more than their managers.

Output

+----------+
| Employee |
+----------+
| Joe      |
+----------+
*/
-- Step 0: Drop the table if it exists
DROP TABLE IF EXISTS Employee;

-- Step 1: Create the table
CREATE TABLE Employee (
    id INT PRIMARY KEY,
    name VARCHAR(50),
    salary INT,
    managerId INT
);

-- Step 2: Insert sample values
INSERT INTO Employee (id, name, salary, managerId) VALUES
(1, 'Joe', 70000, 3),
(2, 'Henry', 80000, 4),
(3, 'Sam', 60000, NULL),
(4, 'Max', 90000, NULL);

SELECT * FROM employee


-- Solution Self Join

SELECT e.name Employee
FROM Employee e 
INNER JOIN Employee m ON 
e.managerId = m.id 
WHERE e.salary > m.salary 







