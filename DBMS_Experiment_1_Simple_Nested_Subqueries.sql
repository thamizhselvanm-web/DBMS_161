/* ============================================================================
   EX NO: 1
   TITLE : SIMPLE, NESTED AND SUBQUERIES
   AIM   : To implement and execute simple queries, nested queries, and
           subqueries in relational database management systems using SQL.
   DBMS  : MySQL 8.0+ / ANSI SQL
   ============================================================================
   ALGORITHM:
   ---------
   STEP 1: Create the database schema and switch context.
   STEP 2: Create relational tables (Students, Courses, Enrollments) with
           appropriate primary key and foreign key constraints.
   STEP 3: Insert sample records into all tables.
   STEP 4: Execute simple projection and filtering queries (WHERE clause).
   STEP 5: Execute nested queries using membership operators (IN, NOT IN).
   STEP 6: Execute subqueries using aggregate functions (AVG, COUNT) and
           comparison operators.
   STEP 7: Verify outputs and conclude the experiment.
   ============================================================================ */

DROP DATABASE IF EXISTS dbms_query_lab;
CREATE DATABASE dbms_query_lab;
USE dbms_query_lab;

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
    CourseName VARCHAR(50) NOT NULL
);

CREATE TABLE Enrollments (
    StudentID INT NOT NULL,
    CourseID INT NOT NULL,
    PRIMARY KEY (StudentID, CourseID),
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
(101, 'Database Management'),
(102, 'Algorithms'),
(103, 'Web Development');

INSERT INTO Enrollments (StudentID, CourseID) VALUES
(1, 101),
(1, 102),
(2, 102),
(3, 101),
(3, 103),
(4, 103);

-- ============================================================================
-- 3. SIMPLE QUERIES
-- ============================================================================

-- 3.1 Retrieve all students
SELECT * FROM Students;

/* OUTPUT:
+-----------+---------+-----+
| StudentID | Name    | Age |
+-----------+---------+-----+
|         1 | Alice   |  20 |
|         2 | Bob     |  22 |
|         3 | Charlie |  21 |
|         4 | David   |  19 |
+-----------+---------+-----+
4 rows in set
*/

-- 3.2 Retrieve names and ages of students older than 20
SELECT Name, Age
FROM Students
WHERE Age > 20;

/* OUTPUT:
+---------+-----+
| Name    | Age |
+---------+-----+
| Bob     |  22 |
| Charlie |  21 |
+---------+-----+
2 rows in set
*/

-- ============================================================================
-- 4. NESTED QUERIES
-- ============================================================================

-- 4.1 Find students enrolled in 'Database Management'
SELECT Name
FROM Students
WHERE StudentID IN (
    SELECT StudentID
    FROM Enrollments
    WHERE CourseID = (
        SELECT CourseID
        FROM Courses
        WHERE CourseName = 'Database Management'
    )
);

/* OUTPUT:
+---------+
| Name    |
+---------+
| Alice   |
| Charlie |
+---------+
2 rows in set
*/

-- 4.2 Retrieve courses having more than one student enrolled
SELECT CourseID, CourseName
FROM Courses
WHERE CourseID IN (
    SELECT CourseID
    FROM Enrollments
    GROUP BY CourseID
    HAVING COUNT(*) > 1
);

/* OUTPUT:
+----------+---------------------+
| CourseID | CourseName          |
+----------+---------------------+
|      101 | Database Management |
|      103 | Web Development     |
+----------+---------------------+
2 rows in set
*/

-- ============================================================================
-- 5. SUBQUERIES
-- ============================================================================

-- 5.1 Calculate the average age of all students
SELECT AVG(Age) AS AverageAge
FROM Students;

/* OUTPUT:
+------------+
| AverageAge |
+------------+
|    20.5000 |
+------------+
1 row in set
*/

-- 5.2 Find students whose age is greater than the average age
SELECT Name, Age
FROM Students
WHERE Age > (
    SELECT AVG(Age)
    FROM Students
);

/* OUTPUT:
+---------+-----+
| Name    | Age |
+---------+-----+
| Bob     |  22 |
| Charlie |  21 |
+---------+-----+
2 rows in set
*/

-- ============================================================================
-- 6. VERIFICATION QUERIES
-- ============================================================================

-- 6.1 Verify Courses table records
SELECT * FROM Courses;

/* OUTPUT:
+----------+---------------------+
| CourseID | CourseName          |
+----------+---------------------+
|      101 | Database Management |
|      102 | Algorithms          |
|      103 | Web Development     |
+----------+---------------------+
3 rows in set
*/

-- 6.2 Verify Enrollments table records
SELECT * FROM Enrollments;

/* OUTPUT:
+-----------+----------+
| StudentID | CourseID |
+-----------+----------+
|         1 |      101 |
|         1 |      102 |
|         2 |      102 |
|         3 |      101 |
|         3 |      103 |
|         4 |      103 |
+-----------+----------+
6 rows in set
*/

-- 6.3 Show the number of students enrolled in each course
SELECT
    c.CourseID,
    c.CourseName,
    COUNT(e.StudentID) AS StudentCount
FROM Courses c
LEFT JOIN Enrollments e
    ON c.CourseID = e.CourseID
GROUP BY c.CourseID, c.CourseName
ORDER BY c.CourseID;

/* OUTPUT:
+----------+---------------------+--------------+
| CourseID | CourseName          | StudentCount |
+----------+---------------------+--------------+
|      101 | Database Management |            2 |
|      102 | Algorithms          |            2 |
|      103 | Web Development     |            2 |
+----------+---------------------+--------------+
3 rows in set
*/

-- ============================================================================
-- RESULT:
-- Simple queries, nested queries with subqueries, and aggregation operations
-- were executed successfully, and outputs were verified.
-- ============================================================================
