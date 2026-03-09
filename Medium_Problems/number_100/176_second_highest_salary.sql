/*

    176. Second Highest Salary


    Table: Employee
    +-------------+------+
    | Column Name | Type |
    +-------------+------+
    | id          | int  |
    | salary      | int  |
    +-------------+------+
    id is the primary key (column with unique values) for this table.
    Each row of this table contains information about the salary of an employee.
    

    Write a solution to find the second highest distinct salary from the Employee table. If there is no second highest salary, return null (return None in Pandas).

    The result format is in the following example.

    

    Example 1:

    Input: 
    Employee table:
    +----+--------+
    | id | salary |
    +----+--------+
    | 1  | 100    |
    | 2  | 200    |
    | 3  | 300    |
    +----+--------+
    Output: 
    +---------------------+
    | SecondHighestSalary |
    +---------------------+
    | 200                 |
    +---------------------+
    Example 2:

    Input: 
    Employee table:
    +----+--------+
    | id | salary |
    +----+--------+
    | 1  | 100    |
    +----+--------+
    Output: 
    +---------------------+
    | SecondHighestSalary |
    +---------------------+
    | null                |
    +---------------------+


*/ 
  
  -- filename:

CREATE TABLE Employee (
    id INT PRIMARY KEY,
    salary INT
);

INSERT INTO Employee (id, salary) VALUES
(1, 100),
(2, 200),
(3, 300);


-- Solutoin 1 
SELECT DISTINCT salary AS SecondHighestSalary
FROM Employee
ORDER BY salary DESC
LIMIT 1 OFFSET 1;


 -- Solution 2 

    WITH second_sal AS ( 
    SELECT salary,
    ROW_NUMBER() OVER(ORDER BY salary) AS number
    FROM employee
    )
    SELECT salary AS SecondHighestSalary
    FROM second_sal
    WHERE number = 2

 -- Solutoin 3 
    SELECT
        (SELECT MAX(salary)
        FROM Employee
        WHERE salary < (SELECT MAX(salary) FROM Employee)
        ) AS SecondHighestSalary;   