/* ============================================================================
   EX NO: 2
   TITLE : IMPLEMENTATION OF SQL COMMANDS FOR JOIN QUERIES
   AIM   : To implement and execute various relational JOIN queries
           (INNER JOIN, LEFT OUTER JOIN, RIGHT OUTER JOIN, and FULL OUTER JOIN)
           in a relational database management system.
   DBMS  : MySQL 8.0+ / ANSI SQL
   ============================================================================
   ALGORITHM:
   ---------
   STEP 1: Create the database schema and initialize table objects.
   STEP 2: Define primary entity tables (Students, Courses) and associative
           relation table (Enrollments) with primary key and foreign key constraints.
   STEP 3: Insert representative sample data containing matched, left-unmatched,
           and right-unmatched tuples.
   STEP 4: Execute INNER JOIN to retrieve rows with matching foreign keys in both tables.
   STEP 5: Execute LEFT OUTER JOIN to preserve all records from the left table
           with NULL padding for non-matching right records.
   STEP 6: Execute RIGHT OUTER JOIN to preserve all records from the right table
           with NULL padding for non-matching left records.
   STEP 7: Execute FULL OUTER JOIN (using UNION of LEFT and RIGHT JOINs in MySQL)
           to combine all matched and unmatched records from both tables.
   STEP 8: Verify all tabular outputs and conclude the experiment.
   ============================================================================ */

DROP DATABASE IF EXISTS dbms_joins_lab;
CREATE DATABASE dbms_joins_lab;
USE dbms_joins_lab;

-- ============================================================================
-- 1. TABLE CREATION
-- ============================================================================

CREATE TABLE Students (
    StudentID INT PRIMARY KEY,
    Name VARCHAR(30) NOT NULL,
    Age INT NOT NULL
);

CREATE TABLE Courses (
    CourseID INT PRIMARY KEY,
    CourseName VARCHAR(30) NOT NULL
);

CREATE TABLE Enrollments (
    EnrollmentID INT PRIMARY KEY,
    StudentID INT NOT NULL,
    CourseID INT NOT NULL,
    Grade VARCHAR(5),
    CONSTRAINT fk_enrollment_student
        FOREIGN KEY (StudentID) REFERENCES Students(StudentID),
    CONSTRAINT fk_enrollment_course
        FOREIGN KEY (CourseID) REFERENCES Courses(CourseID)
);

-- ============================================================================
-- 2. INSERT SAMPLE DATA
-- ============================================================================

INSERT INTO Students (StudentID, Name, Age) VALUES
(1, 'Alice', 20),
(2, 'Bob', 22),
(3, 'Charlie', 21),
(4, 'David', 19);

INSERT INTO Courses (CourseID, CourseName) VALUES
(1, 'Math'),
(2, 'English'),
(3, 'History'),
(4, 'Physics');

INSERT INTO Enrollments (EnrollmentID, StudentID, CourseID, Grade) VALUES
(1, 1, 1, 'A'),
(2, 1, 2, 'B'),
(3, 2, 1, 'A-'),
(4, 3, 3, 'B+'),
(5, 3, 2, 'A');

-- Note:
-- Student 'David' (4) is enrolled in no courses (tests LEFT OUTER JOIN null padding).
-- Course 'Physics' (4) has no enrolled students (tests RIGHT OUTER JOIN null padding).

-- ============================================================================
-- 3. INNER JOIN
-- Retrieves only records where student and course match an enrollment.
-- ============================================================================

SELECT
    s.StudentID,
    s.Name,
    s.Age,
    c.CourseID,
    c.CourseName,
    e.Grade
FROM Students s
INNER JOIN Enrollments e
    ON s.StudentID = e.StudentID
INNER JOIN Courses c
    ON e.CourseID = c.CourseID
ORDER BY e.EnrollmentID;

/* OUTPUT:
+-----------+---------+-----+----------+------------+-------+
| StudentID | Name    | Age | CourseID | CourseName | Grade |
+-----------+---------+-----+----------+------------+-------+
|         1 | Alice   |  20 |        1 | Math       | A     |
|         1 | Alice   |  20 |        2 | English    | B     |
|         2 | Bob     |  22 |        1 | Math       | A-    |
|         3 | Charlie |  21 |        3 | History    | B+    |
|         3 | Charlie |  21 |        2 | English    | A     |
+-----------+---------+-----+----------+------------+-------+
5 rows in set
*/

-- ============================================================================
-- 4. LEFT OUTER JOIN
-- Retrieves all students, including David who has no enrollment.
-- ============================================================================

SELECT
    s.StudentID,
    s.Name,
    s.Age,
    c.CourseID,
    c.CourseName,
    e.Grade
FROM Students s
LEFT JOIN Enrollments e
    ON s.StudentID = e.StudentID
LEFT JOIN Courses c
    ON e.CourseID = c.CourseID
ORDER BY s.StudentID, e.EnrollmentID;

/* OUTPUT:
+-----------+---------+-----+----------+------------+-------+
| StudentID | Name    | Age | CourseID | CourseName | Grade |
+-----------+---------+-----+----------+------------+-------+
|         1 | Alice   |  20 |        1 | Math       | A     |
|         1 | Alice   |  20 |        2 | English    | B     |
|         2 | Bob     |  22 |        1 | Math       | A-    |
|         3 | Charlie |  21 |        2 | English    | A     |
|         3 | Charlie |  21 |        3 | History    | B+    |
|         4 | David   |  19 |     NULL | NULL       | NULL  |
+-----------+---------+-----+----------+------------+-------+
6 rows in set
*/

-- ============================================================================
-- 5. RIGHT OUTER JOIN
-- Retrieves all courses, including Physics which has no student enrollment.
-- ============================================================================

SELECT
    s.StudentID,
    s.Name,
    s.Age,
    c.CourseID,
    c.CourseName,
    e.Grade
FROM Students s
RIGHT JOIN Enrollments e
    ON s.StudentID = e.StudentID
RIGHT JOIN Courses c
    ON e.CourseID = c.CourseID
ORDER BY c.CourseID, e.EnrollmentID;

/* OUTPUT:
+-----------+---------+-----+----------+------------+-------+
| StudentID | Name    | Age | CourseID | CourseName | Grade |
+-----------+---------+-----+----------+------------+-------+
|         1 | Alice   |  20 |        1 | Math       | A     |
|         2 | Bob     |  22 |        1 | Math       | A-    |
|         1 | Alice   |  20 |        2 | English    | B     |
|         3 | Charlie |  21 |        2 | English    | A     |
|         3 | Charlie |  21 |        3 | History    | B+    |
|      NULL | NULL    | NULL|        4 | Physics    | NULL  |
+-----------+---------+-----+----------+------------+-------+
6 rows in set
*/

-- ============================================================================
-- 6. FULL OUTER JOIN
-- Emulated in MySQL using UNION of LEFT JOIN and RIGHT JOIN.
-- Preserves unmatched students (David) AND unmatched courses (Physics).
-- ============================================================================

SELECT
    s.StudentID,
    s.Name,
    s.Age,
    c.CourseID,
    c.CourseName,
    e.Grade
FROM Students s
LEFT JOIN Enrollments e
    ON s.StudentID = e.StudentID
LEFT JOIN Courses c
    ON e.CourseID = c.CourseID

UNION

SELECT
    s.StudentID,
    s.Name,
    s.Age,
    c.CourseID,
    c.CourseName,
    e.Grade
FROM Students s
RIGHT JOIN Enrollments e
    ON s.StudentID = e.StudentID
RIGHT JOIN Courses c
    ON e.CourseID = c.CourseID;

/* OUTPUT:
+-----------+---------+------+----------+------------+-------+
| StudentID | Name    | Age  | CourseID | CourseName | Grade |
+-----------+---------+------+----------+------------+-------+
|         1 | Alice   |   20 |        1 | Math       | A     |
|         1 | Alice   |   20 |        2 | English    | B     |
|         2 | Bob     |   22 |        1 | Math       | A-    |
|         3 | Charlie |   21 |        2 | English    | A     |
|         3 | Charlie |   21 |        3 | History    | B+    |
|         4 | David   |   19 |     NULL | NULL       | NULL  |
|      NULL | NULL    | NULL |        4 | Physics    | NULL  |
+-----------+---------+------+----------+------------+-------+
7 rows in set
*/

-- ============================================================================
-- RESULT:
-- SQL JOIN commands (INNER JOIN, LEFT OUTER JOIN, RIGHT OUTER JOIN, and FULL
-- OUTER JOIN via UNION) were successfully executed and verified with expected outputs.
-- ============================================================================
