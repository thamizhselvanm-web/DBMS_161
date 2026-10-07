/* ============================================================================
   EX NO: 4
   TITLE : DATABASE PROGRAMMING - IMPLICIT AND EXPLICIT CURSORS
   AIM   : To implement and execute PL/SQL programs demonstrating implicit
           and explicit cursor lifecycle attributes (%FOUND, %NOTFOUND,
           %ROWCOUNT, and %ISOPEN).
   DBMS  : Oracle 19c+ / PL/SQL
   ============================================================================
   ALGORITHM:
   ---------
   STEP 1: Start and enable server output buffer (`SET SERVEROUTPUT ON`).
   STEP 2: Create supporting `customers` table with sample records.
   STEP 3: Demonstrate Implicit Cursor:
           - Execute a DML UPDATE statement on all records.
           - Check implicit cursor attributes `SQL%FOUND` and `SQL%ROWCOUNT`.
           - Print the number of rows affected using `DBMS_OUTPUT.PUT_LINE`.
   STEP 4: Demonstrate Explicit Cursor:
           - Declare an explicit cursor `c_customers` for querying multiple customer rows.
           - Open the cursor (`OPEN c_customers`).
           - Fetch records sequentially in a `LOOP` until `c_customers%NOTFOUND`.
           - Output fetched attributes.
           - Close the cursor (`CLOSE c_customers`).
   STEP 5: Verify results and stop.
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
-- 2. TABLE CREATION AND SAMPLE DATA
-- ============================================================================

CREATE TABLE customers (
    id      NUMBER PRIMARY KEY,
    name    VARCHAR2(50),
    address VARCHAR2(100),
    salary  NUMBER(10,2)
);

INSERT INTO customers (id, name, address, salary) VALUES (1, 'John',  'New York',    5000.00);
INSERT INTO customers (id, name, address, salary) VALUES (2, 'Alice', 'Los Angeles', 6000.00);
INSERT INTO customers (id, name, address, salary) VALUES (3, 'Bob',   'Chicago',     4500.00);
INSERT INTO customers (id, name, address, salary) VALUES (4, 'David', 'Houston',     7000.00);
INSERT INTO customers (id, name, address, salary) VALUES (5, 'Emma',  'Boston',      5500.00);
COMMIT;

-- Verify initial table contents
SELECT * FROM customers ORDER BY id;

/* OUTPUT:
ID | NAME  | ADDRESS     | SALARY
---+-------+-------------+--------
1  | John  | New York    | 5000.00
2  | Alice | Los Angeles | 6000.00
3  | Bob   | Chicago     | 4500.00
4  | David | Houston     | 7000.00
5  | Emma  | Boston      | 5500.00
5 rows selected.
*/

-- ============================================================================
-- 3. IMPLICIT CURSOR IMPLEMENTATION
-- Automatically managed by Oracle for DML statements.
-- Evaluates SQL%FOUND and SQL%ROWCOUNT after salary increment.
-- ============================================================================

DECLARE
    total_rows NUMBER(2);
BEGIN
    UPDATE customers
    SET salary = salary + 500;

    IF SQL%NOTFOUND THEN
        DBMS_OUTPUT.PUT_LINE('no customers selected');
    ELSIF SQL%FOUND THEN
        total_rows := SQL%ROWCOUNT;
        DBMS_OUTPUT.PUT_LINE(total_rows || ' customers selected');
    END IF;
END;
/

/* OUTPUT:
5 customers selected

PL/SQL procedure successfully completed.
*/

-- Verify table data after implicit cursor bulk UPDATE
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
-- 4. EXPLICIT CURSOR IMPLEMENTATION
-- Programmer-defined cursor: DECLARE -> OPEN -> FETCH -> CLOSE.
-- ============================================================================

DECLARE
    c_id      customers.id%TYPE;
    c_name    customers.name%TYPE;
    c_addr    customers.address%TYPE;
    c_sal     customers.salary%TYPE;

    -- Step 1: Declare explicit cursor
    CURSOR c_customers IS
        SELECT id, name, address, salary FROM customers ORDER BY id;
BEGIN
    -- Step 2: Open explicit cursor
    OPEN c_customers;
    
    DBMS_OUTPUT.PUT_LINE('ID | NAME  | ADDRESS     | SALARY');
    DBMS_OUTPUT.PUT_LINE('---+-------+-------------+--------');

    -- Step 3: Fetch active set rows in a loop
    LOOP
        FETCH c_customers INTO c_id, c_name, c_addr, c_sal;
        EXIT WHEN c_customers%NOTFOUND;
        DBMS_OUTPUT.PUT_LINE(c_id || '  | ' || RPAD(c_name, 5) || ' | ' || RPAD(c_addr, 11) || ' | ' || c_sal);
    END LOOP;

    -- Step 4: Close explicit cursor
    CLOSE c_customers;
END;
/

/* OUTPUT:
ID | NAME  | ADDRESS     | SALARY
---+-------+-------------+--------
1  | John  | New York    | 5500
2  | Alice | Los Angeles | 6500
3  | Bob   | Chicago     | 5000
4  | David | Houston     | 7500
5  | Emma  | Boston      | 6000

PL/SQL procedure successfully completed.
*/

-- ============================================================================
-- RESULT:
-- Thus the PL/SQL programs for implicit and explicit cursors were executed
-- successfully and cursor attributes were verified with expected outputs.
-- ============================================================================
