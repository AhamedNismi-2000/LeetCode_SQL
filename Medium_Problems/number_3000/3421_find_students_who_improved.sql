/*
3421 Find Students Who Improved


Table: Scores
+-------------+---------+
| Column Name | Type    |
+-------------+---------+
| student_id  | int     |
| subject     | varchar |
| score       | int     |
| exam_date   | varchar |
+-------------+---------+
(student_id, subject, exam_date) is the primary key for this table.
Each row contains information about a student's score in a specific subject on a particular exam date. score is between 0 and 100 (inclusive).
Write a solution to find the students who have shown improvement. A student is considered to have shown improvement if they meet both of these conditions:

Have taken exams in the same subject on at least two different dates
Their latest score in that subject is higher than their first score
Return the result table ordered by student_id, subject in ascending order.

The result format is in the following example.

 

Example:

Input:

Scores table:

+------------+----------+-------+------------+
| student_id | subject  | score | exam_date  |
+------------+----------+-------+------------+
| 101        | Math     | 70    | 2023-01-15 |
| 101        | Math     | 85    | 2023-02-15 |
| 101        | Physics  | 65    | 2023-01-15 |
| 101        | Physics  | 60    | 2023-02-15 |
| 102        | Math     | 80    | 2023-01-15 |
| 102        | Math     | 85    | 2023-02-15 |
| 103        | Math     | 90    | 2023-01-15 |
| 104        | Physics  | 75    | 2023-01-15 |
| 104        | Physics  | 85    | 2023-02-15 |
+------------+----------+-------+------------+
Output:

+------------+----------+-------------+--------------+
| student_id | subject  | first_score | latest_score |
+------------+----------+-------------+--------------+
| 101        | Math     | 70          | 85           |
| 102        | Math     | 80          | 85           |
| 104        | Physics  | 75          | 85           |
+------------+----------+-------------+--------------+
Explanation:

Student 101 in Math: Improved from 70 to 85
Student 101 in Physics: No improvement (dropped from 65 to 60)
Student 102 in Math: Improved from 80 to 85
Student 103 in Math: Only one exam, not eligible
Student 104 in Physics: Improved from 75 to 85
Result table is ordered by student_id, subject.



*/



CREATE TABLE Scores (
    student_id INT,
    subject VARCHAR(100),
    score INT,
    exam_date DATE,
    PRIMARY KEY (student_id, subject, exam_date)
);

INSERT INTO Scores (student_id, subject, score, exam_date) VALUES
(101, 'Math', 70, '2023-01-15'),
(101, 'Math', 85, '2023-02-15'),
(101, 'Physics', 65, '2023-01-15'),
(101, 'Physics', 60, '2023-02-15'),
(102, 'Math', 80, '2023-01-15'),
(102, 'Math', 85, '2023-02-15'),
(103, 'Math', 90, '2023-01-15'),
(104, 'Physics', 75, '2023-01-15'),
(104, 'Physics', 85, '2023-02-15');


 --### Solution 1 CTE 

    WITH high_pref AS (
          SELECT 
              student_id,
              subject,
              score,
              ROW_NUMBER() OVER (PARTITION BY student_id,subject ORDER BY exam_date) rn_first,
              ROW_NUMBER() OVER (PARTITION BY student_id,subject ORDER BY exam_date DESC) rn_latest
          FROM scores
    ) ,
    inter_table AS  (
    SELECT 
        student_id,
        subject,
        MAX(CASE WHEN rn_first = 1 THEN score END ) first_score,
        MAX(CASE WHEN rn_latest = 1 THEN score END) latest_score
    FROM high_pref
    GROUP BY student_id,subject
    ORDER BY student_id, subject
    )
    SELECT student_id,
           subject,
           first_score,
           latest_score
    FROM inter_table
    WHERE latest_score > first_score       


    --### Solution 2 CTE 
    
    WITH high_pref AS (
          SELECT 
              student_id,
              subject,
              score,
              ROW_NUMBER() OVER (PARTITION BY student_id,subject ORDER BY exam_date) rn_first,
              ROW_NUMBER() OVER (PARTITION BY student_id,subject ORDER BY exam_date DESC) rn_latest
          FROM scores
    ) 

    SELECT 
        student_id,
        subject,
        MAX(CASE WHEN rn_first = 1 THEN score END ) first_score,
        MAX(CASE WHEN rn_latest = 1 THEN score END) latest_score
    FROM high_pref
    GROUP BY student_id,subject
    HAVING MAX(CASE WHEN rn_latest = 1 THEN score END ) >  MAX(CASE WHEN rn_first = 1 THEN score END) 
    ORDER BY student_id, subject
  

  --### Solution 3 CTE 

WITH latest_date AS (
    SELECT 
        student_id,
        subject,
        score,
        MIN(exam_date) OVER(PARTITION BY student_id,subject ) AS first_date,
        MAX(exam_date) OVER(PARTITION BY student_id,subject ) AS last_date
    FROM Scores  
    )

   SELECT 
        s.student_id,
        s.subject,
        MAX(CASE WHEN s.exam_date = ld.first_date THEN s.score END ) first_score,   
        MAX(CASE WHEN s.exam_date = ld.last_date THEN s.score END ) latest_score   
   FROM Scores s 
   JOIN latest_date ld 
   ON s.student_id = ld.student_id
   AND s.subject = ld.subject
   GROUP BY s.student_id,s.subject
   HAVING  MAX(CASE WHEN s.exam_date = ld.last_date THEN s.score END ) >
            MAX(CASE WHEN s.exam_date = ld.first_date THEN s.score END ) 
    ORDER BY s.student_id,s.subject

