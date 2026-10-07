/* ============================================================================
   DBMS MINI PROJECT (EX NO: 12)
   TITLE : ENTERPRISE BANKING MANAGEMENT SYSTEM
   AIM   : To design, model, implement, and verify an end-to-end relational
           database management system for a commercial banking enterprise
           using Oracle SQL & PL/SQL.
   DBMS  : Oracle 19c+ / SQL & PL/SQL
   ============================================================================
   ALGORITHM:
   ---------
   STEP 1: Teardown existing schema tables in reverse foreign-key dependency order.
   STEP 2: Define and construct relational tables with primary keys, unique constraints,
           and foreign key referential integrity:
           - Customer (Master profile records)
           - Branch (Geographic banking locations and unique IFSC routing)
           - Account (Savings and Current deposit accounts)
           - Bank_Transaction (Deposit and withdrawal audit ledger)
           - Loan (Credit financing facility)
           - Loan_Payment (Installment repayment accounting)
   STEP 3: Populate all entities with consistent master seed data.
   STEP 4: Execute multi-table relational join queries for operational reporting.
   STEP 5: Compute financial metrics and aggregate liquidity balances.
   STEP 6: Track loan portfolios, debt exposure, and repayment logs.
   STEP 7: Perform atomic balance modifications, customer profile maintenance,
           and enforce ACID transactional commitments.
   STEP 8: Execute post-mutation audit verification and conclude project.
   ============================================================================ */


/* ============================================================
   1. REMOVE OLD TABLES (Reverse Dependency Order)
   ============================================================ */

BEGIN
    EXECUTE IMMEDIATE 'DROP TABLE Loan_Payment CASCADE CONSTRAINTS';
EXCEPTION
    WHEN OTHERS THEN NULL;
END;
/

BEGIN
    EXECUTE IMMEDIATE 'DROP TABLE Bank_Transaction CASCADE CONSTRAINTS';
EXCEPTION
    WHEN OTHERS THEN NULL;
END;
/

BEGIN
    EXECUTE IMMEDIATE 'DROP TABLE Loan CASCADE CONSTRAINTS';
EXCEPTION
    WHEN OTHERS THEN NULL;
END;
/

BEGIN
    EXECUTE IMMEDIATE 'DROP TABLE Account CASCADE CONSTRAINTS';
EXCEPTION
    WHEN OTHERS THEN NULL;
END;
/

BEGIN
    EXECUTE IMMEDIATE 'DROP TABLE Branch CASCADE CONSTRAINTS';
EXCEPTION
    WHEN OTHERS THEN NULL;
END;
/

BEGIN
    EXECUTE IMMEDIATE 'DROP TABLE Customer CASCADE CONSTRAINTS';
EXCEPTION
    WHEN OTHERS THEN NULL;
END;
/

/* OUTPUT:
PL/SQL procedure successfully completed.
*/


/* ============================================================
   2. CREATE CUSTOMER TABLE
   ============================================================ */

CREATE TABLE Customer (
    Customer_ID NUMBER PRIMARY KEY,
    Customer_Name VARCHAR2(100) NOT NULL,
    Date_Of_Birth DATE,
    Gender VARCHAR2(10),
    Phone VARCHAR2(15),
    Email VARCHAR2(100),
    Address VARCHAR2(200)
);

/* OUTPUT:
Table CUSTOMER created.
*/


/* ============================================================
   3. CREATE BRANCH TABLE
   ============================================================ */

CREATE TABLE Branch (
    Branch_ID NUMBER PRIMARY KEY,
    Branch_Name VARCHAR2(100) NOT NULL,
    City VARCHAR2(50),
    IFSC_Code VARCHAR2(20) UNIQUE
);

/* OUTPUT:
Table BRANCH created.
*/


/* ============================================================
   4. CREATE ACCOUNT TABLE
   ============================================================ */

CREATE TABLE Account (
    Account_No NUMBER PRIMARY KEY,
    Customer_ID NUMBER,
    Branch_ID NUMBER,
    Account_Type VARCHAR2(30),
    Opening_Date DATE,
    Balance NUMBER(12,2),
    Account_Status VARCHAR2(20),

    CONSTRAINT fk_account_customer
        FOREIGN KEY (Customer_ID)
        REFERENCES Customer(Customer_ID),

    CONSTRAINT fk_account_branch
        FOREIGN KEY (Branch_ID)
        REFERENCES Branch(Branch_ID)
);

/* OUTPUT:
Table ACCOUNT created.
*/


/* ============================================================
   5. CREATE BANK TRANSACTION TABLE
   ============================================================ */

CREATE TABLE Bank_Transaction (
    Transaction_ID NUMBER PRIMARY KEY,
    Account_No NUMBER,
    Transaction_Date DATE,
    Transaction_Type VARCHAR2(20),
    Amount NUMBER(12,2),
    Description VARCHAR2(200),

    CONSTRAINT fk_transaction_account
        FOREIGN KEY (Account_No)
        REFERENCES Account(Account_No)
);

/* OUTPUT:
Table BANK_TRANSACTION created.
*/


/* ============================================================
   6. CREATE LOAN TABLE
   ============================================================ */

CREATE TABLE Loan (
    Loan_ID NUMBER PRIMARY KEY,
    Customer_ID NUMBER,
    Loan_Type VARCHAR2(50),
    Loan_Amount NUMBER(12,2),
    Interest_Rate NUMBER(5,2),
    Loan_Date DATE,
    Loan_Status VARCHAR2(20),

    CONSTRAINT fk_loan_customer
        FOREIGN KEY (Customer_ID)
        REFERENCES Customer(Customer_ID)
);

/* OUTPUT:
Table LOAN created.
*/


/* ============================================================
   7. CREATE LOAN PAYMENT TABLE
   ============================================================ */

CREATE TABLE Loan_Payment (
    Payment_ID NUMBER PRIMARY KEY,
    Loan_ID NUMBER,
    Payment_Date DATE,
    Payment_Amount NUMBER(12,2),
    Payment_Mode VARCHAR2(30),

    CONSTRAINT fk_loan_payment
        FOREIGN KEY (Loan_ID)
        REFERENCES Loan(Loan_ID)
);

/* OUTPUT:
Table LOAN_PAYMENT created.
*/


/* ============================================================
   8. INSERT BRANCH DATA
   ============================================================ */

INSERT INTO Branch VALUES
(1, 'Chennai Main Branch', 'Chennai', 'BANK000001');

INSERT INTO Branch VALUES
(2, 'Coimbatore Branch', 'Coimbatore', 'BANK000002');

INSERT INTO Branch VALUES
(3, 'Madurai Branch', 'Madurai', 'BANK000003');

INSERT INTO Branch VALUES
(4, 'Trichy Branch', 'Trichy', 'BANK000004');


/* ============================================================
   9. INSERT CUSTOMER DATA
   ============================================================ */

INSERT INTO Customer VALUES
(1, 'Deepika', DATE '2004-05-15', 'Female',
 '9876543210', 'deepika@gmail.com', 'Chennai');

INSERT INTO Customer VALUES
(2, 'Priya', DATE '2003-08-20', 'Female',
 '9876543211', 'priya@gmail.com', 'Madurai');

INSERT INTO Customer VALUES
(3, 'Arun', DATE '1998-02-10', 'Male',
 '9876543212', 'arun@gmail.com', 'Coimbatore');

INSERT INTO Customer VALUES
(4, 'Karthik', DATE '1995-11-25', 'Male',
 '9876543213', 'karthik@gmail.com', 'Trichy');

INSERT INTO Customer VALUES
(5, 'Meena', DATE '1997-07-12', 'Female',
 '9876543214', 'meena@gmail.com', 'Chennai');


/* ============================================================
   10. INSERT ACCOUNT DATA
   ============================================================ */

INSERT INTO Account VALUES
(100001, 1, 1, 'Savings', DATE '2024-01-10',
 50000.00, 'Active');

INSERT INTO Account VALUES
(100002, 2, 3, 'Savings', DATE '2023-06-15',
 75000.00, 'Active');

INSERT INTO Account VALUES
(100003, 3, 2, 'Current', DATE '2022-03-20',
 150000.00, 'Active');

INSERT INTO Account VALUES
(100004, 4, 4, 'Savings', DATE '2024-08-05',
 30000.00, 'Active');

INSERT INTO Account VALUES
(100005, 5, 1, 'Savings', DATE '2025-01-15',
 90000.00, 'Active');


/* ============================================================
   11. INSERT TRANSACTION DATA
   ============================================================ */

INSERT INTO Bank_Transaction VALUES
(5001, 100001, DATE '2026-09-01',
 'Deposit', 10000.00, 'Cash deposit');

INSERT INTO Bank_Transaction VALUES
(5002, 100001, DATE '2026-09-05',
 'Withdrawal', 5000.00, 'ATM withdrawal');

INSERT INTO Bank_Transaction VALUES
(5003, 100002, DATE '2026-09-02',
 'Deposit', 20000.00, 'Salary credit');

INSERT INTO Bank_Transaction VALUES
(5004, 100003, DATE '2026-09-03',
 'Withdrawal', 15000.00, 'Business payment');

INSERT INTO Bank_Transaction VALUES
(5005, 100004, DATE '2026-09-04',
 'Deposit', 5000.00, 'Cash deposit');

INSERT INTO Bank_Transaction VALUES
(5006, 100005, DATE '2026-09-05',
 'Deposit', 25000.00, 'Salary credit');


/* ============================================================
   12. INSERT LOAN DATA
   ============================================================ */

INSERT INTO Loan VALUES
(7001, 1, 'Education Loan', 200000.00,
 7.50, DATE '2025-06-10', 'Active');

INSERT INTO Loan VALUES
(7002, 2, 'Home Loan', 1500000.00,
 8.25, DATE '2024-04-15', 'Active');

INSERT INTO Loan VALUES
(7003, 3, 'Business Loan', 500000.00,
 9.00, DATE '2023-08-20', 'Active');

INSERT INTO Loan VALUES
(7004, 4, 'Personal Loan', 300000.00,
 10.50, DATE '2025-01-20', 'Closed');


/* ============================================================
   13. INSERT LOAN PAYMENT DATA
   ============================================================ */

INSERT INTO Loan_Payment VALUES
(8001, 7001, DATE '2026-08-10',
 10000.00, 'UPI');

INSERT INTO Loan_Payment VALUES
(8002, 7002, DATE '2026-08-15',
 25000.00, 'Bank Transfer');

INSERT INTO Loan_Payment VALUES
(8003, 7003, DATE '2026-08-20',
 20000.00, 'Cheque');

INSERT INTO Loan_Payment VALUES
(8004, 7004, DATE '2026-08-25',
 30000.00, 'UPI');


/* ============================================================
   14. DISPLAY ALL CUSTOMERS
   ============================================================ */

SELECT * FROM Customer;

/*
OUTPUT:

CUSTOMER_ID  CUSTOMER_NAME  DATE_OF_BIRTH  GENDER  PHONE
1            Deepika        15-MAY-04      Female  9876543210
2            Priya          20-AUG-03      Female  9876543211
3            Arun           10-FEB-98      Male    9876543212
4            Karthik        25-NOV-95      Male    9876543213
5            Meena          12-JUL-97      Female  9876543214

EMAIL
deepika@gmail.com
priya@gmail.com
arun@gmail.com
karthik@gmail.com
meena@gmail.com

ADDRESS
Chennai
Madurai
Coimbatore
Trichy
Chennai
*/


/* ============================================================
   15. DISPLAY ALL BRANCHES
   ============================================================ */

SELECT * FROM Branch;

/*
OUTPUT:

BRANCH_ID  BRANCH_NAME           CITY        IFSC_CODE
1          Chennai Main Branch   Chennai     BANK000001
2          Coimbatore Branch     Coimbatore  BANK000002
3          Madurai Branch        Madurai     BANK000003
4          Trichy Branch         Trichy      BANK000004
*/


/* ============================================================
   16. DISPLAY ALL ACCOUNTS
   ============================================================ */

SELECT * FROM Account;

/*
OUTPUT:

ACCOUNT_NO  CUSTOMER_ID  BRANCH_ID  ACCOUNT_TYPE  OPENING_DATE
100001      1            1          Savings       10-JAN-24
100002      2            3          Savings       15-JUN-23
100003      3            2          Current       20-MAR-22
100004      4            4          Savings       05-AUG-24
100005      5            1          Savings       15-JAN-25

BALANCE     ACCOUNT_STATUS
50000       Active
75000       Active
150000      Active
30000       Active
90000       Active
*/


/* ============================================================
   17. DISPLAY CUSTOMER ACCOUNT DETAILS
   ============================================================ */

SELECT
    c.Customer_ID,
    c.Customer_Name,
    a.Account_No,
    a.Account_Type,
    a.Balance,
    a.Account_Status
FROM Customer c
JOIN Account a
ON c.Customer_ID = a.Customer_ID;

/*
OUTPUT:

CUSTOMER_ID  CUSTOMER_NAME  ACCOUNT_NO  ACCOUNT_TYPE  BALANCE  STATUS
1            Deepika        100001      Savings       50000    Active
2            Priya          100002      Savings       75000    Active
3            Arun           100003      Current       150000   Active
4            Karthik        100004      Savings       30000    Active
5            Meena          100005      Savings       90000    Active
*/


/* ============================================================
   18. DISPLAY CUSTOMER AND BRANCH DETAILS
   ============================================================ */

SELECT
    c.Customer_Name,
    a.Account_No,
    b.Branch_Name,
    b.City,
    b.IFSC_Code
FROM Customer c
JOIN Account a
ON c.Customer_ID = a.Customer_ID
JOIN Branch b
ON a.Branch_ID = b.Branch_ID;

/*
OUTPUT:

CUSTOMER_NAME  ACCOUNT_NO  BRANCH_NAME          CITY        IFSC_CODE
Deepika        100001      Chennai Main Branch  Chennai     BANK000001
Priya          100002      Madurai Branch       Madurai     BANK000003
Arun           100003      Coimbatore Branch    Coimbatore  BANK000002
Karthik        100004      Trichy Branch        Trichy      BANK000004
Meena          100005      Chennai Main Branch  Chennai     BANK000001
*/


/* ============================================================
   19. DISPLAY SAVINGS ACCOUNTS
   ============================================================ */

SELECT
    Account_No,
    Customer_ID,
    Balance
FROM Account
WHERE Account_Type = 'Savings';

/*
OUTPUT:

ACCOUNT_NO  CUSTOMER_ID  BALANCE
100001      1            50000
100002      2            75000
100004      4            30000
100005      5            90000
*/


/* ============================================================
   20. DISPLAY ACCOUNTS WITH BALANCE > 50000
   ============================================================ */

SELECT
    Account_No,
    Customer_ID,
    Account_Type,
    Balance
FROM Account
WHERE Balance > 50000;

/*
OUTPUT:

ACCOUNT_NO  CUSTOMER_ID  ACCOUNT_TYPE  BALANCE
100002      2            Savings       75000
100003      3            Current       150000
100005      5            Savings       90000
*/


/* ============================================================
   21. DISPLAY BANK TRANSACTIONS
   ============================================================ */

SELECT * FROM Bank_Transaction;

/*
OUTPUT:

TRANSACTION_ID  ACCOUNT_NO  DATE       TYPE        AMOUNT
5001            100001      01-SEP-26  Deposit     10000
5002            100001      05-SEP-26  Withdrawal  5000
5003            100002      02-SEP-26  Deposit     20000
5004            100003      03-SEP-26  Withdrawal  15000
5005            100004      04-SEP-26  Deposit     5000
5006            100005      05-SEP-26  Deposit     25000

DESCRIPTION
Cash deposit
ATM withdrawal
Salary credit
Business payment
Cash deposit
Salary credit
*/


/* ============================================================
   22. DISPLAY TRANSACTIONS WITH CUSTOMER NAME
   ============================================================ */

SELECT
    c.Customer_Name,
    a.Account_No,
    t.Transaction_Date,
    t.Transaction_Type,
    t.Amount,
    t.Description
FROM Bank_Transaction t
JOIN Account a
ON t.Account_No = a.Account_No
JOIN Customer c
ON a.Customer_ID = c.Customer_ID;

/*
OUTPUT:

CUSTOMER_NAME  ACCOUNT_NO  TRANSACTION_DATE  TYPE        AMOUNT
Deepika        100001      01-SEP-26         Deposit     10000
Deepika        100001      05-SEP-26         Withdrawal  5000
Priya          100002      02-SEP-26         Deposit     20000
Arun           100003      03-SEP-26         Withdrawal  15000
Karthik        100004      04-SEP-26         Deposit     5000
Meena          100005      05-SEP-26         Deposit     25000

DESCRIPTION
Cash deposit
ATM withdrawal
Salary credit
Business payment
Cash deposit
Salary credit
*/


/* ============================================================
   23. FIND TOTAL DEPOSIT AMOUNT
   ============================================================ */

SELECT
    SUM(Amount) AS Total_Deposits
FROM Bank_Transaction
WHERE Transaction_Type = 'Deposit';

/*
OUTPUT:

TOTAL_DEPOSITS
--------------
60000
*/


/* ============================================================
   24. FIND TOTAL WITHDRAWAL AMOUNT
   ============================================================ */

SELECT
    SUM(Amount) AS Total_Withdrawals
FROM Bank_Transaction
WHERE Transaction_Type = 'Withdrawal';

/*
OUTPUT:

TOTAL_WITHDRAWALS
-----------------
20000
*/


/* ============================================================
   25. FIND HIGHEST ACCOUNT BALANCE
   ============================================================ */

SELECT
    Account_No,
    Customer_ID,
    Balance
FROM Account
WHERE Balance = (SELECT MAX(Balance) FROM Account);

/*
OUTPUT:

ACCOUNT_NO  CUSTOMER_ID  BALANCE
100003      3            150000
*/


/* ============================================================
   26. FIND LOWEST ACCOUNT BALANCE
   ============================================================ */

SELECT
    Account_No,
    Customer_ID,
    Balance
FROM Account
WHERE Balance = (SELECT MIN(Balance) FROM Account);

/*
OUTPUT:

ACCOUNT_NO  CUSTOMER_ID  BALANCE
100004      4            30000
*/


/* ============================================================
   27. COUNT ACCOUNTS BY ACCOUNT TYPE
   ============================================================ */

SELECT
    Account_Type,
    COUNT(*) AS Number_Of_Accounts
FROM Account
GROUP BY Account_Type;

/*
OUTPUT:

ACCOUNT_TYPE  NUMBER_OF_ACCOUNTS
Savings       4
Current       1
*/


/* ============================================================
   28. FIND AVERAGE ACCOUNT BALANCE
   ============================================================ */

SELECT
    AVG(Balance) AS Average_Balance
FROM Account;

/*
OUTPUT:

AVERAGE_BALANCE
---------------
79000
*/


/* ============================================================
   29. DISPLAY ALL LOANS
   ============================================================ */

SELECT * FROM Loan;

/*
OUTPUT:

LOAN_ID  CUSTOMER_ID  LOAN_TYPE        LOAN_AMOUNT  INTEREST_RATE
7001     1            Education Loan   200000       7.5
7002     2            Home Loan        1500000      8.25
7003     3            Business Loan    500000       9
7004     4            Personal Loan    300000       10.5

LOAN_STATUS
Active
Active
Active
Closed
*/


/* ============================================================
   30. DISPLAY ACTIVE LOANS
   ============================================================ */

SELECT
    Loan_ID,
    Customer_ID,
    Loan_Type,
    Loan_Amount,
    Interest_Rate,
    Loan_Status
FROM Loan
WHERE Loan_Status = 'Active';

/*
OUTPUT:

LOAN_ID  CUSTOMER_ID  LOAN_TYPE        LOAN_AMOUNT  RATE  STATUS
7001     1            Education Loan   200000       7.5   Active
7002     2            Home Loan        1500000      8.25  Active
7003     3            Business Loan    500000       9     Active
*/


/* ============================================================
   31. DISPLAY CUSTOMER LOAN DETAILS
   ============================================================ */

SELECT
    c.Customer_Name,
    l.Loan_ID,
    l.Loan_Type,
    l.Loan_Amount,
    l.Interest_Rate,
    l.Loan_Status
FROM Customer c
JOIN Loan l
ON c.Customer_ID = l.Customer_ID;

/*
OUTPUT:

CUSTOMER_NAME  LOAN_ID  LOAN_TYPE        LOAN_AMOUNT  RATE  STATUS
Deepika        7001     Education Loan   200000       7.5   Active
Priya          7002     Home Loan        1500000      8.25  Active
Arun           7003     Business Loan    500000       9     Active
Karthik        7004     Personal Loan    300000       10.5  Closed
*/


/* ============================================================
   32. FIND TOTAL LOAN AMOUNT
   ============================================================ */

SELECT
    SUM(Loan_Amount) AS Total_Loan_Amount
FROM Loan;

/*
OUTPUT:

TOTAL_LOAN_AMOUNT
-----------------
2500000
*/


/* ============================================================
   33. FIND HIGHEST LOAN
   ============================================================ */

SELECT
    Loan_ID,
    Customer_ID,
    Loan_Type,
    Loan_Amount
FROM Loan
WHERE Loan_Amount = (SELECT MAX(Loan_Amount) FROM Loan);

/*
OUTPUT:

LOAN_ID  CUSTOMER_ID  LOAN_TYPE    LOAN_AMOUNT
7002     2            Home Loan    1500000
*/


/* ============================================================
   34. DISPLAY LOAN PAYMENTS
   ============================================================ */

SELECT * FROM Loan_Payment;

/*
OUTPUT:

PAYMENT_ID  LOAN_ID  PAYMENT_DATE  PAYMENT_AMOUNT  PAYMENT_MODE
8001        7001     10-AUG-26     10000           UPI
8002        7002     15-AUG-26     25000           Bank Transfer
8003        7003     20-AUG-26     20000           Cheque
8004        7004     25-AUG-26     30000           UPI
*/


/* ============================================================
   35. DISPLAY LOAN PAYMENT DETAILS
   ============================================================ */

SELECT
    c.Customer_Name,
    l.Loan_Type,
    lp.Payment_Date,
    lp.Payment_Amount,
    lp.Payment_Mode
FROM Loan_Payment lp
JOIN Loan l
ON lp.Loan_ID = l.Loan_ID
JOIN Customer c
ON l.Customer_ID = c.Customer_ID;

/*
OUTPUT:

CUSTOMER_NAME  LOAN_TYPE        PAYMENT_DATE  PAYMENT_AMOUNT  MODE
Deepika        Education Loan   10-AUG-26     10000           UPI
Priya          Home Loan        15-AUG-26     25000           Bank Transfer
Arun           Business Loan    20-AUG-26     20000           Cheque
Karthik        Personal Loan    25-AUG-26     30000           UPI
*/


/* ============================================================
   36. FIND TOTAL LOAN PAYMENTS
   ============================================================ */

SELECT
    SUM(Payment_Amount) AS Total_Loan_Payments
FROM Loan_Payment;

/*
OUTPUT:

TOTAL_LOAN_PAYMENTS
-------------------
85000
*/


/* ============================================================
   37. UPDATE ACCOUNT BALANCE
   ============================================================ */

UPDATE Account
SET Balance = Balance + 5000
WHERE Account_No = 100001;

/*
OUTPUT:

1 row updated.

Account 100001 balance:
50000 + 5000 = 55000
*/


/* ============================================================
   38. UPDATE CUSTOMER PHONE NUMBER
   ============================================================ */

UPDATE Customer
SET Phone = '9999999999'
WHERE Customer_ID = 1;

/*
OUTPUT:

1 row updated.

Deepika's new phone number:
9999999999
*/


/* ============================================================
   39. UPDATE LOAN STATUS
   ============================================================ */

UPDATE Loan
SET Loan_Status = 'Closed'
WHERE Loan_ID = 7004;

/*
OUTPUT:

1 row updated.

Loan 7004 status:
Closed
*/


/* ============================================================
   40. DELETE LOAN PAYMENT
   ============================================================ */

DELETE FROM Loan_Payment
WHERE Payment_ID = 8004;

/*
OUTPUT:

1 row deleted.

Payment 8004 has been deleted.
*/


/* ============================================================
   41. COMMIT ALL CHANGES
   ============================================================ */

COMMIT;

/*
OUTPUT:

Commit complete.
*/


/* ============================================================
   42. FINAL VERIFICATION
   ============================================================ */

SELECT * FROM Customer;

/*
Deepika's phone number is now:

CUSTOMER_ID  CUSTOMER_NAME  PHONE
1            Deepika        9999999999
*/


SELECT * FROM Account;

/*
Account 100001 now has:

ACCOUNT_NO  BALANCE
100001      55000
*/


SELECT * FROM Loan_Payment;

/*
Payment 8004 has been deleted.

Remaining payments:

PAYMENT_ID  LOAN_ID  PAYMENT_AMOUNT
8001        7001     10000
8002        7002     25000
8003        7003     20000
*/


/* ============================================================
   END OF BANKING SYSTEM PROJECT
   ============================================================ */
