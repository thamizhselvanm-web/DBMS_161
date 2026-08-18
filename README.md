# DBMS Lab Exercises

> A comprehensive collection of **8 hands-on DBMS lab exercises** covering SQL fundamentals through advanced PL/SQL concepts. Perfect for students learning relational databases and procedural SQL.

Complete set of DBMS / PL-SQL lab exercises — SQL commands, PL/SQL blocks, expected outputs, and explanations, each in its own `.sql` file. Built from lab manual Ex. No. 1–8 (Simple/Nested/Sub Queries → Exception Handling).

---

## Table of Contents

- [Features & Highlights](#features--highlights)
- [Overview](#overview)
- [Repository Structure](#repository-structure)
- [Quick Start](#quick-start)
- [Exercise Index](#exercise-index)
  - [Ex 1: Simple, Nested & Sub Queries](#ex-1--simple-nested--sub-queries)
  - [Ex 2: Join Queries](#ex-2--join-queries)
  - [Ex 3: Views & Index](#ex-3--views--index)
  - [Ex 4: Implicit & Explicit Cursors](#ex-4--implicit--explicit-cursors)
  - [Ex 5: Procedures & Functions](#ex-5--procedures--functions)
  - [Ex 6: Triggers](#ex-6--triggers)
  - [Ex 7: Normalized Schema (Library System)](#ex-7--normalized-schema-library-system)
  - [Ex 8: Exception Handling](#ex-8--exception-handling)
- [Prerequisites & Setup](#prerequisites--setup)
- [How to Run](#how-to-run)
- [Database Compatibility](#database-compatibility)
- [Schema Summary](#schema-summary)
- [Troubleshooting](#troubleshooting)
- [Author & License](#author--license)

---

## Features & Highlights

* 8 Progressive Exercises — From basic queries to advanced PL/SQL
* Self-Contained Files — Each exercise is independent with complete setup
* Detailed Comments — Fully documented SQL/PL-SQL code
* Expected Outputs — Results shown inline for easy verification
* Multi-Database Support — Oracle, MySQL, and PostgreSQL compatibility
* Real-World Schemas — Student enrollment, library system, and customer data
* Learning Outcomes — Each exercise builds foundational database skills
* Production-Ready — Best practices and proper syntax throughout

---

## Overview

This repository contains **8 DBMS lab exercises** covering core relational database and PL/SQL concepts, progressing from basic queries to advanced procedural SQL:

### Learning Path

| # | Topic | Difficulty | Time | Key Skills |
|---|-------|------------|------|-----------|
| 1 | Simple, Nested & Sub Queries | Beginner | 30 min | `SELECT`, `WHERE`, nested `IN`, scalar subqueries, `GROUP BY`/`HAVING` |
| 2 | Join Queries | Beginner+ | 40 min | `INNER JOIN`, `LEFT JOIN`, `RIGHT JOIN`, `FULL OUTER JOIN` |
| 3 | Views & Index | Beginner+ | 35 min | `CREATE VIEW`, DML through views, `CREATE INDEX`, performance tuning |
| 4 | Implicit & Explicit Cursors | Intermediate | 45 min | `%FOUND`, `%NOTFOUND`, `%ROWCOUNT`, `%ISOPEN`, cursor loops |
| 5 | Procedures & Functions | Intermediate | 50 min | `CREATE OR REPLACE PROCEDURE`, `CREATE OR REPLACE FUNCTION`, parameters |
| 6 | Triggers | Intermediate | 45 min | `BEFORE INSERT/UPDATE/DELETE` triggers, `:NEW`/`:OLD`, event handling |
| 7 | Normalized Schema (Library System) | Beginner+ | 40 min | ER modeling, normalization, M:N associative entities |
| 8 | Exception Handling | Intermediate | 40 min | Pre-defined & user-defined exceptions, error propagation |

### What's in Each File

Each `.sql` file is **self-contained** and includes:
- Header comment block — Exercise No., Title, Aim, and Algorithm (from lab manual)
- Table creation & sample data — `CREATE TABLE`, `INSERT` statements
- Fully commented SQL/PL-SQL — Every query explained step-by-step
- Expected output — Results shown as inline comments directly below each query
- Result statement — Summary of the outcome and learning points

---

## Repository Structure

```
DBMS_EXERCISE/
├── README.md                                    # This file
├── DBMS_Experiment_1_Simple_Nested_Subqueries.sql
├── DBMS_Experiment_2_JOIN_Queries.sql
├── DBMS_Experiment_3_View_and_Index.sql
├── DBMS_Experiment_4_Cursors.sql
├── DBMS_Experiment_5_Procedures_and_Functions.sql
├── DBMS_Experiment_6_triggers.sql
├── DBMS_Experiment_07_normalized_schema_library.sql
└── DBMS_Experiment_08_exception_handling.sql
```

> Note: Each `.sql` file is standalone — you can run any exercise independently without running the others.

---

## Quick Start

### For Oracle SQL Developer / SQL*Plus

1. Open your RDBMS client (Oracle SQL Developer or SQL*Plus)
2. Navigate to the `DBMS_EXERCISE` directory
3. Run an exercise file:
   ```sql
   @DBMS_Experiment_1_Simple_Nested_Subqueries.sql
   ```
4. View output — Results appear in the console

### For MySQL Workbench

1. Open MySQL Workbench → File → Open SQL Script
2. Select an exercise file (e.g., `DBMS_Experiment_1_Simple_Nested_Subqueries.sql`)
3. Execute — Click the Execute icon or press `Ctrl+Enter`

### For PostgreSQL (psql)

```bash
psql -U username -d database_name -f DBMS_Experiment_1_Simple_Nested_Subqueries.sql
```

---

## Exercise Index

### Ex 1 — Simple, Nested & Sub Queries

**File:** `DBMS_Experiment_1_Simple_Nested_Subqueries.sql`
**Difficulty:** Beginner
**Time:** 30 minutes

**What you'll learn:**
- Writing basic `SELECT` statements with `WHERE` clauses
- Using nested `IN` subqueries (3 levels deep)
- Scalar aggregate subqueries with functions like `AVG`, `MAX`, `MIN`
- Grouping and filtering results with `GROUP BY` and `HAVING`

**Concepts covered:**
- **Tables:** `Students`, `Courses`, `Enrollments`
- **Queries:** Simple filters → nested IN → scalar subqueries → GROUP BY/HAVING
- **Real-world example:** Finding students enrolled in multiple courses with average grades

---

### Ex 2 — Join Queries

**File:** `DBMS_Experiment_2_JOIN_Queries.sql`
**Difficulty:** Beginner+
**Time:** 40 minutes

**What you'll learn:**
- All four join types: `INNER`, `LEFT`, `RIGHT`, `FULL OUTER`
- Cross joins and self joins
- Join performance and optimization
- Handling NULL values in joins
- MySQL-compatible `UNION`-based workarounds (since MySQL lacks `FULL OUTER JOIN`)

**Concepts covered:**
- **Tables:** `Student`, `Courses`, `Enrollments`
- **Queries:** INNER JOIN → LEFT JOIN → RIGHT JOIN → FULL OUTER JOIN
- **Real-world example:** Finding students, their courses, and enrollment details with multiple join strategies

---

### Ex 3 — Views & Index

**File:** `DBMS_Experiment_3_View_and_Index.sql`
**Difficulty:** Beginner+
**Time:** 35 minutes

**What you'll learn:**
- Creating views with `CREATE VIEW`
- Performing DML operations (`INSERT`, `UPDATE`, `DELETE`) through views
- How view changes affect underlying tables and vice versa
- Creating and inspecting indexes for query optimization
- Index impact on performance

**Concepts covered:**
- **View Operations:** Creating views, modifying data through views, understanding updatable views
- **Indexes:** Creating indexes, checking index details with `SHOW INDEX`, query performance
- **Real-world example:** A student view for simplified access and an index on frequently searched columns

---

### Ex 4 — Implicit & Explicit Cursors

**File:** `DBMS_Experiment_4_Cursors.sql`
**Difficulty:** Intermediate
**Time:** 45 minutes

**What you'll learn:**
- Implicit cursor attributes: `SQL%FOUND`, `SQL%NOTFOUND`, `SQL%ROWCOUNT`, `SQL%ISOPEN`
- Explicit cursor declaration and usage
- Cursor loop patterns with `OPEN` → `FETCH` → `EXIT WHEN` → `CLOSE`
- Handling NO_DATA_FOUND exceptions
- Row-by-row processing in PL/SQL

**Concepts covered:**
- **Implicit Cursors:** Automatic cursor attributes after DML operations
- **Explicit Cursors:** Full cursor lifecycle management
- **Real-world example:** Bulk updating records and iterating through results with proper cursor control

---

### Ex 5 — Procedures & Functions

**File:** `DBMS_Experiment_5_Procedures_and_Functions.sql`
**Difficulty:** Intermediate
**Time:** 50 minutes

**What you'll learn:**
- Creating procedures with `CREATE OR REPLACE PROCEDURE`
- Creating functions with `CREATE OR REPLACE FUNCTION`
- Input (IN), output (OUT), and bidirectional (IN/OUT) parameters
- Return types and calling PL/SQL blocks
- Differences between procedures and functions

**Concepts covered:**
- **Procedures:** No return value, used for actions (`Sum_Numbers` procedure)
- **Functions:** Explicit return type, used for computations (`Sum_Function`)
- **Parameters:** IN (default), OUT, and IN/OUT modes
- **Real-world example:** Calculating sums and returning results to calling programs

---

### Ex 6 — Triggers

**File:** `DBMS_Experiment_6_triggers.sql`
**Difficulty:** Intermediate
**Time:** 45 minutes

**What you'll learn:**
- Creating row-level triggers with `BEFORE INSERT/UPDATE/DELETE`
- Using `:NEW` and `:OLD` pseudo-records
- Trigger timing: `BEFORE` vs `AFTER`
- Event handling: `INSERT`, `UPDATE`, `DELETE`
- Raising application errors with `RAISE_APPLICATION_ERROR`
- Trigger-based logging and validation

**Concepts covered:**
- **BEFORE INSERT trigger:** Validation and auto-calculation
- **BEFORE UPDATE trigger:** Tracking old vs new values
- **BEFORE DELETE trigger:** Logging deletion events
- **Real-world example:** Auto-logging changes, enforcing business rules (e.g., salary caps)

---

### Ex 7 — Normalized Schema (Library System)

**File:** `DBMS_Experiment_07_normalized_schema_library.sql`
**Difficulty:** Beginner+
**Time:** 40 minutes

**What you'll learn:**
- Entity-Relationship (ER) modeling
- Database normalization (1NF → 3NF)
- Many-to-Many (M:N) relationships using associative/junction tables
- Proper foreign key relationships
- Real-world schema design

**Concepts covered:**
- **Entities:** Authors, Books, Borrowers (independent entities)
- **Relationships:**
  - Books ↔ Authors (M:N via `BookAuthors`)
  - Borrowers ↔ Books (M:N via `BorrowedBooks`)
- **Real-world example:** A complete library system with proper normalization

---

### Ex 8 — Exception Handling

**File:** `DBMS_Experiment_08_exception_handling.sql`
**Difficulty:** Intermediate
**Time:** 40 minutes

**What you'll learn:**
- Pre-defined exceptions: `NO_DATA_FOUND`, `TOO_MANY_ROWS`, `OTHERS`
- User-defined exceptions with `EXCEPTION ... WHEN`
- Exception propagation and handling
- Using `RAISE` and `RAISE_APPLICATION_ERROR`
- Error messages and logging

**Concepts covered:**
- **Pre-defined Exceptions:** Automatic Oracle exceptions (`NO_DATA_FOUND`, `OTHERS`)
- **User-defined Exceptions:** Custom exceptions for business logic (`ex_invalid_id`)
- **Exception Handling:** `BEGIN...EXCEPTION...END` blocks
- **Real-world example:** Validating user input and raising appropriate errors on violations

---

## Prerequisites & Setup

### System Requirements

| Component | Requirement | Notes |
|-----------|-------------|-------|
| RDBMS | Oracle 11g+ / MySQL 5.7+ / PostgreSQL 10+ | Choose one to get started |
| Client | SQL Developer, SQL*Plus, MySQL Workbench, pgAdmin, or DBeaver | Free tools available |
| OS | Windows, macOS, or Linux | DBMS software is cross-platform |
| Disk Space | 100 MB (minimum) | For DBMS installation + sample data |
| RAM | 2 GB (minimum) | Most modern systems have this |

### Which Database Should I Choose?

**For beginners and academic coursework:**
- **Oracle** — Best for exercises 4–8 (PL/SQL features)
- **MySQL** — Great for exercises 1–3, 7 (standard SQL); requires workarounds for 4–6, 8
- **PostgreSQL** — Good for exercises 1–3, 7; requires PL/pgSQL translation for 4–6, 8

**Recommended:** Start with **Oracle** (most complete feature set for this course)

### Installation Links

- PostgreSQL (Free): https://www.postgresql.org/download/
- MySQL (Free): https://dev.mysql.com/downloads/mysql/
- Oracle XE (Free): https://www.oracle.com/database/technologies/xe-downloads.html
- Oracle SQL Developer (Free): https://www.oracle.com/tools/downloads/sqldev-downloads.html

### Client Tools (IDE / GUI)

| Tool | Best For | Cost | Platform |
|------|----------|------|----------|
| Oracle SQL Developer | Oracle DB | Free | Win/Mac/Linux |
| SQL*Plus | Oracle DB (CLI) | Free | Win/Mac/Linux |
| MySQL Workbench | MySQL | Free | Win/Mac/Linux |
| pgAdmin | PostgreSQL | Free | Win/Mac/Linux |
| DBeaver | Any RDBMS | Free/Pro | Win/Mac/Linux |
| VS Code + Extensions | Any (with extensions) | Free | Win/Mac/Linux |

---

## How to Run

### Oracle SQL Developer or SQL*Plus

**Using SQL Developer (GUI):**

1. Open Oracle SQL Developer
2. Create or connect to a database
3. File → Open → Select a `.sql` file (e.g., `DBMS_Experiment_1_Simple_Nested_Subqueries.sql`)
4. Click the Execute button or press `Ctrl+Enter`
5. View results in the Script Output panel

**Using SQL*Plus (Command Line):**

```bash
# Connect to Oracle
sqlplus username/password@database

# Run a script from SQL*Plus prompt
SQL> @DBMS_Experiment_1_Simple_Nested_Subqueries.sql

# Enable output (important for PL/SQL!)
SQL> SET SERVEROUTPUT ON

# Exit
SQL> EXIT;
```

**Important:** Make sure `SET SERVEROUTPUT ON` is enabled so that `DBMS_OUTPUT.PUT_LINE` output is visible (this is included in each PL/SQL file).

---

### MySQL Workbench

**Step-by-step:**

1. Open MySQL Workbench
2. Click File → Open SQL Script
3. Select an exercise file (e.g., `DBMS_Experiment_1_Simple_Nested_Subqueries.sql`)
4. Click the Execute button or press `Ctrl+Shift+Enter`
5. Check the Output tab for results

**Alternative — Command line:**

```bash
mysql -u username -p database_name < DBMS_Experiment_1_Simple_Nested_Subqueries.sql
```

**Note:** Exercises 4, 5, 6, 8 use Oracle PL/SQL syntax and require translation to MySQL stored procedures.

---

### PostgreSQL (psql)

**Using pgAdmin (GUI):**

1. Open pgAdmin → Expand your server
2. Right-click your database → Query Tool
3. Click Open → Select a `.sql` file
4. Click Execute or press `F5`
5. View results in the panel below

**Using psql (Command Line):**

```bash
# Connect to PostgreSQL database
psql -U username -d database_name

# Run a script
\i DBMS_Experiment_1_Simple_Nested_Subqueries.sql

# Or execute directly without connecting first
psql -U username -d database_name -f DBMS_Experiment_1_Simple_Nested_Subqueries.sql
```

**Note:** Exercises 4, 5, 6, 8 use Oracle PL/SQL and require translation to PL/pgSQL.

---

## Database Compatibility

### Exercise Support by Database

| Exercise | Oracle | MySQL | PostgreSQL | Notes |
|----------|:------:|:-----:|:----------:|-------|
| Ex 1 — Simple, Nested & Sub Queries | Yes | Yes | Yes | Standard SQL — all databases supported |
| Ex 2 — Join Queries | Yes | Partial | Yes | MySQL needs `UNION` workaround for `FULL OUTER JOIN` |
| Ex 3 — Views & Index | Yes | Yes | Yes | Standard SQL — all databases supported |
| Ex 4 — Implicit & Explicit Cursors | Yes | No | No | Oracle PL/SQL only; MySQL/PostgreSQL use different cursor syntax |
| Ex 5 — Procedures & Functions | Yes | Partial | Partial | Oracle syntax; MySQL/PostgreSQL require stored procedure syntax changes |
| Ex 6 — Triggers | Yes | Partial | Partial | Oracle `:NEW`/`:OLD`; MySQL/PostgreSQL use `NEW`/`OLD` |
| Ex 7 — Normalized Schema | Yes | Yes | Yes | Standard SQL — all databases supported |
| Ex 8 — Exception Handling | Yes | No | No | Oracle PL/SQL exception syntax; others use different approaches |

### Legend
- Yes — Supported: Works out-of-the-box
- Partial — Minor Changes: Requires syntax adjustments
- No — Not Supported: Requires significant translation or alternative approach

### Database-Specific Notes

#### Oracle (Recommended for Learning)
- **Best for:** All 8 exercises (complete feature coverage)
- **Advantages:** 
  - All exercises work natively
  - Industry-standard PL/SQL
  - Rich feature set for learning
- **Setup:** Oracle XE (free) is sufficient for coursework

#### MySQL
- **Best for:** Exercises 1–3, 7
- **Limitations:**
  - Exercises 4, 5, 6, 8 require syntax translation
  - No native `FULL OUTER JOIN` (use `UNION` workaround)
  - Uses stored procedures instead of PL/SQL blocks
- **Workarounds:**
  - `FULL OUTER JOIN` emulation: Use `UNION` of left and right joins
  - Procedures: Use `CREATE PROCEDURE...BEGIN...END`
  - Exception handling: Use MySQL error handling syntax

#### PostgreSQL
- **Best for:** Exercises 1–3, 7
- **Limitations:**
  - Exercises 4, 5, 6, 8 require PL/pgSQL translation
  - Different trigger syntax (NEW/OLD instead of :NEW/:OLD)
  - Different exception handling
- **Workarounds:**
  - Use PL/pgSQL blocks instead of PL/SQL
  - Translate `DBMS_OUTPUT.PUT_LINE` to `RAISE NOTICE`
  - Use PostgreSQL-specific trigger and exception syntax

---

## Schema Summary

### Schema Overview

This repository uses multiple schemas to teach different concepts:

#### Schema 1: Student Enrollment System (Exercises 1–3)

```sql
Students / Student
├── StudentID (Primary Key)
├── Name
└── Age

Courses
├── CourseID (Primary Key)
└── CourseName

Enrollments
├── EnrollmentID (Primary Key)
├── StudentID (Foreign Key → Students)
└── CourseID (Foreign Key → Courses)
```

**Real-world use:** Track student course enrollments and grades

#### Schema 2: Customer Database (Exercises 4–6)

```sql
customers
├── id (Primary Key)
├── name
├── address
└── salary

customer
├── sid (Primary Key)
├── sname
└── stotal

classb
├── sid (Primary Key)
├── sname
├── sdept
├── stotal
└── grade
```

**Real-world use:** Customer account management with department tracking

#### Schema 3: Library Management System (Exercise 7)

```sql
Authors
├── AuthorID (Primary Key)
├── FirstName
└── LastName

Books
├── BookID (Primary Key)
├── Title
├── Genre
└── PublicationYear

Borrowers
├── BorrowerID (Primary Key)
├── FirstName
├── LastName
└── MembershipDate

BookAuthors (M:N Junction Table)
├── BookID (Foreign Key → Books)
├── AuthorID (Foreign Key → Authors)

BorrowedBooks (M:N Junction Table)
├── BorrowerID (Foreign Key → Borrowers)
├── BookID (Foreign Key → Books)
├── BorrowedDate
└── ReturnDate
```

**Real-world use:** Complete library system with authors, books, and borrower tracking

### Key Concepts Demonstrated

- **Primary Keys:** Unique identifiers for each entity
- **Foreign Keys:** Relationships between tables
- **Normalization:** Reduced data redundancy and improved integrity
- **Associative Tables:** Junction tables for many-to-many relationships (BookAuthors, BorrowedBooks)
- **Data Types:** VARCHAR, INT, DATE, NUMBER
- **Constraints:** NOT NULL, UNIQUE, FOREIGN KEY relationships

---

## Troubleshooting

### Common Issues & Solutions

#### "ORA-06550: Line 1, Column 7: PLS-00103: Encountered the symbol 'CREATE'"
**Problem:** PL/SQL block execution issue
**Solution:** Ensure `SET SERVEROUTPUT ON` is set before running PL/SQL blocks

```sql
SET SERVEROUTPUT ON;
-- Then run your script
@DBMS_Experiment_4_Cursors.sql
```

#### "Table 'tablename' doesn't exist"
**Problem:** Running exercise in wrong database or database not initialized
**Solution:**
- Verify you're connected to the correct database
- Ensure you're running the `.sql` file from the beginning (includes `CREATE TABLE` statements)

#### "MySQL: FULL OUTER JOIN not supported"
**Problem:** MySQL doesn't have native `FULL OUTER JOIN`
**Solution:** Use the `UNION`-based workaround included in Exercise 2:

```sql
-- FULL OUTER JOIN emulation in MySQL
SELECT * FROM table1 LEFT JOIN table2 ON ...
UNION
SELECT * FROM table1 RIGHT JOIN table2 ON ...;
```

#### "PostgreSQL: function dbms_output.put_line(...) does not exist"
**Problem:** Trying to run Oracle PL/SQL on PostgreSQL
**Solution:** Translate `DBMS_OUTPUT.PUT_LINE` to `RAISE NOTICE`:

```plpgsql
-- Oracle
DBMS_OUTPUT.PUT_LINE('Hello World');

-- PostgreSQL
RAISE NOTICE 'Hello World';
```

#### "Syntax error near ':='"
**Problem:** Running Oracle PL/SQL on MySQL/PostgreSQL
**Solution:** Differences in syntax for variable assignment and procedures. Consult database-specific stored procedure documentation.

#### "No rows returned" (when expecting results)
**Problem:** Data not inserted properly or query has wrong logic
**Solution:**
1. Check `INSERT` statements completed successfully
2. Verify `WHERE` clause conditions
3. Run intermediate `SELECT` queries to debug
4. Check table contents: `SELECT * FROM table_name;`

#### "Permission denied" when running scripts
**Problem:** User doesn't have required privileges
**Solution:**
- Ensure user account has `CREATE TABLE`, `INSERT`, `SELECT` privileges
- For PL/SQL: User needs `CREATE PROCEDURE` and `CREATE TRIGGER` privileges
- Connect as an admin/privileged user if needed

### Debugging Tips

1. **Enable verbose output:**
   ```sql
   SET SERVEROUTPUT ON SIZE 20000;  -- Oracle
   ```

2. **Run queries step-by-step:**
   - Don't run the entire file; execute queries individually
   - Check each `SELECT` output before proceeding

3. **Check table structure:**
   ```sql
   -- Oracle
   DESC table_name;

   -- MySQL
   SHOW COLUMNS FROM table_name;

   -- PostgreSQL
   \d table_name
   ```

4. **Review error messages carefully:**
   - Note the line number where the error occurred
   - Look for syntax issues or missing objects

5. **Consult database documentation:**
   - Oracle: `SELECT * FROM USER_TABLES;` lists your tables
   - MySQL: `SHOW TABLES;`
   - PostgreSQL: `\dt` lists tables

---

## Author & License

### Author

**Thamizhselvan_M**
B.E. Computer Science and Engineering
IFET College of Engineering
GitHub: [thamizhselvanm-web](https://github.com/thamizhselvanm-web)

---

### License

**Academic & Educational Use**

This project is created for **academic and educational purposes**. It's designed to support DBMS lab coursework and is freely available for:
- Educational use in classroom settings
- Personal learning and skill development
- Forking and adapting for your own coursework
- Sharing with other students (with attribution)

**Please cite:** If you use this repository in your coursework or publications, please provide attribution to Thamizhselvan_M.

---

### Contributing

Have improvements or corrections? Feel free to:
- Report issues in GitHub
- Submit pull requests for bug fixes
- Suggest enhancements

---

### Support & Questions

For questions about:
- **SQL/Database concepts** — Refer to database-specific documentation
- **DBMS topics** — Check standard textbooks or official documentation
- **This repository** — Create an issue on GitHub

**Additional Resources:**
- [Oracle Documentation](https://docs.oracle.com/en/database/)
- [MySQL Documentation](https://dev.mysql.com/doc/)
- [PostgreSQL Documentation](https://www.postgresql.org/docs/)

---

### Disclaimer

> This repository is provided AS-IS for educational purposes. Users are responsible for understanding the code and ensuring it's appropriate for their use case. The author is not liable for any damages or issues arising from the use of these exercises.

---

**Last Updated:** August 2026
**Repository Status:** Active & Maintained
