/* ============================================================================
   EX NO: 3
   TITLE : CREATE VIEW AND INDEX FOR DATABASE TABLES WITH A LARGE NUMBER OF RECORDS
   AIM   : To execute and verify SQL commands for creating, querying, and
           modifying VIEWs and creating performance INDEXes on database tables.
   DBMS  : MySQL 8.0+ / ANSI SQL
   ============================================================================
   ALGORITHM:
   ---------
   STEP 1: Initialize database environment and create table `students`.
   STEP 2: Insert initial sample records into `students` table and verify.
   STEP 3: Create a logical VIEW `student_view` over `students` and query it.
   STEP 4: Demonstrate base table DML mutations:
           - INSERT a new record ('Diana Prince').
           - UPDATE an existing record ('Bob Smith').
           - DELETE a record ('Charlie Brown').
   STEP 5: Query `student_view` to verify that modifications to underlying base
           table reflect immediately in the view.
   STEP 6: Create a B-Tree INDEX `idx_student_email` on the email column.
   STEP 7: Inspect index metadata using `SHOW INDEX FROM students`.
   STEP 8: Execute an index-accelerated predicate search query.
   STEP 9: Conclude and verify all outputs.
   ============================================================================ */

DROP DATABASE IF EXISTS dbms_views_indexes_lab;
CREATE DATABASE dbms_views_indexes_lab;
USE dbms_views_indexes_lab;

-- ============================================================================
-- 1. TABLE CREATION
-- ============================================================================

CREATE TABLE students (
    student_id INT AUTO_INCREMENT PRIMARY KEY,
    student_name VARCHAR(100) NOT NULL,
    student_email VARCHAR(100) NOT NULL
);

-- ============================================================================
-- 2. INSERT INITIAL SAMPLE DATA
-- ============================================================================

INSERT INTO students (student_name, student_email) VALUES
('Alice Johnson', 'alice@example.com'),
('Bob Smith', 'bob@example.com'),
('Charlie Brown', 'charlie@example.com');

-- Verify base table contents
SELECT * FROM students;

/* OUTPUT:
+------------+---------------+---------------------+
| student_id | student_name  | student_email       |
+------------+---------------+---------------------+
|          1 | Alice Johnson | alice@example.com   |
|          2 | Bob Smith     | bob@example.com     |
|          3 | Charlie Brown | charlie@example.com |
+------------+---------------+---------------------+
3 rows in set
*/

-- ============================================================================
-- 3. CREATE VIEW
-- Virtual abstraction layer over students base table.
-- ============================================================================

CREATE OR REPLACE VIEW student_view AS
SELECT
    student_id,
    student_name,
    student_email
FROM students;

-- Verify view contents before base table modifications
SELECT * FROM student_view;

/* OUTPUT:
+------------+---------------+---------------------+
| student_id | student_name  | student_email       |
+------------+---------------+---------------------+
|          1 | Alice Johnson | alice@example.com   |
|          2 | Bob Smith     | bob@example.com     |
|          3 | Charlie Brown | charlie@example.com |
+------------+---------------+---------------------+
3 rows in set
*/

-- ============================================================================
-- 4. INSERT A NEW RECORD (DML OPERATION 1)
-- ============================================================================

INSERT INTO students (student_name, student_email)
VALUES ('Diana Prince', 'diana@example.com');

/* OUTPUT:
Query OK, 1 row affected
*/

-- ============================================================================
-- 5. UPDATE AN EXISTING RECORD (DML OPERATION 2)
-- ============================================================================

UPDATE students
SET student_email = 'new_bob@example.com'
WHERE student_name = 'Bob Smith';

/* OUTPUT:
Query OK, 1 row affected
Rows matched: 1  Changed: 1  Warnings: 0
*/

-- ============================================================================
-- 6. DELETE A RECORD (DML OPERATION 3)
-- ============================================================================

DELETE FROM students
WHERE student_name = 'Charlie Brown';

/* OUTPUT:
Query OK, 1 row affected
*/

-- ============================================================================
-- 7. VERIFY CHANGES THROUGH THE VIEW
-- Confirm that view reflects base table INSERT, UPDATE, and DELETE.
-- ============================================================================

SELECT * FROM student_view
ORDER BY student_id;

/* OUTPUT:
+------------+---------------+---------------------+
| student_id | student_name  | student_email       |
+------------+---------------+---------------------+
|          1 | Alice Johnson | alice@example.com   |
|          2 | Bob Smith     | new_bob@example.com |
|          4 | Diana Prince  | diana@example.com   |
+------------+---------------+---------------------+
3 rows in set
*/

-- ============================================================================
-- 8. CREATE INDEX ON STUDENT EMAIL
-- Accelerates predicate lookup on student_email.
-- ============================================================================

CREATE INDEX idx_student_email
ON students (student_email);

/* OUTPUT:
Query OK, 0 rows affected
Records: 0  Duplicates: 0  Warnings: 0
*/

-- ============================================================================
-- 9. VERIFY INDEX METADATA
-- ============================================================================

SHOW INDEX FROM students;

/* OUTPUT:
+----------+------------+-------------------+--------------+---------------+-----------+-------------+----------+--------+------+------------+---------+---------------+---------+------------+
| Table    | Non_unique | Key_name          | Seq_in_index | Column_name   | Collation | Cardinality | Sub_part | Packed | Null | Index_type | Comment | Index_comment | Visible | Expression |
+----------+------------+-------------------+--------------+---------------+-----------+-------------+----------+--------+------+------------+---------+---------------+---------+------------+
| students |          0 | PRIMARY           |            1 | student_id    | A         |           3 |     NULL |   NULL |      | BTREE      |         |               | YES     | NULL       |
| students |          1 | idx_student_email |            1 | student_email | A         |           3 |     NULL |   NULL |      | BTREE      |         |               | YES     | NULL       |
+----------+------------+-------------------+--------------+---------------+-----------+-------------+----------+--------+------+------------+---------+---------------+---------+------------+
2 rows in set
*/

-- ============================================================================
-- 10. TEST QUERY USING THE INDEXED COLUMN
-- ============================================================================

SELECT
    student_id,
    student_name,
    student_email
FROM students
WHERE student_email = 'alice@example.com';

/* OUTPUT:
+------------+---------------+-------------------+
| student_id | student_name  | student_email     |
+------------+---------------+-------------------+
|          1 | Alice Johnson | alice@example.com |
+------------+---------------+-------------------+
1 row in set
*/

-- ============================================================================
-- RESULT:
-- The student VIEW was successfully created, queried, and proved updatable
-- across INSERT, UPDATE, and DELETE operations. A B-Tree INDEX on student_email
-- was successfully created and verified.
-- ============================================================================
