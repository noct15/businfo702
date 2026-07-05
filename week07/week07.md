# 🗄 Week 07
### Data warehouse
[©](https://creativecommons.org/licenses/by/4.0/) [Johnny Chan](mailto:jh.chan@auckland.ac.nz)



## 🕒 Previously on ...

- Test review

- Mock test



## 📌 Agenda

- Data warehouse

- Star schema



## Data warehouse
- A [data warehouse](https://en.wikipedia.org/wiki/Data_warehouse) is a subject-oriented, integrated, time-variant, non-updatable collection of data used in support of management decision-making process

	- Subject-oriented: data is organised around key business subject e.g. customer, patient, student, product
	- Integrated: data from multiple source is transformed to a consistent format and naming convention
	- Time-variant: support the study of trend and change from historical snapshot
	- Non-updatable: read-only and periodically refreshed

- A [data mart](https://en.wikipedia.org/wiki/Data_mart) is a subset of a data warehouse that focuses on a specific business need

Note: A data warehouse is a database designed to support decision‑making in an organisation. It stores large amounts of historical operating data and is usually batch‑updated and structured for rapid online query and managerial summary. Unlike transactional database, a data warehouse prioritises query performance and analytic flexibility over real‑time update; in other words it prioritises SELECT over INSERT, UPDATE and DELETE among the CRUD operations


## Motivation
- Drowning in data but starving for insight!
  - Massive amount of raw transactional data being unutilised or underutilised

- Evidence-based / data-driven decision-making
  - Strategic choice driven by accurate, timely and trustworthy data

- Intense competition for customer's attention
  - Analytics enables personalised engagement and loyalty in a competitive landscape


## Organisational trend
- **Fragmented Data Ecosystem**: Multiple cloud and on‑prem systems with no single source of truth; balanced analysis across business functions (e.g. finance, operation, marketing and supply chain) is needed

- **Customer 360° View**: Unifying purchase history, digital engagement and support interaction

- **Supplier and Partner Integration**: Coordinating supplier performance, compliance and logistics data

- **AI/ML and Predictive Analytics Readiness**: Clean, consistent data required for training reliable model

- **Self‑Service Analytics Culture**: Empowering manager and staff to explore data without IT bottleneck

📚 Further: [Data and AI-driven enterprise of 2030](https://www.mckinsey.com/capabilities/mckinsey-digital/our-insights/charting-a-path-to-the-data-and-ai-driven-enterprise-of-2030)


## Fragmentation
![heterogeneous](heterogeneous.png) <!-- .element: height="600px" -->


## Data warehouse architecture
- Data Source
	- Internal and external

- Data Staging / Cleansing ([ELT](https://en.wikipedia.org/wiki/Extract,_load,_transform) / [ETL](https://en.wikipedia.org/wiki/Extract,_transform,_load))
	- Data extraction
	- Data loading
	- Data transformation

- Data Repository
	- Data warehouse
	- Data mart
	- Operational database

- Data Analytics


## Data warehouse architecture
![DW architecture](dw_architecture.png) <!-- .element: height="600px" -->



## Designing the data warehouse
- There are two types of [dimensional model](https://en.wikipedia.org/wiki/Dimensional_modeling): [star schema](https://en.wikipedia.org/wiki/Star_schema) or [snowflake schema](https://en.wikipedia.org/wiki/Snowflake_schema); both with [dimension table](https://en.wikipedia.org/wiki/Dimension_(data_warehouse)#Dimension_table) surrounding the [fact table](https://en.wikipedia.org/wiki/Fact_table)

- Dimensional modelling does not necessarily involve a relational database. The same modelling approach at the logical level can be used for any physical form, even flat file. It is oriented around understandability and performance

- A star schema consists of the following components:
	- Fact
	- Dimension
	- Attribute
	- Attribute hierarchy


## Star schema
![fact_dimension](fact_dimension.png) <!-- .element: height="600px" -->


## Fact and dimension
- Fact is a numeric measurement or value that represents a specific business aspect or activity

- Dimension qualifies characteristic that provides additional perspective to a given fact

- Fact and dimension tables are normally represented by physical tables in the data warehouse / mart

- Fact table has many-to-one relationship to each dimension and subject to primary key and foreign key constraints


## Example
![sales](sales.png) <!-- .element: height="600px" -->


## Example
![sales_with_data](sales_with_data.png) <!-- .element: height="600px" -->



## Database vs data warehouse

- Database [(OLTP)](https://en.wikipedia.org/wiki/Online_transaction_processing)
	- Design: highly normalised data model to reduce redundancy
	- Time span: represents current transaction
	- Granularity: represents specific transaction thats occur at a given time
	- Dimensionality: focuses on representing atomic transaction

- Data Warehouse [(OLAP)](https://en.wikipedia.org/wiki/Online_analytical_processing)
  - Design: denormalised dimensional model to optimise for read-intensive analytical queries
  - Time span: tends to cover long time frame
  - Granularity: presents at different levels of aggregation
  - Dimensionality: could be analysed from multiple dimensions



## Size of fact table

```txt
Total number of stores = 1000
Total number of products = 10000
Total number of periods = 24 (2 years worth of data)

If on average, 50% of products are sold in any given month:

Total number of rows = 1000 * 5000 * 24 = 120000000
```



## Quiz 01
- In a conversation with the general manager of Johnson and Johnson NZ, he would like you to be involved in their data warehouse project. He describes to you that the basic requirement for the data warehouse is to be able to project the sales of their products to specific customers through a particular channel. And that projection should be based on historical data of the sales

- Draw a simple star schema (with fact and dimension) that captures the requirement of the data warehouse


## Quiz 02
- Draw a star schema based on the following spec:
	- Product (__ProductID__, ProductCode, ProductName, _SubCategory_, Brand, Height, Width)
	- Category (__Category__)
	- SubCategory (__SubCategory__, _Category_)
	- Store (__StoreID__, StoreName, ParentChain, Region, Territory, Zone, Address, City, State, Zip)
	- Sale (___StoreID___, ___ProductID___, __SaleTimestamp__, SaleDollar)
	- 10 years of data with 200 stores and 3000 products on average every single day

- What would be the estimated size of the fact table?



# 💼 Case study
### Book publisher data mart<!-- .slide: data-background="book.png" data-background-transition="zoom" -->


## Background
- Best Book Publisher (BBP) has a business policy to only publish books written by a single author. BBP assigns its agents to supervise the publishing of each book written by an author who resides in the agent's territory


## Database
![](bbp.jpg)


## Specification
- BBP would like to store all the data related to their book transactions in a data warehouse. In order to test the data warehouse technology, BBP will experiment with a pilot data mart that will source its data only from the data modelled in the ERD. BBP wishes to organise the data extracted from the entity sets in the ERD into a data cube so as to facilitate the answering of queries that support decision making

- The pilot data mart will be used to investigate the facts about the quantities of book sold, the value of those sales, and the royalty commissions paid to individual author for that book. BBP would like the grain for time to be one month


## Objective
- Choose the dimensions from those available in the ERD and draw a star schema for the required data mart

- BBP wishes to retain three years of data in the data mart. BBP has a total of 30 sales territories spread over three countries. Each territory has, on average, five agents; and agents are responsible for, on average, in any one month, 20 books each. How many rows, on average, will be retained in the fact table of the data mart?

- What business questions can be asked for new insights?



## 🗒 Summary
- By now you have learnt:

	- the purpose and nature of data warehouse, and how it is different from a database

	- how to design a datawarehouse using star schema


## 📝 To do
- Practice on designing with star schema

- Complete TUT1, TUT2, TUT3 and TUT4 by the deadline

- E-meet with your group members for the project


## 📚 Reading

- Essential
	- [An Overview of Data Warehousing and OLAP Technology](https://rl.talis.com/3/auckland/items/B49F99EF-3D88-156D-AF9C-B8D77961240A.html)


## 🗓 Schedule
Week | Lecture
--- | ---
01 | Introduction ✓
02 | SQL fundamentals ✓
03 | Data modelling ✓
04 | SQL aggregation & subquery ✓
05 | Recap ✓
06 | Test review ✓
07 | Data warehouse ✓
08 | Extract, load & transform
09 | Measure & hierarchy
10 | Course review



# 🌏 THE END
Don't forget information management is awesome!

[🖨](?print-pdf)
