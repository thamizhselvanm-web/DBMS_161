# DBMS Lab Exercises 🗄️

Complete set of DBMS / PL-SQL lab exercises — SQL commands, PL/SQL blocks, expected outputs, and explanations, each in its own `.sql` file. Built from lab manual Ex. No. 1–8 (Simple/Nested/Sub Queries → Exception Handling).

## 📋 Table of Contents

- [Overview](#overview)
- [Repository Structure](#repository-structure)
- [Exercise Index](#exercise-index)
- [Prerequisites](#prerequisites)
- [How to Run](#how-to-run)
- [Database Compatibility Notes](#database-compatibility-notes)
- [Schema Summary](#schema-summary)
- [Author](#author)
- [License](#license)

## Overview

This repository contains 8 DBMS lab exercises covering core relational database and PL/SQL concepts:

| # | Topic | Key Concepts |
|---|-------|---------------|
| 1 | Simple, Nested & Sub Queries | `SELECT`, `WHERE`, nested `IN`, scalar subqueries, `GROUP BY`/`HAVING` |
| 2 | Join Queries | `INNER JOIN`, `LEFT JOIN`, `RIGHT JOIN`, `FULL OUTER JOIN` |
| 3 | Views & Index | `CREATE VIEW`, DML through views, `CREATE INDEX` |
| 4 | Implicit & Explicit Cursors | `%FOUND`, `%NOTFOUND`, `%ROWCOUNT`, `%ISOPEN`, cursor loops |
| 5 | Procedures & Functions | `CREATE OR REPLACE PROCEDURE`, `CREATE OR REPLACE FUNCTION` |
| 6 | Triggers | `BEFORE INSERT/UPDATE/DELETE` triggers, `:NEW`/`:OLD` |
| 7 | Normalized Schema (Library System) | ER modeling, normalization, M:N associative entities |
| 8 | Exception Handling | Pre-defined (`NO_DATA_FOUND`, `OTHERS`) & user-defined exceptions |

Each `.sql` file is self-contained and includes:
- **Header comment block** with Ex No., Title, Aim, and Algorithm (taken from the lab manual)
- **Table creation & sample data** (`CREATE TABLE`, `INSERT`)
- **Fully commented SQL/PL-SQL statements**
- **Expected output** shown as inline comments directly below each query
- **Result statement** summarizing the outcome

## Repository Structure

```
dbms-lab-exercises/
├── README.md
└── sql/
    ├── 01_simple_nested_subqueries.sql
    ├── 02_join_queries.sql
    ├── 03_views_and_index.sql
    ├── 04_implicit_explicit_cursors.sql
    ├── 05_procedures_and_functions.sql
    ├── 06_triggers.sql
    ├── 07_normalized_schema_library.sql
    └── 08_exception_handling.sql
```

## Exercise Index

### Ex 1 — Simple, Nested & Sub Queries
**File:** [`sql/01_simple_nested_subqueries.sql`]
Builds `Students`, `Courses`, `Enrollments` tables and demonstrates simple filters, nested `IN` subqueries (3 levels deep), scalar aggregate subqueries (`AVG`), and `GROUP BY … HAVING` subqueries.

### Ex 2 — Join Queries
**File:** [`sql/02_join_queries.sql`]
Demonstrates all four join types across `Student`, `Courses`, `Enrollments`. Includes a MySQL-compatible `UNION`-based emulation of `FULL OUTER JOIN` since MySQL lacks native support.

### Ex 3 — Views & Index
**File:** [`sql/03_views_and_index.sql`]
Creates a `student_view`, performs `INSERT`/`UPDATE`/`DELETE` on the base table and verifies changes propagate through the view, then creates and inspects an index for performance on large tables.

### Ex 4 — Implicit & Explicit Cursors
**File:** [`sql/04_implicit_explicit_cursors.sql`]
Shows the implicit `SQL%` cursor attributes after a bulk `UPDATE`, and a fully-declared explicit cursor with `OPEN` → `LOOP`/`FETCH` → `EXIT WHEN %NOTFOUND` → `CLOSE`.

### Ex 5 — Procedures & Functions
**File:** [`sql/05_procedures_and_functions.sql`]
`Sum_Numbers` procedure (IN params, no return) and `Sum_Function` function (IN params, `RETURN NUMBER`), each with a calling PL/SQL block.

### Ex 6 — Triggers
**File:** [`sql/06_triggers.sql`]
Three `BEFORE` row-level triggers: on `UPDATE` (prints `:OLD`/`:NEW`), on `DELETE` (logs deletion), and on `INSERT` (raises a user-defined exception via `RAISE_APPLICATION_ERROR` if `stotal > 1000`).

### Ex 7 — Normalized Schema (Library System)
**File:** [`sql/07_normalized_schema_library.sql`]
Full ER-driven, normalized schema: `Authors`, `Books`, `Borrowers`, plus `BookAuthors` and `BorrowedBooks` as associative (junction) tables modeling the two many-to-many relationships.

### Ex 8 — Exception Handling
**File:** [`sql/08_exception_handling.sql`].
Pre-defined exception handling (`NO_DATA_FOUND`, `OTHERS`) and a user-defined exception (`ex_invalid_id`) raised on a business-rule violation, both with proper propagation and display.

## Prerequisites

- An RDBMS client / server. Exercises 4–6 and 8 use **Oracle PL/SQL** syntax (`DECLARE`/`BEGIN`/`END`, `DBMS_OUTPUT`, `%TYPE`, triggers with `:NEW`/`:OLD`).
- Exercises 1–3 and 7 use **ANSI-standard SQL** that runs on MySQL, PostgreSQL, and Oracle with minor tweaks (see notes below).
- Recommended tools: **Oracle SQL Developer**, **SQL*Plus**, or **PostgreSQL/pgAdmin** for the PL/SQL exercises; **MySQL Workbench** or **DBeaver** for the pure-SQL exercises.

## How to Run

### Oracle (SQL*Plus / SQL Developer)
```bash
sqlplus username/password@database
SQL> @sql/04_implicit_explicit_cursors.sql
```
Make sure `SET SERVEROUTPUT ON` is enabled (already included at the top of each PL/SQL file) so `DBMS_OUTPUT.PUT_LINE` output is visible.

### PostgreSQL
```bash
psql -U username -d your_database -f sql/01_simple_nested_subqueries.sql
```
> Note: PostgreSQL doesn't support PL/SQL (`DBMS_OUTPUT`, `%TYPE` triggers as written) — Exercises 4, 5, 6, 8 would need translation to PL/pgSQL (`RAISE NOTICE`, `%TYPE` is supported, but trigger syntax differs). Exercises 1, 2, 3, 7 run natively.

### MySQL
```bash
mysql -u username -p your_database < sql/02_join_queries.sql
```
> Note: MySQL has no native `FULL OUTER JOIN` — see the `UNION`-based workaround included as a comment in Exercise 2. MySQL also lacks PL/SQL blocks; use MySQL stored procedure syntax for 4–6, 8 if needed.

## Database Compatibility Notes

| Exercise | Best run on | Notes |
|----------|-------------|-------|
| 1 | Any (MySQL/PostgreSQL/Oracle) | Standard SQL |
| 2 | Any | `FULL OUTER JOIN` needs emulation on MySQL |
| 3 | Any | `SHOW INDEX` is MySQL-specific; alternatives noted in comments |
| 4 | Oracle | PL/SQL cursors |
| 5 | Oracle | PL/SQL procedures/functions |
| 6 | Oracle | Trigger syntax (`:NEW`/`:OLD`) is Oracle-style |
| 7 | Any | Standard SQL, `AUTO_INCREMENT` is MySQL syntax (`SERIAL`/`IDENTITY` elsewhere) |
| 8 | Oracle | PL/SQL exception handling |

## Schema Summary

```
Students / Student (StudentID PK, Name, Age)
Courses            (CourseID PK, CourseName)
Enrollments        (StudentID/EnrollmentID, StudentID FK, CourseID FK, [Grade])

students (view/index demo) (student_id PK, student_name, student_email)

customers  (id PK, name, address, salary)
customer   (sid PK, sname, stotal)
classb     (sid PK, sname, sdept, stotal, grade)

Authors       (AuthorID PK, FirstName, LastName)
Books         (BookID PK, Title, Genre, PublicationYear)
Borrowers     (BorrowerID PK, FirstName, LastName, MembershipDate)
BookAuthors   (BookID FK, AuthorID FK)              -- M:N junction
BorrowedBooks (BorrowerID FK, BookID FK, BorrowedDate, ReturnDate)  -- M:N junction
```

## Author

**Thamizhselvan_M** — B.E. Computer Science and Engineering, IFET College of Engineering
GitHub: [github.com/thamizhselvanm-web](https://github.com/thamizhselvanm-web)

## License

This project is for academic/educational purposes. Feel free to fork and adapt for your own DBMS lab coursework.
