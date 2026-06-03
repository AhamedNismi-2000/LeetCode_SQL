/*
3451 Find Invalid IP Addresses

Table:  logs

+-------------+---------+
| Column Name | Type    |
+-------------+---------+
| log_id      | int     |
| ip          | varchar |
| status_code | int     |
+-------------+---------+
log_id is the unique key for this table.
Each row contains server access log information including IP address and HTTP status code.
Write a solution to find invalid IP addresses. An IPv4 address is invalid if it meets any of these conditions:

Contains numbers greater than 255 in any octet
Has leading zeros in any octet (like 01.02.03.04)
Has less or more than 4 octets
Return the result table ordered by invalid_count, ip in descending order respectively. 

The result format is in the following example.



Example:

Input:

logs table:

+--------+---------------+-------------+
| log_id | ip            | status_code | 
+--------+---------------+-------------+
| 1      | 192.168.1.1   | 200         | 
| 2      | 256.1.2.3     | 404         | 
| 3      | 192.168.001.1 | 200         | 
| 4      | 192.168.1.1   | 200         | 
| 5      | 192.168.1     | 500         | 
| 6      | 256.1.2.3     | 404         | 
| 7      | 192.168.001.1 | 200         | 
+--------+---------------+-------------+
Output:

+---------------+--------------+
| ip            | invalid_count|
+---------------+--------------+
| 256.1.2.3     | 2            |
| 192.168.001.1 | 2            |
| 192.168.1     | 1            |
+---------------+--------------+
Explanation:

256.1.2.3 is invalid because 256 > 255
192.168.001.1 is invalid because of leading zeros
192.168.1 is invalid because it has only 3 octets
The output table is ordered by invalid_count, ip in descending order respectively.


 */
    CREATE TABLE
        logs (
            log_id INT PRIMARY KEY,
            ip VARCHAR(255),
            status_code INT
        );

    INSERT INTO
        logs (log_id, ip, status_code)
    VALUES
        (1, '192.168.1.1', 200),
        (2, '256.1.2.3', 404),
        (3, '192.168.001.1', 200),
        (4, '192.168.1.1', 200),
        (5, '192.168.1', 500),
        (6, '256.1.2.3', 404),
        (7, '192.168.001.1', 200);


        --- ### Solution 1 

--  Write a solution to find invalid IP addresses. An IPv4 address is invalid if it meets any of these conditions:

-- Contains numbers greater than 255 in any octet
-- Has leading zeros in any octet (like 01.02.03.04)
-- Has less or more than 4 octets
-- Return the result table ordered by invalid_count, ip in descending order respectively. 


    WITH ip_parts AS (
        SELECT
            ip,
            split_part(ip, '.', 1) AS oct1,
            split_part(ip, '.', 2) AS oct2,
            split_part(ip, '.', 3) AS oct3,
            split_part(ip, '.', 4) AS oct4,
            LENGTH(ip) - LENGTH(REPLACE(ip, '.', '')) AS dot_count
        FROM logs
    )
    SELECT *
    FROM ip_parts;