/* ============================================================================
   EX NO: 8
   TITLE : PL/SQL PROGRAM FOR EXCEPTION HANDLING
   AIM   : To write and execute PL/SQL programs demonstrating predefined exceptions,
           user-defined exceptions, exception propagation across nested blocks,
           and SQLCODE/SQLERRM error functions.
   DBMS  : Oracle 19c+ / PL/SQL
   ============================================================================
   ALGORITHM:
   ---------
   STEP 1: Start and enable server output buffer (`SET SERVEROUTPUT ON`).
   STEP 2: Reset schema objects and create supporting table `customers`.
   STEP 3: Demonstrate Pre-defined System Exceptions:
           - Handle `NO_DATA_FOUND` when querying non-existent row.
           - Handle `ZERO_DIVIDE` during illegal mathematical operations.
   STEP 4: Demonstrate User-Defined Exceptions:
           - Declare custom exception `ex_invalid_id`.
           - Conditionally raise it when business rule (id <= 0) is violated.
   STEP 5: Demonstrate Exception Propagation:
           - Raise exception inside an inner child block and handle it in the parent block.
   STEP 6: Capture runtime error diagnostic codes using `SQLCODE` and `SQLERRM`.
   STEP 7: Verify outputs and stop.
   ============================================================================ */

SET SERVEROUTPUT ON;

-- ============================================================================
-- 1. RESET OBJECTS (Idempotent script execution)
-- ============================================================================

BEGIN
    EXECUTE IMMEDIATE 'DROP TABLE customers CASCADE CONSTRAINTS';
EXCEPTION
    WHEN OTHERS THEN
        IF SQLCODE != -942 THEN RAISE; END IF;
END;
/

-- ============================================================================
-- 2. CREATE SUPPORTING TABLE AND SAMPLE DATA
-- ============================================================================

CREATE TABLE customers (
    id      NUMBER PRIMARY KEY,
    name    VARCHAR2(50),
    address VARCHAR2(100),
    salary  NUMBER(10,2)
);

INSERT INTO customers (id, name, address, salary) VALUES (1, 'John',  'New York',    5500.00);
INSERT INTO customers (id, name, address, salary) VALUES (2, 'Alice', 'Los Angeles', 6500.00);
INSERT INTO customers (id, name, address, salary) VALUES (3, 'Bob',   'Chicago',     5000.00);
INSERT INTO customers (id, name, address, salary) VALUES (4, 'David', 'Houston',     7500.00);
INSERT INTO customers (id, name, address, salary) VALUES (5, 'Emma',  'Boston',      6000.00);
COMMIT;

SELECT * FROM customers ORDER BY id;

/* OUTPUT:
ID | NAME  | ADDRESS     | SALARY
---+-------+-------------+--------
1  | John  | New York    | 5500.00
2  | Alice | Los Angeles | 6500.00
3  | Bob   | Chicago     | 5000.00
4  | David | Houston     | 7500.00
5  | Emma  | Boston      | 6000.00
5 rows selected.
*/

-- ============================================================================
-- 3. PRE-DEFINED EXCEPTION HANDLING (Case A: Found vs Not Found)
-- Intercepts Oracle built-in NO_DATA_FOUND exception.
-- ============================================================================

-- Test 3.1: Valid ID query (Record exists)
DECLARE
    c_id   customers.id%TYPE := 5;
    c_name customers.name%TYPE;
    c_addr customers.address%TYPE;
BEGIN
    SELECT name, address
    INTO   c_name, c_addr
    FROM   customers
    WHERE  id = c_id;

    DBMS_OUTPUT.PUT_LINE('Customer Found: ' || c_name || ' from ' || c_addr);
EXCEPTION
    WHEN NO_DATA_FOUND THEN
        DBMS_OUTPUT.PUT_LINE('No such customer!');
    WHEN OTHERS THEN
        DBMS_OUTPUT.PUT_LINE('Error: ' || SQLERRM);
END;
/

/* OUTPUT:
Customer Found: Emma from Boston

PL/SQL procedure successfully completed.
*/

-- Test 3.2: Non-existent ID query (Triggers NO_DATA_FOUND)
DECLARE
    c_id   customers.id%TYPE := 99;
    c_name customers.name%TYPE;
    c_addr customers.address%TYPE;
BEGIN
    SELECT name, address
    INTO   c_name, c_addr
    FROM   customers
    WHERE  id = c_id;

    DBMS_OUTPUT.PUT_LINE('Customer Found: ' || c_name || ' from ' || c_addr);
EXCEPTION
    WHEN NO_DATA_FOUND THEN
        DBMS_OUTPUT.PUT_LINE('Exception Caught: No such customer with ID ' || c_id || '!');
    WHEN OTHERS THEN
        DBMS_OUTPUT.PUT_LINE('Error: ' || SQLERRM);
END;
/

/* OUTPUT:
Exception Caught: No such customer with ID 99!

PL/SQL procedure successfully completed.
*/

-- ============================================================================
-- 4. USER-DEFINED EXCEPTION HANDLING
-- Custom business rule validation: customer ID must be > 0.
-- ============================================================================

-- Test 4.1: Valid ID (Passes check)
DECLARE
    c_id          customers.id%TYPE := 3;
    c_name        customers.name%TYPE;
    c_addr        customers.address%TYPE;
    ex_invalid_id EXCEPTION;
BEGIN
    IF c_id <= 0 THEN
        RAISE ex_invalid_id;
    ELSE
        SELECT name, address
        INTO   c_name, c_addr
        FROM   customers
        WHERE  id = c_id;

        DBMS_OUTPUT.PUT_LINE('Valid Query - Name: ' || c_name || ', Address: ' || c_addr);
    END IF;
EXCEPTION
    WHEN ex_invalid_id THEN
        DBMS_OUTPUT.PUT_LINE('Business Exception: ID must be greater than zero!');
    WHEN NO_DATA_FOUND THEN
        DBMS_OUTPUT.PUT_LINE('No such customer!');
    WHEN OTHERS THEN
        DBMS_OUTPUT.PUT_LINE('Error: ' || SQLERRM);
END;
/

/* OUTPUT:
Valid Query - Name: Bob, Address: Chicago

PL/SQL procedure successfully completed.
*/

-- Test 4.2: Invalid ID (Raises custom exception ex_invalid_id)
DECLARE
    c_id          customers.id%TYPE := 0;
    c_name        customers.name%TYPE;
    c_addr        customers.address%TYPE;
    ex_invalid_id EXCEPTION;
BEGIN
    IF c_id <= 0 THEN
        RAISE ex_invalid_id;
    ELSE
        SELECT name, address
        INTO   c_name, c_addr
        FROM   customers
        WHERE  id = c_id;

        DBMS_OUTPUT.PUT_LINE('Name: ' || c_name || ', Address: ' || c_addr);
    END IF;
EXCEPTION
    WHEN ex_invalid_id THEN
        DBMS_OUTPUT.PUT_LINE('Business Exception Caught: ID must be greater than zero! (Provided: ' || c_id || ')');
    WHEN NO_DATA_FOUND THEN
        DBMS_OUTPUT.PUT_LINE('No such customer!');
    WHEN OTHERS THEN
        DBMS_OUTPUT.PUT_LINE('Error: ' || SQLERRM);
END;
/

/* OUTPUT:
Business Exception Caught: ID must be greater than zero! (Provided: 0)

PL/SQL procedure successfully completed.
*/

-- ============================================================================
-- 5. EXCEPTION PROPAGATION (Nested Blocks)
-- An unhandled exception in child block propagates to parent block.
-- ============================================================================

DECLARE
    v_dividend NUMBER := 100;
    v_divisor  NUMBER := 0;
    v_result   NUMBER;
BEGIN
    DBMS_OUTPUT.PUT_LINE('Starting Parent Block');
    -- Inner Child Block
    BEGIN
        DBMS_OUTPUT.PUT_LINE('Inside Child Block - attempting division');
        v_result := v_dividend / v_divisor; -- Causes ZERO_DIVIDE
    END; -- Child block has no handler, propagates upward
    
    DBMS_OUTPUT.PUT_LINE('This line will not execute');
EXCEPTION
    WHEN ZERO_DIVIDE THEN
        DBMS_OUTPUT.PUT_LINE('Parent Caught Exception: ZERO_DIVIDE (Code: ' || SQLCODE || ', Msg: ' || SQLERRM || ')');
    WHEN OTHERS THEN
        DBMS_OUTPUT.PUT_LINE('Parent Caught Other Error: ' || SQLERRM);
END;
/

/* OUTPUT:
Starting Parent Block
Inside Child Block - attempting division
Parent Caught Exception: ZERO_DIVIDE (Code: -1476, Msg: ORA-01476: divisor is equal to zero)

PL/SQL procedure successfully completed.
*/

-- ============================================================================
-- RESULT:
-- Thus the PL/SQL programs demonstrating predefined exceptions, user-defined
-- exceptions, and hierarchical exception propagation were executed successfully.
-- ============================================================================
