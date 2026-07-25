# 🗄️ Week 06
### Test review
[©](https://creativecommons.org/licenses/by/4.0) [Johnny Chan](mailto:jh.chan@auckland.ac.nz)



## 🕒 Previously ...

- a recap on data modelling
- a recap on SQL

- CTE, TEMP TABLE, VIEW and TRIGGER



## 📌 Agenda

- Test specification

- Test preparation

- Mock test



## Test specification
- T1: this 120-minute Inspera-enabled Canvas online test (18:30 to 20:30 NZST on 2026-08-11) is an individual assessment representing 30% of the course
<!-- .element: style="font-size:90%" -->

- There are 14 questions in total: 2 questions with ERD and 12 questions with SQL, covering **Week 01 to Week 05** of the course. There are two types of question: multiple answer and essay. For multiple answer typed question, you are expected to select a correct number of correct statements. For essay typed question, you are expected to write words or code to answer them. Partial marks are considered in this assessment. For SQL questions, you may be shown with some sample output only to help you understand the required structure for the output. Ignore the data from the sample output
<!-- .element: style="font-size:90%" -->

- The assessment will be delivered in [exam mode D](https://www.auckland.ac.nz/en/students/academic-information/exams-and-final-results/about-exams/exam-mode-d.html) together with Canvas, which means you must use the [Inspera Integrity Browser (IIB)](https://www.auckland.ac.nz/assets/students/academic-information/exams-and-final-results/about-exams/iib-guides-for-practice-exams-mode-d/iib_setup_mode_d.pdf) during the assessment in Canvas and follow all the provided instructions. During the test, you must treat it as if you are doing a mode D exam. Failing to comply would automatically get a zero mark for the test
<!-- .element: style="font-size:90%" -->

Note: It is mandatory to read and understand all the instructions and regulations of exam mode D. If you are in doubt what is allowed and what is not allowed, make sure you have your question asked via the discussion forum before the test


## More specification
- For the SQL statements, they must be fully compatible with SQLite as taught in the course. **Any answer with non-compatible SQL statement would automatically get a zero mark** for that question. You are enouraged to provide relevant assumptions or design decisions to each question for partial marks consideration when the SQL statement submitted is incorrect

- It is **your responsibility** to ensure the test is successfully submitted on time

- This is a restricted open-book test and you are allowed to access any course materials provided by us and notes from yourself during the test. However, you are **not allowed to use any generative AI tool, or any output from any generative AI tool** for this assessment


## More specification
- You are **not allowed to use any search engine and unauthorised material** that are outside the scope of the course for this assessment

- You are **not allowed to copy and paste** when you answer your question without typing them out at least one time

- You are **not allowed to use any additional device** apart from the one with IIB installed (e.g. no smartphone, smart wearable etc)

- You are not expected to use SQLite and related software during the test but you are allowed to use them

- You are **responsible to fully comply** with the [University’s Regulations, Statues and Guidelines](http://www.auckland.ac.nz/uoa/home/about/teaching-learning/honesty/tl-uni-regs-statutes-guidelines); any non-compliance to the given instructions could end up with some heavy penalty



## Test preparation
- The objective of the test is to assess your ability to internalise the shared knowledge from the course into your own understanding, and to develop the needed skillset to drive action and result. But how do you know if or when you are ready for the test?

  - Could you answer all the questions from A1 to A5, lectures and labs without using any resources and tools?

  - Could you comfortably write all the required code in a single SQL statement completely and only by yourself, on a piece of paper?



# 💼 Mock test
### The [Chinook](../case/chinook.html) case


## Background
- The objective of the mock test is to provide a means for you to self-assess your readiness for the test; the mock test questions do not necessarily relate to or reflect on the questions from the test

- The mock test questions and the test questions are based on the Chinook database, which you have experienced before in A5

- No suggested solutions will be provided for the mock test; however you are encouraged to discuss the mock test questions with your peers and the TAs both online and offline before the test

- You are strongly advised to do the mock test at least once as if you were in a test condition (i.e. mode D)



## Q01: Artist and track
- Please answer this question based on the [logical ERD provided](../case/chinook-full.svg)

- Explain how artist and track are related to each other



## Q02: Customer and invoice
- Please answer this question based on the [logical ERD provided](../case/chinook-full.svg)

- Explain the design decision or justification behind having BillingAddress and other address-related attributes in the Invoice table while there are also equivalent attributes in the Customer table



## Q03: Who the F
- Write a single SQL statement to list all the artists that begin their name with the letter F. The output should include all columns from the Artist table


## Sample output
```
ArtistID         Name
---------------  -------------------------------------------------
23               Frank Zappa & Captain Beefheart
39               Fernanda Porto
82               Faith No More
83               Falamansa
84               Foo Fighters
85               Frank Sinatra
86               Funk Como Le Gusta
241              Felix Schmidt, London Symphony Orchestra ...
251              Fretwork
```
<!-- .element: style="font-size:80%" -->



## Q04: Magic twenty-three
- Write a single SQL statement to list all the albums that have an AlbumID divisible by 23. The output should include all columns from the Album table


## Sample output
```
AlbumID  Title                                     ArtistID
-------  ----------------------------------------  --------
23       Minha Historia                            17
46       Supernatural                              59
69       Djavan Ao Vivo - Vol. 02                  80
92       Use Your Illusion II                      88
115      Sex Machine                               91
138      The Song Remains The Same (Disc 2)        22
161      Demorou...                                108
...
```
<!-- .element: style="font-size:80%" -->



## Q05: Order by name
- Write a single SQL statement to list all employee names (each combining the last name and the first name with a comma as separator) from the Employee table. Sort the output by the length of the employee name, with the shortest one to go first in the list


## Sample output
```
Name
-----------------
King, Robert
Adams, Andrew
Peacock, Jane
Edwards, Nancy
Park, Margaret
Johnson, Steve
Callahan, Laura
Mitchell, Michael
```
<!-- .element: style="font-size:80%" -->



## Q06: Fix the sign
- You are told that one employee has a phone number and a fax number stored with a missing + sign at the front, but you do not know which employee has done that. All other employees have their contact numbers starting with the + sign

- Write a single SQL statement without using subquery to update that particular phone number and fax number by adding a + sign at the front



## Q07: Log me in
- Write a single SQL statement to create a new table named Login with five columns: Username (Text), Password (Text), LastUpdate (Date), Status (Text) and CustomerID (Integer)

  - Assign Username as the primary key of the table
  - The Password should never be NULL
  - Set the default value of LastUpdate to the current date and time (NZ time)
  - Define a check on Status to make sure the value could either be 'active' or 'inactive'
  - Assign CustomerID as a foreign key referencing the Customer table



## Q08: Album luxury
- Write a single SQL statement to list albums with two columns: the title of the album, and the price of the album. Exclude albums that are priced lower than thirty dollars from the output. Rename the column headings appropriately, and sort the output by the price in descending order


## Sample output
```
Album                                     Price
----------------------------------------  ------
Greatest Hits                             $56.43
Lost, Season 3                            $51.74
The Office, Season 3                      $49.75
Lost, Season 1                            $49.75
Lost, Season 2                            $47.76
Battlestar Galactica (Classic), Season 1  $47.76
Heroes, Season 1                          $45.77
The Office, Season 2                      $43.78
Battlestar Galactica, Season 3            $37.81
LOST, Season 4                            $33.83
Minha Historia                            $33.66
```
<!-- .element: style="font-size:80%" -->



## Q09: Youngest manager
- Write a single SQL statement to show the first name and the age of an employee who is the youngest manager in the company. The age should be shown as a whole number (i.e. without any decimal places) in the output


## Sample output
```
Name     Age
-------  ---
Michael  52
```
<!-- .element: style="font-size:80%" -->



## Q10: Background music
- Write a single SQL statement to create a new playlist called 'Background music'; and write another single SQL statement to associate the new playlist with the 10 longest duration tracks of jazz music from the Track table



## Q11: AAC
- Write a single SQL statement to generate three rows of information: one row showing the number of tracks formatted in AAC media type, one row showing the number of tracks formatted in non-AAC media type, and one row showing the total number of tracks in the database. There should be two columns in the output: first column is named Media which has the value AAC or non-AAC; second column is named Tracks which shows the total number of tracks


## Sample output
```
Media    Tracks
-------  ------
AAC      255
non-AAC  3248
Total    3503
```
<!-- .element: style="font-size:80%" -->



## Q12: Email provider

- Write a single SQL statement to generate a list with two columns: Provider and Percentage
  - The first column displays email provider in upper cases (e.g. GMAIL, YAHOO), and the information could be obtained from the email of customer. Email from the same provider with different country code (e.g. yahoo.com, yahoo.de, yahoo.ca) should be considered as part of the same email provider (e.g. YAHOO)
  - The second column displays the percentage of customer with two decimal places
  - Only include providers with a percentage of more than 5 in the output
  - Sort the output by Percentage in descending order


## Sample Output
```
Provider  Percentage
--------  ----------
YAHOO     30.51
GMAIL     13.56
APPLE     11.86
HOTMAIL   6.78
SHAW      5.08
```
<!-- .element: style="font-size:80%" -->



## Q13: View the customer

- Write a single SQL statement to create a view named CustomerView. The view should have three columns: Country, Individual and Company
  - The first column includes all the countries found in the Customer table
  - The second column and the third column display the number of individual and company customers in each country respectively
  - Both second and third columns display only whole number
  - A company customer is defined by the presence of value in the column Company of the Customer table; an individual customer is defined by the absence of value in that same column
  - Sort the output by country ascendingly
  - You cannot use OUTER JOIN for this particular task


## Sample output
```
Country         Individual  Company
--------------  ----------  -------
Argentina       1           0
Australia       1           0
Austria         1           0
Belgium         1           0
Brazil          1           4
Canada          6           2
Chile           1           0
Czech Republic  1           1
Denmark         1           0
Finland         1           0
France          5           0
Germany         4           0
...
```
<!-- .element: style="font-size:80%" -->



## Q14: We are so lost
- Write a single SQL statement to create a trigger named UndeleteLostTrack. The objective of this trigger is to cancel the effect of deleting any track from the Track table that associates with LOST the TV show (which could be referenced from the title of an album)
  - The trigger does not stop the deletion; but it cancels its effect by recreating the exact same row or rows of deleted track or tracks
  - The trigger ignores deletion of track that has no association with LOST



## 🗒 Summary
- By now we have gone through:

	- a review of the test specification
	- how to prepare for the test
	- a mock test


## 📝 To do
- Practice more and get yourself ready for the test

- Attend the workshop and go through the trial test (T0)

- Participate in the test (T1) on 2026-08-11 from 18:30-20:30 under mode D


## 📚 Reading
- No reading!


## 🗓 Schedule
Week | Lecture
--- | ---
01 | Introduction ✓
02 | SQL fundamentals ✓
03 | Data modelling ✓
04 | SQL aggregation & subquery ✓
05 | Recap ✓
06 | Test review ✓
07 | Data warehouse
08 | Extract, load & transform
09 | Measure & hierarchy
10 | Course review



# 🌏 THE END
Don't forget information management is awesome!

[🖨](?print-pdf)
