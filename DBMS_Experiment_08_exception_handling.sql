/* ============================================================================
   EX NO: 8
   TITLE : WRITE THE PL/SQL PROGRAM FOR EXCEPTION HANDLING
   AIM   : To write PL/SQL programs that handle all types of exceptions.
   ============================================================================
   ALGORITHM
   ---------
   STEP 1 : Start
   STEP 2 : Declare the exception
   STEP 3 : Raise the exception
   STEP 4 : Propagate the exception from the child to the parent block
   STEP 5 : Display the result
   STEP 6 : Stop
   ============================================================================ */


/* ----------------------------------------------------------------------------
   SUPPORTING TABLE AND DATA
   ---------------------------------------------------------------------------- */

CREATE TABLE customers (
    id      INT PRIMARY KEY,
    name    VARCHAR(50),
    address VARCHAR(100),
    salary  DECIMAL(10,2)
);

INSERT INTO customers (id, name, address, salary) VALUES
(1, 'John',  'New York',    5500.00),
(2, 'Alice', 'Los Angeles', 6500.00),
(3, 'Bob',   'Chicago',     5000.00),
(4, 'David', 'Houston',     7500.00),
(5, 'Emma',  'Boston',      6000.00);

SELECT * FROM customers;
/* OUTPUT:
ID | Name  | Address     | Salary
---+-------+-------------+--------
1  | John  | New York    | 5500.00
2  | Alice | Los Angeles | 6500.00
3  | Bob   | Chicago     | 5000.00
4  | David | Houston     | 7500.00
5  | Emma  | Boston      | 6000.00
*/


/* ----------------------------------------------------------------------------
   PRE-DEFINED EXCEPTION HANDLING
   Demonstrates the built-in NO_DATA_FOUND exception (raised by SELECT
   INTO when no row matches) and a catch-all OTHERS handler.
   ---------------------------------------------------------------------------- */

SET SERVEROUTPUT ON;

DECLARE
    c_id   customers.id%TYPE := 5;
    c_name customers.name%TYPE;
    c_addr customers.address%TYPE;
BEGIN
    SELECT name, address
    INTO   c_name, c_addr
    FROM   customers
    WHERE  id = c_id;

    DBMS_OUTPUT.PUT_LINE('Name: ' || c_name);
    DBMS_OUTPUT.PUT_LINE('Address: ' || c_addr);
EXCEPTION
    WHEN NO_DATA_FOUND THEN
        DBMS_OUTPUT.PUT_LINE('No such customer!');
    WHEN OTHERS THEN
        DBMS_OUTPUT.PUT_LINE('Error!');
END;
/
/* OUTPUT (c_id = 5, exists):
Name: Emma
Address: Boston
*/


/* ----------------------------------------------------------------------------
   USER-DEFINED EXCEPTION HANDLING
   Declares a custom exception (ex_invalid_id) that is explicitly RAISEd
   when a business rule is violated (id <= 0), in addition to handling
   the pre-defined NO_DATA_FOUND and a catch-all OTHERS.
   ---------------------------------------------------------------------------- */

SET SERVEROUTPUT ON;

DECLARE
    c_id          customers.id%TYPE := &cc_id;   -- substitution variable (SQL*Plus)
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

        DBMS_OUTPUT.PUT_LINE('Name: ' || c_name);
        DBMS_OUTPUT.PUT_LINE('Address: ' || c_addr);
    END IF;
EXCEPTION
    WHEN ex_invalid_id THEN
        DBMS_OUTPUT.PUT_LINE('ID must be greater than zero!');
    WHEN NO_DATA_FOUND THEN
        DBMS_OUTPUT.PUT_LINE('No such customer!');
    WHEN OTHERS THEN
        DBMS_OUTPUT.PUT_LINE('Error!');
END;
/
/* OUTPUT (Run 1, cc_id = 3):
Name: Bob
Address: Chicago

OUTPUT (Run 2, cc_id = 0):
ID must be greater than zero!
*/


/* ============================================================================
   RESULT: Thus, the PL/SQL programs that handle pre-defined and
   user-defined exceptions were executed successfully and the output
   was verified.
   ============================================================================ */
