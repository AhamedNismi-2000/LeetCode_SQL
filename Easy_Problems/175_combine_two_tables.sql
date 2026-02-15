
/*
LeetCode Problem Example: Person and Address Tables

Tables:

1. Person
+-----------+---------+
| Column    | Type    |
+-----------+---------+
| personId  | int     |
| lastName  | varchar |
| firstName | varchar |
+-----------+---------+
- personId is the primary key.
- Contains information about a person's first and last names.

2. Address
+-----------+---------+
| Column    | Type    |
+-----------+---------+
| addressId | int     |
| personId  | int     |
| city      | varchar |
| state     | varchar |
+-----------+---------+
- addressId is the primary key.
- Each row contains city and state information for a person (personId).

Write a solution to report the first name, last name, city, and state of each person in the Person table. 
If the address of a personId is not present in the Address table, report null instead.
*/

-- Drop tables first (child first, then parent) to avoid errors

DROP TABLE IF EXISTS Address;
DROP TABLE IF EXISTS Person;

-- Create Person table
CREATE TABLE Person (
    personId INT PRIMARY KEY,
    lastName VARCHAR(50),
    firstName VARCHAR(50)
);

-- Insert sample data into Person
INSERT INTO Person (personId, lastName, firstName) VALUES
(1, 'Wang', 'Allen'),
(2, 'Alice', 'Bob'),
(3, 'Unknown', 'Unknown');  -- Added to satisfy Address.personId=3


-- Create Address table
CREATE TABLE Address (
    addressId INT PRIMARY KEY,
    personId INT,
    city VARCHAR(50),
    "state" VARCHAR(50),
    FOREIGN KEY (personId) REFERENCES Person(personId)
);

-- Insert sample data into Address
INSERT INTO Address (addressId, personId, city, "state") VALUES
(1, 2, 'New York City', 'New York'),
(2, 3, 'Leetcode', 'California');


-- Solution 

SELECT firstname,lastname,city,"state"
FROM Person p
LEFT JOIN Address a 
ON p.personId=a.personId

