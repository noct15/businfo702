# 🗄️ Week 04
### SQL aggregation & subquery
[©](https://creativecommons.org/licenses/by/4.0) [Johnny Chan](mailto:jh.chan@auckland.ac.nz)



## 🕒 Previously ...

- Data modelling
  - ER model: entity, entity set, relationship, degree, cardinality, attribute, primary key and foreign key
  - how to create and interpret a data model from a logical ERD

- SQL
  - INNER JOIN, LEFT OUTER JOIN, CROSS JOIN, SELF JOIN
  - equi vs non equi join
  - explicit vs implicit join notation



## 📌 Agenda

- Multi-row function (aggregate function)

- Subquery

- Expression
  - CASE and CAST

- Relational operation
  - UNION / UNION ALL, INTERSECT, EXCEPT



## Multi-row function
- Work on multiple rows to give one result per group

- Also known as group or aggregate function


## Multi-row function
Function | Description
--- | ---
COUNT(X) or COUNT(\*) | The COUNT(X) function returns a count of the number of times that X is not NULL in a group. The COUNT(*) function (with no arguments) returns the total number of rows in the group
MAX(X) | It returns the maximum value of all values in the group
MIN(X) | It returns the minimum value of all values in the group
AVG(X) | It returns the average value of all values in the group
SUM(X) or TOTAL(X) | It returns sum of all non-NULL values in the group
GROUP_CONCAT(X,Y) | It returns a string which is the concatenation of all non-NULL values of X. If parameter Y is present then it is used as the separator between instances of X


## GROUP BY clause
- Often the intention of using multi-row function is to apply them to selected group, where the group is defined by the data
	- e.g. Write a SELECT statement to list all the cities from the Staff table and the number of staff living in each city

- The GROUP BY clause allows a multi-row function to be used on each group specified

- All columns in the SELECT statement that are not associated with the multi-row function MUST be placed in the GROUP BY clause

- A SELECT statement with a GROUP BY clause but without any multi-row function would be functionally equivalent to DISTINCT


## Example
```sql
SELECT staffCity city, COUNT(staffCity) '# of staff'
FROM Staff
GROUP BY staffCity;
```
```txt
city        # of staff
----------  ----------
Auckland    7
Dunedin     1
Hamilton    1
Manukau     1
Nelson      1
Westland    1
```


## Another example
```sql
SELECT roleID, AVG(salary)
FROM StaffAssignment
GROUP BY roleID;
```
```
roleID      AVG(salary)
----------  -----------
1           58750.0
2           40750.0
3           47500.0
```


## HAVING clause
- The HAVING clause is used to filter the result from a SELECT statement with a multi-row function and a GROUP BY clause

```sql
SELECT branchNo, AVG(salary)
FROM StaffAssignment
GROUP BY branchNo
HAVING AVG(salary) > 54000;
```
```txt
branchNo    AVG(salary)
----------  -----------
1           55000.0
```

- 🤔 How is HAVING different from WHERE in SQL?


## Quiz 01
- Write a SELECT statement to show the number of books transacted per branch



## Subquery
- Who has a higher salary than Jones?
	- Main query: staff with a higher salary than Jones
	- Subquery: Jone’s salary

- Similar to nested function, using subquery in SQL is a technique to combine multiple queries into one. The subquery executes before the main query, and the result of the subquery is used to solve the main query

- Enclose subquery in parentheses

- Use single-row operator with single-row subquery; and multi-row operator with multi-row subquery

- For a SELECT statement, subquery can be used within the SELECT, FROM, WHERE and/or HAVING clauses


## Subquery with WHERE
```sql
SELECT staffLastName, salary
FROM Staff s, StaffAssignment sa
WHERE s.staffCode = sa.staffCode
AND salary > (SELECT salary
	FROM Staff s, StaffAssignment sa
	WHERE s.staffCode = sa.staffCode
	AND LOWER(staffLastName) = 'jones');
```
<!-- .element: style="font-size:80%" -->

```txt
staffLastName  salary
-------------  ----------
Gupta          72000.0
Marks          64000.0
Spencer        45000.0
McDonald       54000.0
Todd           48000.0
Henderson      40000.0
Tawa           40000.0
Hewage         45000.0
Pikes          50000.0
Cruise         45000.0
Schindler      50000.0
```
<!-- .element: style="font-size:80%" -->


## Single-row subquery
- Who gets the highest paid?

```sql
SELECT staffLastName
FROM Staff s, StaffAssignment sa
WHERE s.staffCode = sa.staffCode
AND salary = (SELECT MAX(salary)
 FROM StaffAssignment);
```
```txt
staffLastName
-------------
Gupta
```


## Multi-row subquery
```sql
SELECT staffLastName FROM Staff
WHERE staffCode IN
 (SELECT staffCode FROM StaffAssignment
	WHERE salary >
	 (SELECT MIN(salary) FROM StaffAssignment
	  WHERE roleID = 1));
```
```txt
staffLastName
-------------
Gupta
Marks
McDonald
Todd
Pikes
Schindler
```
- 🤔 What is the question of this query?


## Subquery with HAVING
```sql
SELECT branchNo, MIN(salary)
FROM StaffAssignment
GROUP BY branchNo
HAVING MIN(salary) >
 (SELECT MIN(salary) FROM StaffAssignment);
```
```txt
branchNo    MIN(salary)
----------  -----------
1           45000.0
3           40000.0
4           40000.0
```


## Quiz 02
- Write a single SQL statement to list all the staff members who have either the same role or same salary as Sean Henderson (staffCode = 7). The query should have 4 columns: staffCode, branchNo, roleID and salary, and it should exclude Sean Henderson from the result


## Quiz 03
- Write a single SQL statement to list all the staff members who have been assigned/hired with the three earliest start dates


## Subquery with FROM
- Subquery could also be used as a table in the FROM clause, which could participate in join just like any table

```sql
SELECT MIN(avgSalary)
FROM
 (SELECT branchNo, AVG(salary) avgSalary
  FROM StaffAssignment
	GROUP BY branchNo) t;
```
```txt
MIN(avgSalary)
----------------
43333.3333333333

```


## Quiz 04
- Write a single SQL statement to list all the books in stock. There should be two columns: book title and the total in stock (Hint: The total in stock can be calculated by the total received minus the total sold)


## Subquery with UPDATE and DELETE
```sql
UPDATE StaffAssignment
SET salary = (SELECT salary FROM StaffAssignment
	          WHERE staffCode = 7)
WHERE salary = (SELECT MIN(salary) FROM StaffAssignment);
```

```sql
DELETE FROM BookPrice
WHERE bookCode = (SELECT bookCode FROM Book
	              WHERE bookTitle = 'Secrets');

```



## CASE expression
- A CASE expression works like a IF-THEN-ELSE in other programming languages; it allows us to do different things on each row of a SELECT statement based on the value of a column

```sql
SELECT staffCode, role, salary, CASE
WHEN LOWER(role) = 'branch manager' THEN salary*0.9
WHEN LOWER(role) = 'sales person' THEN salary
WHEN LOWER(role) = 'office admin' THEN salary*1.15
END revisedSalary
FROM StaffAssignment s, Role r
WHERE s.roleID = r.roleID;

```


## CAST expression
- A CAST expression is used to convert data from one type to another

```sql
SELECT staffCode, CAST(salary AS INTEGER) salary
FROM StaffAssignment;
```
```txt
staffCode   salary
----------  ----------
1           72000
2           64000
3           45000
4           54000
5           48000
...
```

- It is useful when we need a certain typed value as input to a function


## Quiz 05
- Write a single SQL statement to list all rows from the StaffAssignment table with the columns staffCode and startDate; but instead of displaying the date you convert that into a day (i.e. Monday, Tuesday etc) using the appropriate function and expression



## Relational operation
- The concept of relational operation is to take one or more relations as input and produce a relation as output! This allows relational operations to be nested together (i.e. subquery)

- The SELECT statement in SQLite supports all relational operations defined in ANSI SQL (which map to the original relational operators defined by Codd) with the exception of right and full outer joins

- In SQLite, these relational operations support compound SELECT statement:

	- UNION / UNION ALL
	- INTERSECT
	- EXCEPT


## UNION / UNION ALL
- UNION is considered to be a fundamental relational operation. It combines the result of two SELECT statements into one, given they have the exact same projection of column

- Duplicated rows would be omitted and shown only once in UNION; all rows would be shown as they are in UNION ALL*
	- A NULL value is considered equal to other NULL value, and distinct from all non-NULL values

- There could only be one ORDER BY clause for a UNION or UNION ALL

```sql
SELECT * FROM Book
WHERE UPPER(bookType) = 'HOR'
UNION
SELECT * FROM Book
WHERE UPPER(paperback) = 'Y'
ORDER BY bookCode;
```
<!-- .element: contenteditable="true" -->

Note: UNION ALL does not change the row order from the outputs of both queries; if the use case is to add an additional last row to an output then using UNION ALL could be more appropriate


## INTERSECT
- INTERSECT behaves similarly to UNION, but instead of showing the non-duplicating rows from the two SELECT statements, it shows only the duplicating rows in the result (but not in duplication)

```sql
SELECT * FROM Book
WHERE UPPER(bookType) = 'HOR'
INTERSECT
SELECT * FROM Book
WHERE UPPER(paperback) = 'Y'
ORDER BY bookCode;
```
```txt
bookCode    bookTitle   bookType    paperback
----------  ----------  ----------  ----------
116         Judo        HOR         Y

```


## EXCEPT
- EXCEPT works similarly to UNION; it shows the rows resulted from the first SELECT statement but not the second one. Therefore unlike other relational operation, the order of the two SELECT statements matter

```sql
SELECT * FROM Book
WHERE UPPER(bookType) = 'HOR'
EXCEPT
SELECT * FROM Book
WHERE UPPER(paperback) = 'Y'
ORDER BY bookCode;
```
```txt
bookCode    bookTitle           bookType    paperback
----------  ------------------  ----------  ----------
113         Passage to Freedom  HOR         N
```



## 🗒 Summary
- By now you have learnt:

	- how to use multi-row function

	- how to use subquery

	- how to use CASE and CAST

	- how to use UNION / UNION ALL, INTERSECT, EXCEPT


## 📝 To do
- Practice multi-row function, subquery, CASE, CAST, UNION / UNION ALL, INTERSECT and EXCEPT in SQL

- Attend the lab

- Start / Complete TUT3 from Datacamp

- Complete A4 before the deadline


## 📚 Reading
- Essential
	- [Chapter 3: SQL for SQLite](https://rl.talis.com/3/auckland/items/F72D0D88-845F-BBA5-6498-EF2A32C70D90.html)

- Further
	- [Aggregate function in SQLite](http://www.sqlite.org/lang_aggfunc.html)


## 🗓 Schedule
Week | Lecture
--- | ---
01 | Introduction ✓
02 | SQL fundamentals ✓
03 | Data modelling ✓
04 | SQL aggregation & subquery ✓
05 | Recap
06 | Test review
07 | Data warehouse
08 | Extract, load & transform
09 | Measure & hierarchy
10 | Course review



# 🌏 THE END
Don't forget information management is awesome!

[🖨](?print-pdf)
