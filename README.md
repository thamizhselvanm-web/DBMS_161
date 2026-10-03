# Database Management Systems Laboratory

A comprehensive, production-grade collection of **Database Management Systems Laboratory exercises and enterprise projects** implemented in **SQL, PL/SQL, NoSQL, and Distributed Database systems**. This repository spans fundamental relational querying, joins, views, indexing, procedural PL/SQL (cursors, stored procedures, functions, triggers, and exception handling), 3NF/BCNF relational normalization, modern NoSQL database paradigms (Key-Value, Columnar, Document, and Graph), MongoDB CRUD operations, Apache Cassandra multi-node distributed clustering with CQL, and a complete end-to-end Enterprise Banking Management System.

The repository is built with an emphasis on **rigorous schema design, relational integrity constraints, ACID transactional guarantees, real-world data modeling, and clean documentation**, serving as an ideal companion for university laboratory courses, practical examinations, viva preparation, and portfolio showcase.

---

## Index of Experiments

| Experiment | Title | Category / Core Concepts | Source File |
|:---|:---|:---|:---|
| **Ex 1** | Simple, Nested & Subqueries | Relational SQL (DQL, Aggregations, Subqueries) | [`DBMS_Experiment_1_Simple_Nested_Subqueries.sql`](DBMS_Experiment_1_Simple_Nested_Subqueries.sql) |
| **Ex 2** | JOIN Queries & Set Operations | Relational Algebra (INNER, LEFT, RIGHT, FULL OUTER) | [`DBMS_Experiment_2_JOIN_Queries.sql`](DBMS_Experiment_2_JOIN_Queries.sql) |
| **Ex 3** | Views & Performance Indexing | Schema Objects (Updatable Views, B-Tree Indexes) | [`DBMS_Experiment_3_View_and_Index.sql`](DBMS_Experiment_3_View_and_Index.sql) |
| **Ex 4** | Implicit & Explicit Cursors | Procedural SQL (PL/SQL Cursor Attributes & Loops) | [`DBMS_Experiment_4_Cursors.sql`](DBMS_Experiment_4_Cursors.sql) |
| **Ex 5** | Stored Procedures & Functions | Modular PL/SQL (IN/OUT Parameters, Return Values) | [`DBMS_Experiment_5_Procedures_and_Functions.sql`](DBMS_Experiment_5_Procedures_and_Functions.sql) |
| **Ex 6** | Database Triggers | Active Rules (BEFORE/AFTER DML, Event Validation) | [`DBMS_Experiment_6_triggers.sql`](DBMS_Experiment_6_triggers.sql) |
| **Ex 7** | Normalized Schema (Library System) | Relational Normalization (1NF, 2NF, 3NF/BCNF, M:N) | [`DBMS_Experiment_07_normalized_schema_library.sql`](DBMS_Experiment_07_normalized_schema_library.sql) |
| **Ex 8** | Exception Handling in PL/SQL | Robust Error Propagation (Predefined & User-Defined) | [`DBMS_Experiment_08_exception_handling.sql`](DBMS_Experiment_08_exception_handling.sql) |
| **Ex 9** | NoSQL Database Models | NoSQL Architectures (Key-Value, Column, Document, Graph) | [`DBMS_Experiment_09_nosql_database_models.txt`](DBMS_Experiment_09_nosql_database_models.txt) |
| **Ex 10** | Document Database with MongoDB | Document Store (MongoDB CRUD, Collections & BSON) | [`DBMS_Experiment_10_mongodb_crud_library.js`](DBMS_Experiment_10_mongodb_crud_library.js) |
| **Ex 11** | Cassandra Distributed Cluster & CQL | Distributed Columnar Store (Gossip Ring, Keyspace, CQL) | [`DBMS_Experiment_11_cassandra_cluster_and_cql.txt`](DBMS_Experiment_11_cassandra_cluster_and_cql.txt) |
| **Ex 12 / Project** | Enterprise Banking Management System | Full-Stack Commercial RDBMS (6 Tables, DDL/DML, Audit) | [`DBMS_Mini_Project_Banking_System.sql`](DBMS_Mini_Project_Banking_System.sql) |

---

## Repository Structure

```text
DBMS_EXERCISE/
├── README.md
├── DBMS_Experiment_1_Simple_Nested_Subqueries.sql
├── DBMS_Experiment_2_JOIN_Queries.sql
├── DBMS_Experiment_3_View_and_Index.sql
├── DBMS_Experiment_4_Cursors.sql
├── DBMS_Experiment_5_Procedures_and_Functions.sql
├── DBMS_Experiment_6_triggers.sql
├── DBMS_Experiment_07_normalized_schema_library.sql
├── DBMS_Experiment_08_exception_handling.sql
├── DBMS_Experiment_09_nosql_database_models.txt
├── DBMS_Experiment_10_mongodb_crud_library.js
├── DBMS_Experiment_11_cassandra_cluster_and_cql.txt
└── DBMS_Mini_Project_Banking_System.sql
```

---

## Program Explanations

### 1. Relational Query Operations & Joins (SQL Fundamentals)

#### Ex 1: Simple, Nested & Subqueries
- **File:** [`DBMS_Experiment_1_Simple_Nested_Subqueries.sql`](DBMS_Experiment_1_Simple_Nested_Subqueries.sql)
- **Description:** Implements relational Data Query Language (DQL) constructs over an academic enrollment domain (`Students`, `Courses`, `Enrollments`). Covers projection, filtering with boolean predicates, pattern matching, aggregate functions (`COUNT`, `AVG`, `MAX`, `MIN`), grouping with `GROUP BY` and `HAVING`, independent subqueries with `IN`, and correlated subqueries with `EXISTS`.
- **Key Concepts:** Scalar subqueries, multi-row subqueries, projection algebra, aggregate grouping, and foreign key reference integrity.
- **Dialect / Target:** MySQL 8.0+ / Oracle 19c+ / ANSI SQL standard.

#### Ex 2: JOIN Queries & Relational Algebra
- **File:** [`DBMS_Experiment_2_JOIN_Queries.sql`](DBMS_Experiment_2_JOIN_Queries.sql)
- **Description:** Demonstrates the complete taxonomy of relational joins across normalized tables. Implements equi-joins, `INNER JOIN` for strict intersections, `LEFT OUTER JOIN` to preserve left relation rows with null-padded missing matches, `RIGHT OUTER JOIN` for right relation persistence, and `FULL OUTER JOIN` for complete symmetric outer unions.
- **Key Concepts:** Cartesian product filtering vs explicit ANSI join syntax, preserving unmatched tuples, join predicates vs filter predicates.
- **Dialect / Target:** Oracle 19c+ / PostgreSQL 14+ / MySQL (with `UNION` emulation for full outer join).

---

### 2. Schema Objects & Performance Tuning (Views & Indexes)

#### Ex 3: Views, Updatable Views & B-Tree Indexing
- **File:** [`DBMS_Experiment_3_View_and_Index.sql`](DBMS_Experiment_3_View_and_Index.sql)
- **Description:** Explores logical schema abstraction and query acceleration. Creates simple views for data security and encapsulation, complex aggregated views joining multiple underlying relations, demonstrates DML propagation through updatable views with `WITH CHECK OPTION`, and implements single-column and composite B-Tree indexes for accelerating search predicates.
- **Key Concepts:** Logical data independence, virtual tables, security through column restriction, B-Tree index structure, query plan optimization.
- **Dialect / Target:** MySQL / Oracle / PostgreSQL.

---

### 3. Procedural SQL & Cursor Processing (PL/SQL Blocks)

#### Ex 4: Implicit & Explicit Cursors
- **File:** [`DBMS_Experiment_4_Cursors.sql`](DBMS_Experiment_4_Cursors.sql)
- **Description:** Implements memory context areas in PL/SQL using both implicit cursors (`SQL%FOUND`, `SQL%NOTFOUND`, `SQL%ROWCOUNT`) for single-row queries/DML operations and explicit cursors (`CURSOR ... IS SELECT`, `OPEN`, `FETCH`, `CLOSE`, and cursor `FOR` loops) for multi-row sequential processing.
- **Key Concepts:** Private SQL area allocation, active set iteration, row-by-row data transformation, buffer overflow prevention.
- **Dialect / Target:** Oracle PL/SQL (SQL*Plus / SQL Developer / Live SQL).

#### Ex 5: Stored Procedures & User-Defined Functions
- **File:** [`DBMS_Experiment_5_Procedures_and_Functions.sql`](DBMS_Experiment_5_Procedures_and_Functions.sql)
- **Description:** Implements modular procedural programming in the database engine. Creates standalone stored procedures accepting `IN`, `OUT`, and `IN OUT` parameter modes to encapsulate business logic (such as customer balance adjustments), alongside deterministic user-defined functions returning computed scalar results directly callable within SQL expressions.
- **Key Concepts:** Modularity, compilation into data dictionary, reduced network round-trips, execution privileges.
- **Dialect / Target:** Oracle PL/SQL / MySQL Stored Routines.

---

### 4. Active Database Rules & Robust Error Handling

#### Ex 6: Database Triggers (BEFORE / AFTER Event Validation)
- **File:** [`DBMS_Experiment_6_triggers.sql`](DBMS_Experiment_6_triggers.sql)
- **Description:** Implements active database rules that automatically fire in response to DML operations (`INSERT`, `UPDATE`, `DELETE`). Uses row-level triggers with `:NEW` and `:OLD` bind variables to enforce business constraints, audit log modifications, and abort illegal balance mutations using `RAISE_APPLICATION_ERROR`.
- **Key Concepts:** Event-Condition-Action (ECA) model, statement vs row-level granularity, mutating table avoidance, audit trail maintenance.
- **Dialect / Target:** Oracle PL/SQL.

#### Ex 8: Comprehensive Exception Handling & Error Propagation
- **File:** [`DBMS_Experiment_8_exception_handling.sql`](DBMS_Experiment_8_exception_handling.sql)
- **Description:** Implements resilient fault-tolerant PL/SQL blocks. Demonstrates interception of internally defined system exceptions (`NO_DATA_FOUND`, `TOO_MANY_ROWS`, `ZERO_DIVIDE`), predefined Oracle errors, custom user-defined exceptions declared via `EXCEPTION` and triggered via `RAISE`, error code/message extraction via `SQLCODE` and `SQLERRM`, and hierarchical block propagation.
- **Key Concepts:** Exception declaration, propagation stack, graceful failure degradation, custom error numbers (`-20001` to `-20999`).
- **Dialect / Target:** Oracle PL/SQL.

---

### 5. Relational Modeling & Schema Normalization

#### Ex 7: Normalized Relational Schema Design (Library Management System)
- **File:** [`DBMS_Experiment_07_normalized_schema_library.sql`](DBMS_Experiment_07_normalized_schema_library.sql)
- **Description:** Designs and implements a fully normalized enterprise schema for a university library management system. Decomposes unnormalized attributes to eliminate insertion, update, and deletion anomalies through First Normal Form (1NF - atomicity), Second Normal Form (2NF - full functional dependency), and Third Normal Form (3NF/BCNF - elimination of transitive dependencies). Models Many-to-Many ($M:N$) associations via junction/associative tables.
- **Entities & Tables:**
  - `Authors` (`AuthorID`, `FirstName`, `LastName`)
  - `Books` (`BookID`, `Title`, `Genre`, `PublicationYear`)
  - `Borrowers` (`BorrowerID`, `FirstName`, `LastName`, `MembershipDate`)
  - `BookAuthors` (`BookID`, `AuthorID`) - Junction Table for $M:N$ Author-Book linkage
  - `BorrowedBooks` (`BorrowerID`, `BookID`, `BorrowedDate`, `ReturnDate`) - Circulation Junction Table
- **Dialect / Target:** Oracle SQL (with `GENERATED ALWAYS AS IDENTITY`).

---

### 6. NoSQL Paradigms & Modern Distributed Systems

#### Ex 9: Multi-Model NoSQL Architectures
- **File:** [`DBMS_Experiment_09_nosql_database_models.txt`](DBMS_Experiment_09_nosql_database_models.txt)
- **Description:** Explores and contrasts the four foundational non-relational database architectures:
  1. **Key-Value Store (Redis-Style):** Direct associative mapping for sub-millisecond retrieval (`SET`, `GET`, `MGET`).
  2. **Column-Family / Columnar Store (Cassandra CQL):** Sparse multi-dimensional distributed storage indexed by `RowKey`.
  3. **Document-Oriented Store (MongoDB):** Flexible JSON/BSON document collections supporting nested polymorphic structures.
  4. **Graph Database (Neo4j Cypher):** Entity nodes and first-class directed relationships (`-[:LIVES_IN]->`, `-[:LIKES]->`) for network graph traversal.
- **Key Concepts:** CAP theorem, BASE properties (Basically Available, Soft state, Eventual consistency), schema-on-read vs schema-on-write.

#### Ex 10: Document Database Implementation with MongoDB
- **File:** [`DBMS_Experiment_10_mongodb_crud_library.js`](DBMS_Experiment_10_mongodb_crud_library.js)
- **Description:** Implements a document-oriented database for the Library System in MongoDB, serving as the direct NoSQL counterpart to Experiment 7's relational schema. Performs full CRUD (Create, Read, Update, Delete) lifecycle operations using MongoDB shell (`mongosh`):
  - **Create:** Batch document insertions (`insertMany()`) with ISO date objects and reference arrays.
  - **Read:** Formatted queries (`find().pretty()`) with criteria projection.
  - **Update:** Atomic in-place property mutations using the `$set` operator (`updateOne()`).
  - **Delete:** Targeted document removals (`deleteOne()`).
- **Collections:** `authors`, `books`, `borrowers`, `borrowedBooks`.
- **Dialect / Target:** MongoDB Shell (`mongosh`) / Node.js MongoDB Driver.

#### Ex 11: Distributed Database Cluster & CQL Operations (Apache Cassandra)
- **File:** [`DBMS_Experiment_11_cassandra_cluster_and_cql.txt`](DBMS_Experiment_11_cassandra_cluster_and_cql.txt)
- **Description:** Implements a distributed peer-to-peer masterless columnar database cluster using Apache Cassandra. Configures `cassandra.yaml` parameters (`cluster_name`, `seeds`, `listen_address`, `endpoint_snitch`), inspects cluster ring health and token distribution via `nodetool status`, establishes sessions through `cqlsh`, creates keyspaces with configurable replication strategies (`SimpleStrategy`, `replication_factor: 3`), and executes DDL/DML on partitioned column tables.
- **Key Concepts:** Peer-to-peer gossip protocol, consistent hashing token ring, replication factor, tunable consistency, write path optimization.
- **Dialect / Target:** Apache Cassandra 4.x / 5.x, `cqlsh`, `nodetool`.

---

### 7. Applied Enterprise Relational System (DBMS Mini Project)

#### Ex 12 / Mini Project: Commercial Banking Management System
- **File:** [`DBMS_Mini_Project_Banking_System.sql`](DBMS_Mini_Project_Banking_System.sql)
- **Description:** An enterprise-grade, comprehensive relational database management system modeling commercial banking operations. Comprises 42 modular sections encompassing cascading schema teardowns, foreign-key validated table declarations, sample master data population, complex financial queries, analytical reports, loan sanctioning workflows, transaction logging, atomic balance reconciliations, and audit trail verifications.
- **System Modules & Schema Entities:**
  - `Customer`: Customer master profiles (ID, Name, DOB, Gender, Phone, Email, Address).
  - `Branch`: Geographic branch locations with unique routing IFSC codes.
  - `Account`: Savings and Current accounts with balance constraints and customer/branch foreign keys.
  - `Bank_Transaction`: Audit ledger logging chronological Deposits and Withdrawals.
  - `Loan`: Credit financing module tracking approved loans, interest rates, and loan statuses.
  - `Loan_Payment`: Installment payment history tracking repayment amounts and payment modes.
- **Core Operations Included:**
  - Dynamic cascading drop scripts guarded with PL/SQL exception blocks.
  - Multi-table cross-entity joins (Customer $\times$ Account $\times$ Branch $\times$ Transactions).
  - Aggregation queries for total deposit liquidity, total withdrawal volumes, and average balances by account type.
  - Credit status updates, active loan filtering, and loan repayment accounting.
  - Transactional commits and data integrity post-verification checks.
- **Dialect / Target:** Oracle SQL & PL/SQL.

---

## Database Paradigm and Architecture Summary

| Experiment | Title / Topic | Paradigm / Model | Engine / Platform | Key Constructs & Commands | Core Schema / Entities |
|:---|:---|:---:|:---:|:---|:---|
| **Ex 1** | Simple & Nested Subqueries | Relational (RDBMS) | MySQL / Oracle | `SELECT`, `WHERE`, `IN`, `EXISTS`, `GROUP BY`, `HAVING` | `Students`, `Courses`, `Enrollments` |
| **Ex 2** | JOIN Queries & Outer Joins | Relational (RDBMS) | Oracle / PostgreSQL | `INNER JOIN`, `LEFT JOIN`, `RIGHT JOIN`, `FULL OUTER JOIN` | `Students`, `Courses`, `Enrollments` |
| **Ex 3** | Views & Performance Indexing | Relational Objects | MySQL / Oracle | `CREATE VIEW`, `WITH CHECK OPTION`, `CREATE INDEX` | `Students`, `Courses`, View layer |
| **Ex 4** | Implicit & Explicit Cursors | Procedural (PL/SQL) | Oracle PL/SQL | `CURSOR`, `OPEN`, `FETCH`, `CLOSE`, `%FOUND`, `%ROWCOUNT` | `Customers` table & PL/SQL loops |
| **Ex 5** | Procedures & Functions | Modular Procedural | Oracle PL/SQL | `PROCEDURE`, `FUNCTION`, `IN`, `OUT`, `IN OUT`, `RETURN` | `Customers`, Account balances |
| **Ex 6** | Database Triggers | Active Rules | Oracle PL/SQL | `TRIGGER`, `BEFORE/AFTER DML`, `:NEW`, `:OLD`, `RAISE_APPLICATION_ERROR` | `Customers`, Audit logs |
| **Ex 7** | Normalized Library System | Relational (3NF/BCNF) | Oracle SQL | `IDENTITY`, `FOREIGN KEY`, `ON DELETE CASCADE`, Junction tables | `Authors`, `Books`, `Borrowers`, `BookAuthors` |
| **Ex 8** | PL/SQL Exception Handling | Error Handling | Oracle PL/SQL | `EXCEPTION`, `WHEN OTHERS`, `SQLCODE`, `SQLERRM`, `RAISE` | `Customers`, Exception hierarchy |
| **Ex 9** | Multi-Model NoSQL Systems | Non-Relational NoSQL | Redis, Cassandra, MongoDB, Neo4j | `SET/GET`, `CREATE TABLE`, `insertMany()`, `CREATE ()-[]->()` | Key-Value, Columnar, Doc, Graph |
| **Ex 10** | Document Database CRUD | Document (JSON/BSON) | MongoDB (`mongosh`) | `use`, `insertMany()`, `updateOne()`, `$set`, `find().pretty()`, `deleteOne()` | `authors`, `books`, `borrowers`, `borrowedBooks` |
| **Ex 11** | Cassandra Distributed Cluster | Distributed Columnar | Apache Cassandra | `cassandra.yaml`, `nodetool status`, `CREATE KEYSPACE`, `cqlsh` | `college_ks`, `student` table |
| **Ex 12** | Enterprise Banking System | Enterprise Relational | Oracle SQL & PL/SQL | 6 Foreign Keys, Transaction ledger, 42 analytical queries, DML audit | `Customer`, `Branch`, `Account`, `Bank_Transaction`, `Loan`, `Loan_Payment` |

---

## Execution and Setup Guide

### 1. Oracle SQL & PL/SQL (Exercises 4, 5, 6, 7, 8, 12)

All PL/SQL blocks and relational Oracle scripts can be executed using **Oracle SQL Developer**, **SQL*Plus**, or **Oracle Live SQL**.

```powershell
# Connect to Oracle instance via SQL*Plus
sqlplus username/password@localhost:1521/XEPDB1

# Enable console output buffer for PL/SQL execution
SET SERVEROUTPUT ON;

# Execute any exercise script (example: Experiment 6 Triggers)
@DBMS_Experiment_6_triggers.sql

# Execute the Enterprise Banking System Mini Project
@DBMS_Mini_Project_Banking_System.sql
```

> **Note on PL/SQL Execution:** Ensure `SET SERVEROUTPUT ON;` is executed prior to running PL/SQL blocks so that `DBMS_OUTPUT.PUT_LINE` text is emitted to your console.

---

### 2. MySQL / Relational Queries (Exercises 1, 2, 3)

For MySQL Workbench or the MySQL command-line client:

```powershell
# Connect to MySQL Server
mysql -u root -p

# Execute script file
source d:/DBMS_EXERCISE/DBMS_Experiment_1_Simple_Nested_Subqueries.sql;
source d:/DBMS_EXERCISE/DBMS_Experiment_2_JOIN_Queries.sql;
source d:/DBMS_EXERCISE/DBMS_Experiment_3_View_and_Index.sql;
```

---

### 3. MongoDB Document Database (Exercise 10)

For MongoDB, ensure the `mongod` service is running, then load the script using `mongosh`:

```powershell
# Start MongoDB interactive shell
mongosh

# Load and execute the script inside mongosh
load("d:/DBMS_EXERCISE/DBMS_Experiment_10_mongodb_crud_library.js")

# Or run directly from terminal:
mongosh library "d:/DBMS_EXERCISE/DBMS_Experiment_10_mongodb_crud_library.js"
```

---

### 4. Apache Cassandra Distributed Cluster (Exercise 11)

For Apache Cassandra, configure node IPs in `cassandra.yaml` and interact via `cqlsh`:

```bash
# Start the Cassandra daemon service
sudo service cassandra start

# Check cluster nodes, tokens, and health status
nodetool status

# Launch the interactive CQL shell
cqlsh 192.168.1.10 9042

# Within cqlsh, copy and execute CQL commands or run a script:
cqlsh -f DBMS_Experiment_11_cassandra_cluster_and_cql.txt
```

---

## Learning Outcomes

Upon completing and studying this laboratory curriculum, one will have developed mastery in:
- **Relational Algebra & Set Theory:** Writing complex nested, correlated, and multi-relation join queries with performance awareness.
- **Schema Optimization & Virtualization:** Designing secure views and implementing B-Tree indexes to optimize disk I/O and query execution plans.
- **Procedural Database Engineering:** Building robust PL/SQL packages, parameterized procedures, stored functions, and cursor buffers.
- **Active Rule Governance:** Engineering event-driven database triggers with strict business rule validation and audit trails.
- **Relational Normalization:** Transforming raw unnormalized datasets into 3NF and BCNF compliant schemas to eliminate update anomalies.
- **NoSQL & Polyglot Persistence:** Evaluating architectural trade-offs between ACID relational databases and BASE NoSQL systems (Key-Value, Columnar, Document, Graph).
- **Document Store Data Modeling:** Implementing flexible schema documents, nested sub-documents, and arrays in MongoDB.
- **Distributed Database Systems:** Managing distributed ring topologies, gossip communication, token ownership, and tunable consistency in Apache Cassandra.
- **Full-Scale Enterprise Application:** Modeling, deploying, and maintaining a complete commercial enterprise banking database application.

---

## Author & Academic Purpose

- **Author:** Thamizh Selvan
- **Department:** Computer Science & Engineering
- **Purpose:** Database Management Systems Laboratory coursework, practical exam preparation, technical viva, and engineering portfolio.
- **License:** Open educational and academic use.
