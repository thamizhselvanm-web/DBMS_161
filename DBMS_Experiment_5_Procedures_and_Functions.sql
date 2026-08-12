-- =====================================================================
-- DBMS LAB - EXPERIMENT 5
-- =====================================================================
-- TITLE : IMPLEMENTATION OF PROCEDURES AND FUNCTIONS
-- DBMS  : MySQL 8.0+
-- FILE  : DBMS_Experiment_5_Procedures_and_Functions.sql
-- =====================================================================

DROP DATABASE IF EXISTS dbms_experiment_5;
CREATE DATABASE dbms_experiment_5;
USE dbms_experiment_5;

-- =====================================================================
-- 1. CREATE EMPLOYEE TABLE
-- =====================================================================

CREATE TABLE employee (
    id INT PRIMARY KEY,
    name VARCHAR(50) NOT NULL,
    salary DECIMAL(10,2)
);

-- =====================================================================
-- 2. INSERT SAMPLE DATA
-- =====================================================================

INSERT INTO employee (id, name, salary) VALUES
(1, 'John', 5000.00),
(2, 'Alice', 6000.00),
(3, 'Bob', 4500.00);

-- =====================================================================
-- 3. DISPLAY EMPLOYEE RECORDS
-- =====================================================================

SELECT * FROM employee;

-- Expected Output:
-- +----+-------+---------+
-- | id | name  | salary  |
-- +----+-------+---------+
-- | 1  | John  | 5000.00 |
-- | 2  | Alice | 6000.00 |
-- | 3  | Bob   | 4500.00 |
-- +----+-------+---------+

-- =====================================================================
-- 4. CREATE PROCEDURE
-- =====================================================================
-- Procedure: SumProcedure
-- Purpose  : Calculate and display the sum of two integers.

DELIMITER //

CREATE PROCEDURE SumProcedure(IN a INT, IN b INT)
BEGIN
    DECLARE c INT;

    SET c = a + b;

    SELECT CONCAT('Sum of two numbers = ', c) AS Result;
END //

DELIMITER ;

-- =====================================================================
-- 5. CALL THE PROCEDURE
-- =====================================================================

CALL SumProcedure(10, 20);

-- Expected Output:
-- +--------------------------+
-- | Result                   |
-- +--------------------------+
-- | Sum of two numbers = 30  |
-- +--------------------------+

-- =====================================================================
-- 6. CREATE FUNCTION
-- =====================================================================
-- Function: SumFunction
-- Purpose : Return the sum of two integers.

DELIMITER //

CREATE FUNCTION SumFunction(a INT, b INT)
RETURNS INT
DETERMINISTIC
BEGIN
    DECLARE c INT;

    SET c = a + b;

    RETURN c;
END //

DELIMITER ;

-- =====================================================================
-- 7. CALL THE FUNCTION
-- =====================================================================

SELECT SumFunction(5, 5) AS Result;

-- Expected Output:
-- +--------+
-- | Result |
-- +--------+
-- |   10   |
-- +--------+

-- =====================================================================
-- 8. CLEANUP
-- =====================================================================
-- Uncomment the following commands if the procedure/function needs
-- to be removed.
-- DROP PROCEDURE IF EXISTS SumProcedure;
-- DROP FUNCTION IF EXISTS SumFunction;

-- =====================================================================
-- RESULT
-- =====================================================================
-- The stored procedure was successfully created and executed to
-- calculate the sum of two numbers. The stored function was also
-- successfully created and executed to return the sum of two numbers.

-- =====================================================================
-- END OF EXPERIMENT 5
-- =====================================================================
