/* ============================================================================
   EX NO: 5
   TITLE : IMPLEMENT PL/SQL PROGRAM FOR PROCEDURES AND FUNCTIONS
   AIM   : To implement and execute stored procedures and user-defined functions
           in PL/SQL with IN, OUT, and RETURN value mechanisms.
   DBMS  : Oracle 19c+ / PL/SQL
   ============================================================================
   ALGORITHM:
   ---------
   STEP 1: Start and enable server output (`SET SERVEROUTPUT ON`).
   STEP 2: Define and compile stored procedure `Sum_Numbers` accepting IN parameters.
   STEP 3: Execute anonymous PL/SQL block invoking `Sum_Numbers` with test arguments.
   STEP 4: Define and compile stored procedure `Square_Number` demonstrating OUT parameter mode.
   STEP 5: Execute anonymous block capturing and printing the OUT parameter value.
   STEP 6: Define and compile stored function `Sum_Function` returning computed scalar result.
   STEP 7: Execute anonymous block or SQL query invoking `Sum_Function`.
   STEP 8: Verify all console outputs and conclude the experiment.
   ============================================================================ */

SET SERVEROUTPUT ON;

-- ============================================================================
-- 1. STORED PROCEDURE WITH IN PARAMETERS
-- Takes two numbers as IN arguments and displays their sum.
-- ============================================================================

CREATE OR REPLACE PROCEDURE Sum_Numbers (
    a IN NUMBER,
    b IN NUMBER
) IS
    c NUMBER;
BEGIN
    c := a + b;
    DBMS_OUTPUT.PUT_LINE('Sum of two nos = ' || c);
END Sum_Numbers;
/

/* OUTPUT:
Procedure SUM_NUMBERS compiled
*/

-- Executing the procedure
BEGIN
    Sum_Numbers(10, 20);
END;
/

/* OUTPUT:
Sum of two nos = 30

PL/SQL procedure successfully completed.
*/

-- ============================================================================
-- 2. STORED PROCEDURE WITH OUT PARAMETER
-- Takes an input value, calculates square, and returns via OUT parameter.
-- ============================================================================

CREATE OR REPLACE PROCEDURE Calculate_Square (
    val_in  IN  NUMBER,
    val_out OUT NUMBER
) IS
BEGIN
    val_out := val_in * val_in;
END Calculate_Square;
/

/* OUTPUT:
Procedure CALCULATE_SQUARE compiled
*/

-- Executing the procedure with OUT parameter binding
DECLARE
    sqr_result NUMBER;
BEGIN
    Calculate_Square(7, sqr_result);
    DBMS_OUTPUT.PUT_LINE('Square of 7 = ' || sqr_result);
END;
/

/* OUTPUT:
Square of 7 = 49

PL/SQL procedure successfully completed.
*/

-- ============================================================================
-- 3. STORED FUNCTION WITH RETURN VALUE
-- Computes and returns the sum as a scalar NUMBER datatype.
-- ============================================================================

CREATE OR REPLACE FUNCTION Sum_Function (
    a IN NUMBER,
    b IN NUMBER
) RETURN NUMBER
IS
    c NUMBER;
BEGIN
    c := a + b;
    RETURN c;
END Sum_Function;
/

/* OUTPUT:
Function SUM_FUNCTION compiled
*/

-- Executing the function inside PL/SQL block
DECLARE
    result NUMBER;
BEGIN
    result := Sum_Function(5, 5);
    DBMS_OUTPUT.PUT_LINE('Sum of two nos (Function) = ' || result);
END;
/

/* OUTPUT:
Sum of two nos (Function) = 10

PL/SQL procedure successfully completed.
*/

-- Invoking the function directly within a relational SQL query
SELECT Sum_Function(40, 60) AS Computed_Sum FROM DUAL;

/* OUTPUT:
COMPUTED_SUM
------------
         100
1 row selected.
*/

-- ============================================================================
-- RESULT:
-- Thus the PL/SQL stored procedures and functions with IN, OUT, and RETURN
-- mechanisms were created, executed, and verified with expected outputs.
-- ============================================================================
