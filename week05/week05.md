# 🗄️ Week 05
### Recap
[©](https://creativecommons.org/licenses/by/4.0) [Johnny Chan](mailto:jh.chan@auckland.ac.nz)



## 🕒 Previously ...

- Multi-row function (aggregate function)
- Subquery
- CASE and CAST
- UNION / UNION ALL, INTERSECT and EXCEPT



## 📌 Agenda

- Data modelling recap

- SQL recap
  - Data type
  - Constraint
  - Reshaping with CASE and UNION
  - Subquery

- CTE, TEMP TABLE, VIEW and TRIGGER



## Data modelling recap
- ER model
	- entity, entity set, relationship, attribute, primary key, foreign key
	- degree and cardinality of relationship (multiplicity and optionality)
	- associative entity set
	- conceptual > logical > physical

- ERD
	- crow's foot notation and draw.io


## The data model
ER model ([Chen](https://dl.acm.org/doi/abs/10.1145/320434.320440)) | Relational model ([Codd](https://dl.acm.org/doi/abs/10.1145/362384.362685)) | SQL
--- | --- | ---
entity set | relation | table
entity | tuple | row
attribute | attribute | column
primary key | primary key | primary key
foreign key | foreign key | foreign key


## Foreign key
- In ER modelling, a [foreign key](http://en.wikipedia.org/wiki/Foreign_key) is defined for every relationship. For a typical one-to many, the foreign key stays with the child entity set on the many side, where it references the primary key of the parent/master entity set on the one side

- It is common to rename the foreign key in the child entity set, particularly in an unary relationship

- Allowing null or not for a foreign key specifies if the relationship is mandatory or optional

- If the foreign key becomes part of the primary key in the child entity set, that makes the entity set [weak](../week03/#/11)

- Foreign key = controlled data redundancy


## Referential integrity
- While primary key is an important element to uniquely identify each entity in a set, foreign key is a critical element for representing relationship

- It is the mean to protect [referential integrity](http://en.wikipedia.org/wiki/Referential_integrity)


## One-to-one relationship
![login](login.svg)

<small>Figure 5.1: A binary one-to-one relationship</small>

- 🤔 Why is this not as common as one-to-many or many-to-many?

- 🤔 How should we deal with them?



## SQL recap
- CREATE, ALTER TABLE; INSERT, SELECT, UPDATE, DELETE (CRUD); WHERE
- DISTINCT, ORDER BY, LIMIT, OFFSET, literal and operator
- INNER JOIN (equi vs non-equi), LEFT OUTER JOIN, CROSS JOIN, SELF JOIN
- single-row functions, multi-row functions, subquery; nesting
- CASE, CAST, UNION / UNION ALL, INTERSECT, EXCEPT



## Data type
- In SQLite, each value stored belongs to one of the five data types: INTEGER, REAL, TEXT, BLOB and NULL

- There is no BOOLEAN data type; instead BOOLEAN values are stored as INTEGER literals 0 (FALSE) or 1 (TRUE)

- There are also no real DATE and TIME data types; they are stored as either:

  - TEXT (as 'YYYY-MM-DD' or 'YYYY-MM-DD HH:MM:SS' or 'YYYY-MM-DD HH:MM:SS.SSS' or more)
  - REAL (as Julian day), or
  - INTEGER (as Unix time)

📚 Further: [Data type in SQLite](https://sqlite.org/datatype3.html)



## Constraint
- Data integrity is maintained by constraint. A constraint is a control measure used to restrict the value that can be stored in a column. The database would issue a constraint violation when the restriction is not followed

- These constraints are supported in SQLite:
	- PRIMARY KEY
	- UNIQUE
	- NOT NULL
	- DEFAULT
	- CHECK
	- FOREIGN KEY

- [Column constraint](https://sqlite.org/syntax/column-constraint.html) vs [table constraint](https://sqlite.org/syntax/table-constraint.html)


## PRIMARY KEY
- In SQLite, an INTEGER PRIMARY KEY column is created when a table is created, whether a PRIMARY KEY constraint is explicitly defined or not
	- It is an integer column named [ROWID](https://www.sqlite.org/lang_createtable.html#rowid)
	- If the keyword [AUTOINCREMENT](https://www.sqlite.org/autoinc.html) is used when defining an INTEGER PRIMARY KEY column, the value of that column will never be recycled

- A PRIMARY KEY must be both UNIQUE and NOT NULL*


## UNIQUE
- A UNIQUE constraint requires that all values in a column or a group of columns to be distinct from other

- It is similar to a PRIMARY KEY constraint, except that a single table may have any number of UNIQUE constraints

```sql
CREATE TABLE Contact (
 id INTEGER PRIMARY KEY NOT NULL,
 name TEXT,
 phone TEXT,
 UNIQUE (name,phone)
);
```
<!-- .element: style="font-size:80%" -->
🤔 Is NULL value acceptable to a column declared UNIQUE?


## NOT NULL
- A NOT NULL constraint ensures that value in the column may never be NULL; it could only be attached to a column definition but not specified as a table constraint

	- INSERT statement may not add NULL to the column
	- UPDATE statement may not change existing value to NULL

- Attempting to set the value to NULL in these operations causes a constraint violation

🤔 How does the NOT NULL constraint in SQL relate to data modelling?


## DEFAULT

- A DEFAULT constraint prevents the absence of a value by specifying a default value for a column; the default value of any column is always NULL unless a DEFAULT constraint is defined

- In SQLite, the default value specified in a DEFAULT constraint could be a literal or the output of a function:
	- DATE('now', 'localtime')
	- TIME('now', 'localtime', 'subsec')

- A DEFAULT constraint could be used together with a NOT NULL constraint

```sql
CREATE TABLE MyTime (
 id INTEGER PRIMARY KEY NOT NULL,
 mytime DATE NOT NULL DEFAULT (DATETIME('now', 'localtime'))
);

```
<!-- .element: style="font-size:80%" -->


## CHECK
- A CHECK constraint allows expression to be defined to test values whenever an INSERT or UPDATE statement is run against a column of a table

- Example: We could use a CHECK constraint to restrict the length of a particular column:

```sql
CREATE TABLE Contact (
id INTEGER PRIMARY KEY NOT NULL,
name TEXT,
phone TEXT CHECK (LENGTH(phone)>=7)
);
```
<!-- .element: style="font-size:80%" -->


## FOREIGN KEY
- A FOREIGN KEY constraint ensures that where a key value in one table logically refers to data in another table, the data in the other table actually exists; it protects the referential integrity by enforcing the relationships between tables

```sql
CREATE TABLE BookPrice
(bookCode INTEGER NOT NULL,
 startDate DATE NOT NULL,
 endDate DATE,
 price REAL,
 PRIMARY KEY (bookCode, startDate),
 FOREIGN KEY (bookCode) REFERENCES Book (bookCode)
 ON UPDATE NO ACTION ON DELETE NO ACTION
);
```
<!-- .element: style="font-size:80%" -->


## Integrity action
- In the occasion of an UPDATE or DELETE of a parent row that may impact the associated child rows, the integrity action specifies what should happen:

	- NO ACTION
	- RESTRICT
	- SET NULL
	- SET DEFAULT
	- CASCADE

- The default integrity action is NO ACTION which would issue a constraint violation as it happens


## Referential integrity in SQLite
- By default, SQLite has turned off the support of referential integrity which means the foreign key constraint would not work properly. To turn it on, the following command must be executed at the beginning of the database session:

```
sqlite> PRAGMA foreign_keys = ON;

```

📚 Further: [Foreign key support in SQLite](https://www.sqlite.org/foreignkeys.html)


## Quiz 01
- Given a Dept table with two columns (ID and name) exists, create a table called Emp with the following specifications:

	- 5 columns: ID, name, startDate, email and deptID
	- ID should be defined as an INTEGER PRIMARY KEY
	- no NULL values for name, startDate and deptID
	- the default value of startDate is the current timestamp
	- email should be UNIQUE and must have a ‘@’
	- define a FOREIGN KEY constraint on deptID that supports cascade update and restrict delete



## Reshaping data
- Also known as pivoting and transposing data*
- Consider the following SQL statement showing the sale record of books:
```sql
SELECT bookCode, STRFTIME('%m',transactionDate) month, quantity
FROM Inventory
WHERE transactionTypeID = 1;
```
<!-- .element: style="font-size:80%" --><!-- .element: contenteditable="true" -->

```
┌──────────┬───────┬──────────┐
│ bookCode │ month │ quantity │
├──────────┼───────┼──────────┤
│ 110      │ 08    │ 100      │
│ 111      │ 08    │ 90       │
│ 112      │ 08    │ 100      │
│ 112      │ 07    │ 156      │
│ 114      │ 07    │ 40       │
│ 114      │ 07    │ 2        │
│ ...      │       │          │
└──────────┴───────┴──────────┘
```
<!-- .element: style="font-size:80%" -->


## Reshaping with CASE
```sql
SELECT bookCode,
SUM(CASE WHEN month = '07' THEN quantity ELSE 0 END) 'July',
SUM(CASE WHEN month = '08' THEN quantity ELSE 0 END) 'August'
FROM (SELECT bookCode, STRFTIME('%m',transactionDate) month, quantity
FROM Inventory
WHERE transactionTypeID = 1) t
GROUP BY bookCode
```
<!-- .element: style="font-size:80%" --><!-- .element: contenteditable="true" -->

```
┌──────────┬──────┬────────┐
│ bookCode │ July │ August │
├──────────┼──────┼────────┤
│ 110      │ 0    │ 100    │
│ 111      │ 0    │ 90     │
│ 112      │ 156  │ 100    │
│ 114      │ 47   │ 23     │
│ 116      │ 2    │ 4      │
└──────────┴──────┴────────┘
```
<!-- .element: style="font-size:80%" -->


## CASE and UNION ALL
```sql
SELECT bookCode,
SUM(CASE WHEN month = '07' THEN quantity ELSE 0 END) 'July',
SUM(CASE WHEN month = '08' THEN quantity ELSE 0 END) 'August'
FROM (SELECT bookCode, STRFTIME('%m',transactionDate) month, quantity
FROM Inventory
WHERE transactionTypeID = 1) t
GROUP BY bookCode
UNION ALL
SELECT 'total' bookCode,
SUM(CASE WHEN month = '07' THEN quantity ELSE 0 END) 'July',
SUM(CASE WHEN month = '08' THEN quantity ELSE 0 END) 'August'
FROM (SELECT bookCode, STRFTIME('%m',transactionDate) month, quantity
FROM Inventory
WHERE transactionTypeID = 1) t;
```
<!-- .element: style="font-size:80%" --><!-- .element: contenteditable="true" -->
```
┌──────────┬──────┬────────┐
│ bookCode │ July │ August │
├──────────┼──────┼────────┤
│ 110      │ 0    │ 100    │
│ 111      │ 0    │ 90     │
│ 112      │ 156  │ 100    │
│ 114      │ 47   │ 23     │
│ 116      │ 2    │ 4      │
│ total    │ 205  │ 317    │
└──────────┴──────┴────────┘
```
<!-- .element: style="font-size:70%" -->



## Subquery
- There are two ways of composing subquery: uncorrelated vs correlated
- Write a single SQL statement to project 4 columns: staffCode, roleID, salary and roleAvgSalary. The roleAvgSalary is calculated by averaging the salaries of all staff from the same role

```
┌───────────┬────────┬─────────┬───────────────┐
│ staffCode │ roleID │ salary  │ roleAvgSalary │
├───────────┼────────┼─────────┼───────────────┤
│ 1         │ 1      │ 72000.0 │ 58750.0       │
│ 2         │ 1      │ 64000.0 │ 58750.0       │
│ 3         │ 1      │ 45000.0 │ 58750.0       │
│ 4         │ 1      │ 54000.0 │ 58750.0       │
│ 5         │ 2      │ 48000.0 │ 40750.0       │
│ 6         │ 2      │ 35000.0 │ 40750.0       │
│ 7         │ 2      │ 40000.0 │ 40750.0       │
│ 8         │ 2      │ 40000.0 │ 40750.0       │
│ 9         │ 3      │ 45000.0 │ 47500.0       │
│ 10        │ 3      │ 50000.0 │ 47500.0       │
│ 11        │ 3      │ 45000.0 │ 47500.0       │
│ 12        │ 3      │ 50000.0 │ 47500.0       │
└───────────┴────────┴─────────┴───────────────┘
```
<!-- .element: style="font-size:80%" -->
Note: Correlated subquery is not assessed in the assignment nor the test


## Uncorrelated subquery
- An uncorrelated subquery is a query that is independent from the main query; often they are executed only once

```sql
SELECT staffCode, sa.roleID, salary, roleAvgSalary
FROM StaffAssignment sa JOIN
    (SELECT roleID, AVG(salary) roleAvgSalary
        FROM StaffAssignment
        GROUP BY roleID) t
ON sa.roleID = t.roleID;
```
<!-- .element: style="font-size:80%" -->


## Correlated subquery
- A correlated subquery is a subquery that contains expression(s) from the main query; often they are run once per row from the main query

```sql
SELECT staffCode, roleID, salary,
(SELECT AVG(salary) FROM StaffAssignment s
    WHERE m.roleID = s.roleID) roleAvgSalary
FROM StaffAssignment m;
```
<!-- .element: style="font-size:80%" -->


## Correlated subquery with EXISTS
- The EXISTS operator can be used to check if a given subquery has any result

```sql
SELECT *
FROM BookPrice m
WHERE NOT EXISTS(SELECT * FROM BookPrice s
                    WHERE m.bookCode = s.bookCode
                    AND s.startDate > m.startDate)
ORDER BY bookCode;
```
<!-- .element: style="font-size:80%" -->
- 🤔 Rewrite this SQL statement with an uncorrelated subquery instead



## CTE and TEMP TABLE
- Common table expression (CTE) and temporary table are temporary storage of data
  - a CTE lasts for the duration of one single SQL statement
  - a temporary table lasts for the duration of one database session

```sql
WITH BookSaleCTE AS
(SELECT bookCode, STRFTIME('%m',transactionDate) month, quantity
FROM Inventory
WHERE transactionTypeID = 1)
SELECT * FROM BookSaleCTE;

CREATE TEMP TABLE BookSaleTemp AS
SELECT bookCode, STRFTIME('%m',transactionDate) month, quantity
FROM Inventory
WHERE transactionTypeID = 1;
SELECT * FROM BookSaleTemp;
```
<!-- .element: style="font-size:80%" -->


## VIEW
- View behaves like a derived table since its content is derived from the result of a SELECT statement; table is persistent, but view is dynamically generated

- In SQLite, view is read-only

```sql
CREATE VIEW LatestBookPrice AS
SELECT p1.bookCode, p1.startDate, endDate, price
FROM BookPrice p1,
   (SELECT bookCode, MAX(startDate) startDate
    FROM BookPrice
    GROUP BY bookCode) p2
WHERE p1.bookCode = p2.bookCode
AND p1.startDate = p2.startDate;

DROP VIEW LatestBookPrice;

```
<!-- .element: style="font-size:80%" -->

- 🤔 What is the advantage of using a view?


## TRIGGER
- A trigger executes specific SQL statement when certain event occurs
	- BEFORE or AFTER for table; INSTEAD OF for view
	- INSERT, DELETE, UPDATE or UPDATE OF column ON table or view
	- WHEN clause (optional); OLD or NEW reference

```sql
CREATE TABLE Log(x);

CREATE TRIGGER InsertBookLog AFTER INSERT ON BOOK
BEGIN
	INSERT INTO Log VALUES(
	'insert book: title= ' || NEW.bookTitle ||
	' on ' || DATETIME('now', 'localtime')
	);
END;

INSERT INTO Book VALUES(888,'Johnny is the King','HOR','Y');

DROP TRIGGER InsertBookLog;
```
<!-- .element: style="font-size:80%" -->



## Final words about SQL
- Less code, less bug
  - Always try to minimise the amount of code and function call; refactor your code; aim to write a single SQL statement to accomplish a task if possible

- Filter your data
  - Use WHERE, DISTINCT and LIMIT when exploring a dataset; use WHERE in all UPDATE and DELETE operations

- Join with purpose
  - Do not join tables in a SQL statement unless there is a reason behind



## 🗒 Summary
- By now we have gone through:

	- a recap on data modelling

	- a recap on SQL

	- CTE, TEMP TABLE, VIEW and TRIGGER


## 📝 To do
- Practice, practice and practice

- Attend the lab

- Start / Complete TUT4 from Datacamp

- Download and explore the [Chinook](../case/chinook.sql) database; complete A5 before the deadline


## 📚 Reading
- Essential
	- [Chapter 4: Advanced SQL for SQLite](https://rl.talis.com/3/auckland/items/F72D0D88-845F-BBA5-6498-EF2A32C70D90.html)

- Further
	- [Data type in SQLite](https://www.sqlite.org/datatype3.html)
	- [Column constraint](https://sqlite.org/syntax/column-constraint.html) and [table constraint](https://sqlite.org/syntax/table-constraint.html) in SQLite
	- [Foreign key support in SQLite](https://www.sqlite.org/foreignkeys.html)
	- [CTE in SQLite](https://sqlite.org/lang_with.html)
	- [View in SQLite](https://www.sqlite.org/lang_createview.html)
	- [Trigger in SQLite](https://www.sqlite.org/lang_createtrigger.html)


## 🗓 Schedule
Week | Lecture
--- | ---
01 | Introduction ✓
02 | SQL fundamentals ✓
03 | Data modelling ✓
04 | SQL aggregation & subquery ✓
05 | Recap ✓
06 | Test review
07 | Data warehouse
08 | Extract, load & transform
09 | Measure & hierarchy
10 | Course review



# 🌏 THE END
Don't forget information management is awesome!

[🖨](?print-pdf)
