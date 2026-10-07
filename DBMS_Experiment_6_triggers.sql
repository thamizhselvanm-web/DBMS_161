/* ============================================================================
   EX NO: 6
   TITLE : WRITE SQL TRIGGERS FOR INSERT, DELETE, AND UPDATE OPERATIONS
   AIM   : To write and verify row-level database triggers for INSERT, UPDATE,
           and DELETE operations with business rule validations in PL/SQL.
   DBMS  : Oracle 19c+ / PL/SQL
   ============================================================================
   ALGORITHM:
   ---------
   STEP 1: Start and enable server output (`SET SERVEROUTPUT ON`).
   STEP 2: Reset schema objects idempotently.
   STEP 3: Create base tables `customer` and `classb`, and insert initial test records.
   STEP 4: Create BEFORE UPDATE trigger `up_classd` on `customer` to monitor
           attribute transformations using :OLD and :NEW bind variables.
   STEP 5: Test UPDATE trigger and verify logged values.
   STEP 6: Create BEFORE DELETE trigger `del_classb` on `customer` to capture row deletions.
   STEP 7: Test DELETE trigger and verify deletion message.
   STEP 8: Create BEFORE INSERT trigger `ins_classb` on `classb` to enforce the
           constraint that `stotal <= 1000`, raising custom application error when violated.
   STEP 9: Test INSERT trigger with both valid and invalid data, handling error gracefully.
   STEP 10: Verify table states and conclude the experiment.
   ============================================================================ */

SET SERVEROUTPUT ON;

-- ============================================================================
-- 1. RESET OBJECTS (Idempotent script execution)
-- ============================================================================

BEGIN
    EXECUTE IMMEDIATE 'DROP TRIGGER ins_classb';
EXCEPTION
    WHEN OTHERS THEN
        IF SQLCODE != -4080 THEN RAISE; END IF;
END;
/

BEGIN
    EXECUTE IMMEDIATE 'DROP TRIGGER del_classb';
EXCEPTION
    WHEN OTHERS THEN
        IF SQLCODE != -4080 THEN RAISE; END IF;
END;
/

BEGIN
    EXECUTE IMMEDIATE 'DROP TRIGGER up_classd';
EXCEPTION
    WHEN OTHERS THEN
        IF SQLCODE != -4080 THEN RAISE; END IF;
END;
/

BEGIN
    EXECUTE IMMEDIATE 'DROP TABLE classb CASCADE CONSTRAINTS';
EXCEPTION
    WHEN OTHERS THEN
        IF SQLCODE != -942 THEN RAISE; END IF;
END;
/

BEGIN
    EXECUTE IMMEDIATE 'DROP TABLE customer CASCADE CONSTRAINTS';
EXCEPTION
    WHEN OTHERS THEN
        IF SQLCODE != -942 THEN RAISE; END IF;
END;
/

-- ============================================================================
-- 2. CREATE SUPPORTING TABLES AND SEED DATA
-- ============================================================================

CREATE TABLE customer (
    sid    NUMBER PRIMARY KEY,
    sname  VARCHAR2(50),
    stotal NUMBER
);

CREATE TABLE classb (
    sid    NUMBER PRIMARY KEY,
    sname  VARCHAR2(50),
    sdept  VARCHAR2(50),
    stotal NUMBER,
    grade  VARCHAR2(5)
);

INSERT INTO customer VALUES (1, 'Ravi', 900);
INSERT INTO customer VALUES (3, 'Kumar', 900);
COMMIT;

-- Verify initial customer table
SELECT * FROM customer ORDER BY sid;

/* OUTPUT:
SID | SNAME | STOTAL
----+-------+-------
1   | Ravi  | 900
3   | Kumar | 900
2 rows selected.
*/

-- ============================================================================
-- 3. TRIGGER ON UPDATE (BEFORE ROW-LEVEL TRIGGER)
-- Fires before updating customer, logging old and new stotal values.
-- ============================================================================

CREATE OR REPLACE TRIGGER up_classd
BEFORE UPDATE ON customer
FOR EACH ROW
BEGIN
    IF UPDATING THEN
        DBMS_OUTPUT.PUT_LINE('new value is ' || :NEW.stotal);
        DBMS_OUTPUT.PUT_LINE('old value is ' || :OLD.stotal);
    END IF;
END;
/

/* OUTPUT:
Trigger UP_CLASSD compiled
*/

-- Test the UPDATE trigger
UPDATE customer
SET stotal = 500
WHERE sid = 3;

/* OUTPUT:
new value is 500
old value is 900
1 row updated.
*/

-- Verify customer table after update
SELECT * FROM customer WHERE sid = 3;

/* OUTPUT:
SID | SNAME | STOTAL
----+-------+-------
3   | Kumar | 500
1 row selected.
*/

-- ============================================================================
-- 4. TRIGGER ON DELETE (BEFORE ROW-LEVEL TRIGGER)
-- Fires before deleting a customer record, notifying user.
-- ============================================================================

CREATE OR REPLACE TRIGGER del_classb
BEFORE DELETE ON customer
FOR EACH ROW
BEGIN
    IF DELETING THEN
        DBMS_OUTPUT.PUT_LINE('row deleted');
    END IF;
END;
/

/* OUTPUT:
Trigger DEL_CLASSB compiled
*/

-- Test the DELETE trigger
DELETE FROM customer
WHERE sid = 1;

/* OUTPUT:
row deleted
1 row deleted.
*/

-- Verify customer table after deletion
SELECT * FROM customer ORDER BY sid;

/* OUTPUT:
SID | SNAME | STOTAL
----+-------+-------
3   | Kumar | 500
1 row selected.
*/

-- ============================================================================
-- 5. TRIGGER ON INSERT WITH CONSTRAINT VALIDATION
-- Blocks insertions into classb if stotal > 1000 using RAISE_APPLICATION_ERROR.
-- ============================================================================

CREATE OR REPLACE TRIGGER ins_classb
BEFORE INSERT ON classb
FOR EACH ROW
DECLARE
    InvTot EXCEPTION;
BEGIN
    IF INSERTING THEN
        IF :NEW.stotal > 1000 THEN
            RAISE InvTot;
        END IF;
    END IF;
EXCEPTION
    WHEN InvTot THEN
        RAISE_APPLICATION_ERROR(-20000, 'Total not valid');
END;
/

/* OUTPUT:
Trigger INS_CLASSB compiled
*/

-- Test Case A: Valid insert (stotal <= 1000) -> Allowed
INSERT INTO classb VALUES (1, 'John', 'IT', 900, 'A');

/* OUTPUT:
1 row inserted.
*/

SELECT * FROM classb;

/* OUTPUT:
SID | SNAME | SDEPT | STOTAL | GRADE
----+-------+-------+--------+------
1   | John  | IT    | 900    | A
1 row selected.
*/

-- Test Case B: Invalid insert (stotal > 1000) -> Blocked by trigger
BEGIN
    INSERT INTO classb VALUES (6, 'jana', 'it', 20000, 'a');
EXCEPTION
    WHEN OTHERS THEN
        IF SQLCODE = -20000 THEN
            DBMS_OUTPUT.PUT_LINE('Invalid insert rejected: ' || SQLERRM);
        ELSE
            RAISE;
        END IF;
END;
/

/* OUTPUT:
Invalid insert rejected: ORA-20000: Total not valid

PL/SQL procedure successfully completed.
*/

-- ============================================================================
-- RESULT:
-- Thus the PL/SQL triggers for INSERT, UPDATE, and DELETE operations with
-- constraint validation and bind variable tracking were executed successfully.
-- ============================================================================
