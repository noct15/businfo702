# 🗄 Week 03
### Data modelling
[©](https://creativecommons.org/licenses/by/4.0/) [Johnny Chan](mailto:jh.chan@auckland.ac.nz)



## 🕒 Previously ...
- SQL fundamentals
	- CREATE, ALTER and DROP TABLE
	- INSERT, SELECT, UPDATE and DELETE
	- Column alias; data type and literal
	- DISTINCT, LIMIT, OFFSET, ORDER BY, LIKE
	- Operator, single-row function

- SQLite with the book database



## 📌 Agenda
- Data modelling
	- Entity-relationship (ER) modelling
	- ER diagram (ERD)
	- Case study

- SQL with multiple tables
  - INNER JOIN, LEFT OUTER JOIN, CROSS JOIN, SELF JOIN
  - equi vs non equi join
  - explicit vs implicit join notation



## Data modelling
- Data modelling is the _process of creating a data model_ for a given set of data
	- conceptual → logical → physical

- How data are defined, structured and stored would have a _significant implication_ to how they can be accessed and manipulated

- 🤔 What makes a good data model?

- During the stage of physical data modelling it is often necessary to consider the data model’s impact on the efficiency of database operations


## ER model

- The concept is originally defined by [Chen (1976)](https://auckland.rl.talis.com/users/C899F913-6185-B4B9-3892-600310630A5F/bookmarks/946589C7-0C4F-4BD2-C58B-BB29DE416C29.html) which has been adopted and refined by practitioners as the leading method to carry out data modelling

- An ER model is a _systematic way_ of describing and defining a business process. The process is modelled as _entities_ that are linked with each other by _relationships_ that express the dependencies and requirements between them

- An ERD is used as a tool for ER modelling, which also provides a representation of the ER model

- 📚 Further: [ER model from Wikipedia](http://en.wikipedia.org/wiki/Entity%E2%80%93relationship_model)


## Entity
- An __entity__ is an object (abstract or physical)
	- "Interstellar", "Matthew McConaughey"
	- "University of Auckland", "OGG Building"

- Entities are grouped into __entity set__ or entity type / class
	- Movie, Actor
	- University, Building

- An entity set is conventionally named with a singular noun
	- related to business characteristics, meaningful and self-documenting; unique and concise, readable

- 📢 In ER modelling, sometimes an entity set is called an entity, whereas an entity is called an instance


## Relationship

- Two entity sets may be connected in some way. In the ER model this can be expressed as a __relationship__
	- The Movie and Actor entity sets are connected by actors starring in movies. For example, "Interstellar" is connected to "Matthew McConaughey"

- Degree
	- unary, binary, ternary, n-nary

- [Cardinality][c]
	- Multiplicity: one-to-one, one-to-many, many-to-many
	- Optionality: optional or mandatory

[c]: http://en.wikipedia.org/wiki/Cardinality_(data_modeling)


## Conceptual ERD
![conceptual](conceptual.svg)

<small>Figure 3.1: Conceptual ER model of a product management system</small>


## Degree and cardinality
![relationship](relationship.svg)

<small>Figure 3.2: Unary and binary relationships with different cardinalities</small>


## Multiple relationships
![multiple](multiple.svg)

<small>Figure 3.3: Multiple relationships established among two entity sets</small>


## Attribute
- An __attribute__ is a property or a characteristic of an entity set (or a many-to-many relationship)
	- The entity set Actor might be given attributes name, address, gender and birthDate
	- Each entity in the entity set would have values associated with each attribute

- The value of attribute
	- atomic (single-valued) vs multivalued
	- stored vs derived


## Key
- In most cases, an entity can be uniquely identified in its entity set by the values of its attributes
	- A set of attributes whose values uniquely identify an entity in its entity set is called a __key__ or a __candidate key__
	- If there are several candidate keys, we choose one of them as the __primary key__, where its value must not change and must not be [null](https://en.wikipedia.org/wiki/Null_(SQL))

- Example: AUID could be chosen as the primary key for the Student entity set


## ERD with attribute
![attribute](attribute.svg)

<small>Figure 3.4: Conceptual ERD with attribute and key among entity sets and relationships</small>



# 💼 Case study
### An art museum <!-- .slide: data-background="art.jpg" data-background-transition="zoom" -->


## Objective
- Read the specification carefully, then:

	- draw a conceptual ERD to represent the given case study

	- extend the conceptual ERD with attribute


## Specification
- An art museum owns a large volume of <span class="fragment highlight-green">works of art</span>. Each work of art is identified by an <span class="fragment highlight-red">item code</span>. Each work can be described using <span class="fragment highlight-red">a title, the size – composed of height, width and weight</span>. A work of art <span class="fragment highlight-blue">is developed</span> by an <span class="fragment highlight-green">artist</span>. The artist of some works <span class="fragment highlight-blue">is not known</span>. An artist is identified by an <span class="fragment highlight-red">artist number</span> and described by <span class="fragment highlight-red">name, age, gender, dob and dod</span> (null for living artists!). <span class="fragment highlight-blue">Only data about artists for works currently owned by the museum</span> are kept in the database


## More specification
- At any time, an art work is either <span class="fragment highlight-blue">displayed</span> in the museum, <span class="fragment highlight-blue">held in storage</span>, away from the museum as part of a travelling <span class="fragment highlight-green">show</span>, or <span class="fragment highlight-blue">on loan</span> to another <span class="fragment highlight-green">gallery</span>. If on display the <span class="fragment highlight-green">location</span> of the display (in the museum) is noted. A travelling show is described by a <span class="fragment highlight-red">show ID, city</span> in which the show is currently appearing, and the <span class="fragment highlight-red">start and end dates</span> of the show. <span class="fragment highlight-blue">Many of the museum works</span> can be part of a given show. One art work can be displayed in <span class="fragment highlight-blue">many shows</span> over time. These need to be recorded for future analysis. A gallery is described by a <span class="fragment highlight-red">gallery identifier, name and city</span>. The museum wants to retain a history of all works of art loaned to another gallery. The <span class="fragment highlight-red">date loaned and the date returned</span> must be recorded and retained


## The modelling process
- Entity set
	- <!-- .element: class="fragment" -->
	Artwork (__itemCode__, title, height, width, weight)
	- <!-- .element: class="fragment" -->
	Artist (__artistNo__, name, gender, dob, dod)
	- <!-- .element: class="fragment" -->
	Show (__showID__, city, startDate, endDate)
	- <!-- .element: class="fragment" -->
	Gallery (__galleryID__, name, city)
	- <!-- .element: class="fragment" -->
	Location (__locID__, locDesc)

- Relationship
	- <!-- .element: class="fragment" -->
	Artist develops Artwork (optional one to mandatory many)
	- <!-- .element: class="fragment" -->
	Location displays Artwork (optional one to optional many)
	- <!-- .element: class="fragment" -->
	Show stores Artwork (optional many to mandatory many)
	- <!-- .element: class="fragment" -->
	Gallery borrows Artwork (optional many to mandatory many) with loanDate and returnDate


## Conceptual ERD
![art_conceptual](art_conceptual.svg)

<small>Figure 3.5: Conceptual ERD of the art museum case</small>


## ERD with attribute
![art_conceptual_with_attr](art_conceptual_with_attr.svg)

<small>Figure 3.6: Conceptual ERD with attribute for the art museum case</small>



## Conceptual to logical
- [Conceptual data model](https://en.wikipedia.org/wiki/Conceptual_schema)
	- a high-level description of the informational needs of a business
	- it describes the things of significance (entity sets), about which it is inclined to collect information, and characteristics of (attributes) and associations between pairs of those things of significance (relationships)

- [Logical data model](https://en.wikipedia.org/wiki/Logical_data_model)
	- a detailed representation of some or all of an organization's data, independent of any particular database management technology, and described in business language
	- the content is adjusted to achieve certain efficiencies


## Associative entity set
- In logical data modelling, one major task is to resolve __all__ many-to-many relationship in the conceptual data model by converting them to [__associative entity set__](https://en.wikipedia.org/wiki/Associative_entity)

- 🤔 Why is this step necessary?

- An associative entity set is used to represent a relationship which often has its own attribute that do not belong to other entity set

- Each many-to-many relationship would be resolved into two one-to-many relationships with an associative entity set


## Example
![emp_course](emp_course.png)

<small>Figure 3.7: Resolving a binary many-to-many relationship into an associative entity set</small>


## Another example
![bom](bom.svg)

<small>Figure 3.8: Resolving an unary many-to-many relationship into an associative entity set</small>



## Quiz 01
- Draw a logical ERD to represent the following case

	- Each vendor can supply many parts to any number of warehouses but need not supply any parts
	- Each part can be supplied by any number of vendors to more than one warehouse, but each part must be supplied by at least one vendor to a warehouse
	- Each warehouse can be supplied with any number of parts from more than one vendor, but each warehouse must be supplied with at least one part


## Quiz 02
- Revisit the [art museum case study](#/4)

- Draw a logical ERD to represent the case study and list all assumptions made


## Quiz 03
- Modify the logical ERD of the [art museum case study](#/4) from [Quiz 02](#/7) to accommodate one additional requirement:

	- the museum would like to keep track of the history of displaying the works of art in different locations over time, with a start date and an end date recorded



## Physical data modelling
- A [physical data model](http://en.wikipedia.org/wiki/Physical_data_model) is a representation of data design which takes into account the facility and constraint of a given DBMS

- Practically speaking, a physical data model includes the data type of the attribute defined in the logical data model, and sometimes constraint of entity set as well

- Physical data modelling is one step before implementing the relational DBMS with SQL


## Example
![physical](physical.svg)

<small>Figure 3.9: Logical data model vs physical data model</small>


## Consideration
- Derived attribute
	- For the purpose of improving the performance of certain queries, it could be argued to store derived attribute to avoid the ad-hoc computation among large volume of data

- One-to-one relationship to decompose entity set
	- If there is reason beyond data modelling to physically separate some attributes from the same entity set into multiple entity sets (e.g. security), the physical data model should reflect that

- Denormalisation
	- It is not uncommon to reverse the process of normalisation to induce redundancy and eliminate the number of entity set for the purpose of performance and maintenance of the database

- 📢 Consideration must not be taken lightly without strong reasoning



## Join
- If the core rationale behind the relational data model is to break down a complex data structure into a set of smaller relations, then there must be a mechanism to join them back together to support queries

- What is a [join](https://en.wikipedia.org/wiki/Join_(SQL))?
	- It is a mean to combine columns from more than one table
	- Most of the time a join condition is specified
	- It is required to prefix the column name with the table name or table alias when the same column name exists in more than one table


## Example
```sql
SELECT bookCode, w.authorNo, a.authorNo, authorFirstName
FROM Writing w, Author a
WHERE w.authorNo = a.authorNo
AND a.authorNo IN (1,2);
```
```txt
bookCode    authorNo    authorNo    authorFirstName
----------  ----------  ----------  ---------------
110         1           1           De Silva
111         1           1           De Silva
112         2           2           Stevens
```
- Instead of using the full table name, it is easier to use a table alias to differentiate among the same named columns from two or more tables


## Join type
- Inner join
	- It requires each row in the two joined tables to have matching rows
	- Could use either implicit join notation or explicit join notation
	- Equi-join vs non equi-join
- Outer join
	- The joined table retains each row even if no other matching row exists
	- Left outer join always contains all rows of the left table even if the join condition does not find any matching row in the right table
	- No implicit join notation is allowed
	- Right outer join and full outer join are not supported in SQLite
- Cross join / Cartesian join
	- It joins each row of one table to each row of the other table
- Self join
	- It joins a table to itself


## Inner join: equi join
```sql
SELECT bookTitle, authorLastName, pubName, pubDate
FROM Author a, Writing w, Book b, Publisher p
WHERE a.authorNo = w.authorNo
AND b.bookCode = w.bookCode
AND w.pubCode = p.pubCode;
```
```txt
bookTitle           authorLastName  pubName        pubDate
------------------  --------------  -------------  ----------
Far from the Crowd  Clarice         Barclay Books  2006-08-31
A Loud Game         Clarice         Bridgeman Pub  2004-07-13
The Artist          Rob             Chuck Sawyer   2000-01-02
Passage to Freedom  Louis           Chuck Sawyer   2003-03-01
Tornado             Clive           McMillan Publ  2007-06-15
Knockdown           Clive           Metcalf Publi  1972-01-23
Judo                Lisa            Hatfield and   1985-02-24
```
- 🤔 Rewrite the SELECT statement with explicit join notation


## Inner join: non-equi join
```sql
SELECT bookCode, price, bookGrade
FROM BookPrice p, BookGrade g
WHERE price BETWEEN minValue AND maxValue;
```
```txt
bookCode    price       bookGrade
----------  ----------  ----------
110         32.5        Low
111         132.5       High
110         82.5        Medium
112         300.0       Very High
113         47.1        Low
114         98.1        Medium
115         23.45       Very Low
114         56.24       Medium
116         84.5        Medium
```
- 🤔 Rewrite the SELECT statement by replacing bookCode with bookTitle


## Outer join: left outer join
```sql
SELECT authorLastName, bookCode
FROM Author a LEFT OUTER JOIN Writing w
ON a.authorNo = w.authorNo;
```
```txt
authorLastName  bookCode
--------------  ----------
Clarice         110
Clarice         111
Rob             112
Louis           113
Clive           114
Clive           115
Theodora
Lisa            116
Gabriella
Beatrice
Beatrice
```
- When there is no matching bookCode for an author, a NULL is given


## Cross join
```sql
SELECT bookCode, a.authorNo
FROM Writing w, Author a;
```
```txt
bookCode    authorNo
----------  ----------
110         1
111         1
112         1
113         1
114         1
115         1
116         1
110         2
111         2
112         2
113         2
114         2
115         2
116         2
110         3
111         3
112         3
113         3
114         3
115         3
116         3
110         4
111         4
112         4
113         4
114         4
115         4
116         4
110         5
111         5
112         5
113         5
114         5
115         5
116         5
110         6
111         6
112         6
113         6
114         6
115         6
116         6
110         7
111         7
112         7
113         7
114         7
115         7
116         7
110         8
111         8
112         8
113         8
114         8
115         8
116         8
110         9
111         9
112         9
113         9
114         9
115         9
116         9
```
- 📢 Avoid this in most circumstances!


## Self join
```sql
SELECT c.pubName publisher, p.pubName parent
FROM Publisher c, Publisher p
WHERE c.parentPubCode = p.pubCode;
```
```txt
publisher           parent
------------------  --------------------
Chuck Sawyer Books  Bridgeman Publishers
Lake House Books    Bridgeman Publishers
Barclay Books       Bridgeman Publishers
Metcalf Publishers  Chuck Sawyer Books
Hatfield and Sons   Chuck Sawyer Books
McMillan Publishin  Chuck Sawyer Books
```
- 🤔 Rewrite the SELECT statement so that all publishers are listed on the publisher column




## 🗒 Summary
- By now you should:

	- know the vocabulary of the ER model: entity, entity set, relationship, degree, cardinality, attribute, key etc

	- know how to create and interpret a data model from a logical ERD

	- know how to use join in SQL with multiple tables


## 📝 To do
- Practice logical ER modelling with [draw.io](https://app.diagrams.net/)

- Practice all different joins in SQL

- Attend the lab

- Start / Complete TUT2 from Datacamp

- Complete A3 before the deadline


## 📚 Reading
- Essential
	- [Chapter 3: SQL for SQLite](https://rl.talis.com/3/auckland/items/F72D0D88-845F-BBA5-6498-EF2A32C70D90.html)

- Further
	- The ER model
		- [Chen (1976): The Entity-Relationship Model - Toward a Unified View of Data](https://rl.talis.com/3/auckland/items/547FE8A9-8514-9474-8BE5-07D21679666F.html)

	- Crow's foot (Martin) notation
	 	- [Steve (2002): The Details of Conceptual Modelling Notations are Important - A Comparison of Relationship Normative Language (p174-p176)](https://rl.talis.com/3/auckland/items/B0EC459E-D8D0-925D-BDCE-D1882EFFFECD.html)


## 🗓 Schedule
Week | Lecture
--- | ---
01 | Introduction ✓
02 | SQL fundamentals ✓
03 | Data modelling ✓
04 | SQL aggregation & subquery
05 | Recap
06 | Test review
07 | Data warehouse
08 | Extract, load & transform
09 | Measure & hierarchy
10 | Course review



# 🌏 THE END
Don't forget information management is awesome!

[🖨](?print-pdf)



## Existence dependency (bonus)
- __Strong__ entity set
	- exists independent of other entity set
	- has its own unique identifier

- __Weak__ entity set
	- existence dependent on a strong entity set
	- does not have a unique identifier (only a partial identifier)

- The relationship between a strong entity set and a related weak entity set is called an __identifying__ relationship (represented by a solid line), as opposed to __non-identifying__ relationship (represented by a dotted line)


## Identifying relationship
![loan](loan.svg)

<small>Figure 3.10: A strong entity set and a weak entity set with an identifying relationship</small>


## Non-identifying relationship
![loan](loan2.svg)

<small>Figure 3.11: A strong entity set and a strong entity set with a non-identifying relationship</small>



## Enhanced ER modelling (bonus)
- These materials are optional and are for those who are interested in the [__enhanced ER modelling__](https://en.wikipedia.org/wiki/Enhanced_entity%E2%80%93relationship_model) techniques. They could be self-studied at your own pace, and are not required for any of the course assessments.


## Superset and subset
- Sometimes one entity set in an ER model is included in another one, i.e. all entities of one are also entities of another
	- the entity set Employee is included in the entity set Person
	- then Employee is the __subset__ (or subtype/subclass) and Person is the __superset__ (or supertype/superclass)

- Superset: a generic entity set that has a one-to-one relationship with one or more subsets

- Subset: a subgrouping of the entities in an entity set that has __distinct attributes and/or relationships__ among other subsets of the same superset


## Is-a relationship
![emp_superset](emp_superset.svg)

<small>Figure 3.12: The Employee superset with its subsets and is-a relationships</small>


## Inheritance
- Attribute
	- A subset inherits all the attributes from the superset

- Relationship
	- Relationship defined at the superset level indicate that all subsets participate in that relationship as well

- 🤔 Which one is modelled with more details, the superset or the subset?


## Example
![patient_superset](patient_superset.svg)

<small>Figure 3.13: The Patient superset and its subsets</small>


## Specialisation and generalisation
- Specialisation
	- The process of defining one or more subsets from the superset and establishing superset/subset relationships in a top down fashion

- Generalisation
	- The process of defining a more general entity set from a set of more specialised entity sets in a bottom-up fashion


## Specialisation
![part_superset](part_superset.svg)

<small>Figure 3.14: Example of specialisation</small>


## Generalisation
- 🤔 Why does Motorcycle disappear from the generalisation?

![vehicle_superset](vehicle_superset.svg)

<small>Figure 3.15: Example of generalisation</small>


## Completeness and disjointness
- Completeness specifies if an entity of a superset must also be an entity of at least one subset; it indicates if the specialisation is total or partial
	- Total specialisation : Yes | Partial specialisation : No

- Disjointness (or exclusiveness) specifies if an entity of a superset may simultaneously be an entity of two or more subsets
	- Disjoint (exclusive): No | Overlap (inclusive): Yes


## Total specialisation
![patient_total](patient_total.svg)

<small>Figure 3.16: Example of total specialisation</small>


## Partial specialisation
![vehicle_partial](vehicle_partial.svg)

<small>Figure 3.17: Example of partial specialisation</small>


## Disjoint
![patient_disjoint](patient_disjoint.svg)

<small>Figure 3.18: Example of disjoint</small>


## Overlap
![part_overlap](part_overlap.svg)

<small>Figure 3.19: Example of overlap</small>


## Discriminator
- Subset discriminator: an attribute of the superset whose values determine the target subset(s)
- 🤔 What happens when disjoint is replaced by overlap?

![employee_discriminator](employee_discriminator.svg)

<small>Figure 3.20: Example of discriminator</small>


## Quiz 04
![person_superset](person_superset.svg)

<small>Figure 3.21: A superset with 2 levels of subsets</small>


## Questions
1. Could a Person be both a Professional and an Undergrad?
2. Could a Person be both an Alumnus and an Employee, but neither an Academic nor a Professional?
3. Which attribute serves as the discriminator of Person?
4. For Undergrad with an accommodation, the location of that has to be recorded. Explain if any modification to the ERD is needed to achieve that
5. Student could have more than one majors in the undergraduate study. Explain the changes needed in the ERD
6. Suggest if there is an alternative way to model the discriminators of Employee and Student


## The concept of anybody
![anybody](anybody.svg)

<small>Figure 3.22: The anybody structure</small>


# 💼 Case study
### Safari booking system <!-- .slide: data-background="safari.jpg" data-background-transition="zoom" -->


## Objective
- Read the specification carefully, then:

	- draw a logical ERD to represent the given case study, with the design principles in mind

	- apply the concepts from the Enhanced ER model when it is appropriate

	- state any assumption made


## Spec: Background
- Tane du Toit runs safaris in the middle of the North Island of New Zealand. His business is known as Mid-Island Safaris. Tane wishes to create a database to keep track of his customers – both prospective and those who have already booked for a safari. The database stores not only details of customers; it must record information about safaris, the safari trips, and bookings by customers for those safaris. A safari may be attempted only by people who are over the age of fourteen and under the age of seventy-five


## Spec: Customer
- A customer may not have booked for a safari, or may have booked and participated in many safaris. A company or an individual may be a customer – but only individuals are booked into scheduled safari trips. The data to be stored about a customer are as followed:

	- for a company: name, address (first line address, second line address, city, postal code, country) and contact name, email and phone number. A contact may change over time

	- for an individual: first name, last name, address (first line address, second line address, city, postal code, country), email, phone number and date of birth


## Spec: Preference
- A customer’s preferences for time slots during which they wish to travel must be retained in the database. A customer may be able to travel in several time slots during the year. Tane wishes to retain this information so that he can target only those able to participate with publicity for scheduled trips


## Spec: Safari
- A safari has: name, description, duration in days. A safari may be made up of other safaris. For example, the Great North Island Safari includes both the Thermal Area Safari and the East Coast Safari. A safari may be a component of many safaris and one safari may be made up of many safaris

- Usually each safari is scheduled for several time slots in a year. A safari trip is consisted of: date when trip starts, cost in NZ$ (once assigned, the cost will not be changed), maximum number of individuals, and the assigned guide

- A guide has: first name, last name, address (first line address, second line address, city, postal code, country), email, phone number and date of birth. A guide may be assigned to lead many trips over time


## Spec: Booking
- Any customer may make a booking. The date the booking was made must be retained. A booking may have one or many booking items, each item links to an individual who is being booked to a safari trip. The customer making the booking (and who is responsible for payment) may differ from the individuals booked within the items

- A booking is only accepted if accompanied by the full payment for all booking items

- A booking item (of which there may be one or more for a booking) must be for one individual in one safari trip. Thus, for one booking, there may be several items, each of which may be for different, or the same, safari trip


## Safari booking system
![safari](safari.svg)

<small>Figure 3.23: The logical EERD of the Safari booking system</small>


# 💼 Case study
### Jump-a-lot gym database<!-- .slide: data-background="gym.jpg" data-background-transition="zoom" -->


## Background
- Theo Lee, the manager of the Jump-a-lot Gym, wishes to store the details of gym memberships and course payments in a database. You are required to design the logical data model that captures the information in preparation for implementing the application in a relational database. The data that Theo wishes to store are as follow


## Membership
- The gym sells two categories of membership:
  - an individual (i.e. for one person) category
  - an organisation category

- Each of those category must be one of four membership types:
  - one-month membership type
  - three-month membership type
  - six-month membership type
  - twelve-month membership type


## Purchase
- The purchase charge for a membership can differ for each membership type, for each category, and may change over time

- Individuals and organisations purchase a specific type of membership for their respective category

- The gym wishes to store the details about a person who purchases membership: member number, first name, family name, first line of address, second line of address, city, postcode, email address, preferred telephone contact number, date of birth, gender, description of any physical problems

- The data required for an organisation that buys a membership is: member number, organisation name, first line of address, second line of address, city, postcode, email address, preferred telephone contact number. An organisation membership simply allows employees of the organisation to use the gym


## Member
- The member number is a unique number that identifies the member, whether individual or organisation

- A member is an individual or an organisation that has purchased a type of membership. It is important to record when a membership is bought and the type of membership that is bought

- It is planned to retain in the database the details of people and organisations whose memberships have expired, but they must have purchased a membership at least once in order to obtain a member number

- A person or organisation will only become a member when the purchase price is paid. When a membership expires, a new membership must be purchased. Theo wishes to query the database to discover which memberships are close to expiry, so that reminder emails may be sent


## Class
- Only individual members may pay to attend aerobic classes. Classes are held weekly for a term. The details to be stored about an aerobic class are: class code, class description, duration of one class in hours, and the total number of weeks over which that class is held

- The individual is charged one amount for the whole term for the class and the charge may change over time. The enrolment will only be accepted with payment


## Stream
- There may be several streams of a particular class offered concurrently and over time. The details to be stored about a stream are: the stream number which is individual to the class, and the stream start date, and stream start time. Thus several classes may have a stream number one, for example

- Individuals enrol in a stream. The enrolment date needs to be retained in the database for the financial records as individuals must pay on enrolment


## Booking
- Organisations that are members can book the gym for the exclusive use of their staff. The time that may be booked by an organisation are to be stored in the database: day of the week, start time, duration

- The data to be retained about a booking are: unique booking number, date of booking, available time chosen


## Data modelling
- Draw a logical ERD in crow’s foot notation for the case

- Please note: all important design decisions and assumptions made must be clearly 	listed. All entity sets (with specialisation / generalisation as needed), all attributes including primary and foreign keys, and all relationships including cardinalities must be shown as appropriate. Following good database design principle, the ERD should not contain redundant entity sets, relationships or attributes


## Membership management system
![gym-erd](gym-erd.png)
<!-- .element: height="600px" -->

<small>Figure 3.24: The logical EERD of the membership management system</small>


## 🗒 Summary
- By now you should:

	- know the concepts in Enhanced ER model including superset and subset, specialisation and generalisation, and completeness, disjointness and discriminator

	- understand the concept of anybody


## 📚 Reading
- Further

	- [Elmasri et al., (1985): The Category Concept: An Extension to the Entity-Relationship Model](https://auckland.rl.talis.com/users/C899F913-6185-B4B9-3892-600310630A5F/bookmarks/3F9DB0D9-C1FC-7B56-37A9-818B634DAFA4.html)
