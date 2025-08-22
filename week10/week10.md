# 🗄 Week 10
### Course review
[©](https://creativecommons.org/licenses/by/4.0/) [Johnny Chan](mailto:jh.chan@auckland.ac.nz)



## 🕒 Previously ...

- Measure and hierarchy

- OLAP operations: roll-up, drill-down, slice and dice, pivot



## 📌 Agenda

- Course review

- Beyond



## Course review
Week | Lecture
--- | ---
01 | Introduction ✓
02 | SQL fundamentals ✓
03 | Data modelling ✓
04 | SQL aggregation & subquery ✓
05 | Recap ✓
06 | Test review ✓
07 | Data warehouse ✓
08 | Extract, transform & load ✓
09 | Measure & hierarchy ✓
10 | Course review ✓



## Beyond: API
- An application programming interface (API) is a mechanism by which software can communicate with other software. A Web API is one that allows software to communicate to other software over the web. A [REST](https://en.wikipedia.org/wiki/REST) API is a specific type of Web API which possesses certain qualities that make it easy to use (consume) for different types of software and situations

- A very common use case of API is to provide access to data from a database in a controlled manner

- Most but not all APIs require an API key to access the data

- Example: [MusicBrainz API](https://musicbrainz.org/)
  - A community-maintained open-source database of music metadata
  - [MusicBrainz API documentation](https://musicbrainz.org/doc/MusicBrainz_API)


## MusicBrainz
- All API calls must go to https://musicbrainz.org/ws/2/ the root end-point

- [https://musicbrainz.org/ws/2/artist?query=artist:Gustav%20Holst](https://musicbrainz.org/ws/2/artist?query=artist:Gustav%20Holst)
  - It beings with the root end-point
  - The ? mark indicates the start of the query string in the format of key=value pairs connected by the & symbol
  - How many artists does the search find in total, and how many artists are returned?
  - Add &offset=25 and &limit=100 to the query string and see what happens
  - Add a quote mark to the artist name

- Most REST APIs return data in [XML](https://en.wikipedia.org/wiki/XML) or [JSON](https://en.wikipedia.org/wiki/JSON) formats


## [Steampipe](https://steampipe.io/)
- SELECT * FROM cloud;

- An open-source CLI to instantly query cloud APIs using SQL (the [installation](https://steampipe.io/downloads) could be a bit tricky; follow the instructions carefully)

- Currently there are [140+ data sources / plugins](https://hub.steampipe.io/) available


## Example: Finance
- Use SQL to query financial data from [Yahoo Finance](https://finance.yahoo.com) through Steampipe

  - Install the [plugin](https://hub.steampipe.io/plugins/turbot/finance)
  - Start a Steampipe session, check connection, inspect schema and table
  - Write a SQL statement to list the share prices of the MAG7

```sql
SELECT symbol, timestamp, volume, open, close
FROM finance_quote_daily
WHERE symbol IN ('MSFT', 'AMZN', 'META',
                 'NVDA', 'AAPL', 'GOOGL', 'TSLA')
ORDER BY timestamp DESC, symbol
LIMIT 7;
```


## Example: X
- Use SQL to query the recent tweet from [X](https://x.com) through Steampipe

  - Apply for a [free developer account](https://developer.x.com) from X
  - Install and configure the [plugin](https://hub.steampipe.io/plugins/turbot/twitter)
  - Start a Steampipe session, check connection, inspect schema and table
  - Write a SQL statement to list the recent tweets about Auckland

```sql
SELECT id, text, mentions
FROM twitter_search_recent
WHERE query = '#Auckland';
```


## Example: Bluesky
- Use SQL to query the recent message from [Bluesky](https://bsky.app) through Steampipe

  - Apply for a user account from Bluesky
  - Install and configure the [plugin](https://hub.steampipe.io/plugins/turbot/bluesky)
  - Start a Steampipe session, check connection, inspect schema and table
  - Write a SQL statement to list the recent messages about New Zealand with more than 5 likes

```sql
SELECT author, created_at, like_count, text
FROM bluesky_search_recent
WHERE query IN ('New Zealand', 'NZ')
AND like_count > 5
ORDER BY like_count DESC;
```


## Example: OpenAI
- Use SQL to prompt the model from [OpenAI](https://platform.openai.com) through Steampipe

```sql
SELECT completion
FROM openai_completion
WHERE prompt = 'Write a tagline for a course
                named Information Management';
```


# 📺 Demo
### Steampipe and [SQLite](https://steampipe.io/downloads?install=sqlite)



## Beyond: NoSQL
- A NoSQL database provides a mechanism for storage and retrieval of data which is modelled in means other than tabular relation used in relational database, like key-value pair (e.g. JSON document)

- A NoSQL database may choose to trade consistency for availability and performance
  - some may lack of true [ACID](https://en.wikipedia.org/wiki/ACID) transaction
  - provide "eventual consistency"
  - support real-time analytics on huge amount of data
  - much more adapable and flexible than relational database


## [MongoDB](https://www.mongodb.com/)
- MongoDB is a JSON document-based database management system built on a client-server architecture

- It stores data in databases, collections, documents and fields

- It has its own MongoDB Query Language (MQL) which is based on Javascript

- It is [open source](https://github.com/mongodb/mongo) and adapted by many companies including Adobe, eBay, Foursquare, LinkedIn, McAfee, CERN


# 📺 Demo
### MongoDB [client](https://robomongo.org/) and [server](https://cloud.mongodb.com)



## Beyond: More
- SQL for analytics: [DuckDB](https://duckdb.org/)
- Graph database: [Neo4j](https://neo4j.com/)
- Vector database: [Chroma](https://www.trychroma.com/)



## 🗒 Summary
- By now you have learnt:

	- everything from Week 01 to Week 10 of the course
	- SQL and beyond


## 📝 To do
- Complete the project and submit the report before the deadline
- Submit the individual reflection document before the deadline


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
07 | Data warehouse ✓
08 | Extract, transform & load ✓
09 | Measure & hierarchy ✓
10 | Course review ✓



# 🌏 THE END
Don't forget information management is awesome!

[🖨](?print-pdf)
