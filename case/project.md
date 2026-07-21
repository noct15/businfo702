# 💼 Project
### Data warehouse and analytics
[©](https://creativecommons.org/licenses/by/4.0/) [Johnny Chan](mailto:jh.chan@auckland.ac.nz) | 🗓 2026-07-21



## Objective
- The objective of the project is for you to achieve all [learning outcomes](https://study.auckland.ac.nz/ords/r/uoa/catalogue/course?p6_code=BUSINFO%20702)

- In attempting and completing this group assessment, you will:
  - design a dimensional data model with star schema to implement a data warehouse / data mart
  - experience sourcing real and raw data
  - understand how to extract data from an operational database
  - demonstrate the skill required to load and transform data
  - compose SQL statement for analytical purpose to discover new insight
  - explore and analyse data in the context of important global and societal issue such as sustainability and equity


## Theme
- **Supporting a sustainable and equitable future through data-driven citizenship** is the overarching theme for the project, with a focus on sustainability and just, ethical and equitable society. This involves understanding how data can inform practice and policy for a better future, and you are encouraged to explore publicly accessible datasets that reveal societal dynamics, biases, and inequalities. For example, projects aligned with this theme might investigate how biases in data can lead to unintended consequence for certain minority groups and/or trends in sustainability

- However, you may also choose to propose *any theme and topic that you and your group might find compelling to work on*, as long as they involve publicly accessible datasets and interesting questions that may lead us towards new insights. We will review this during the project proposal phase

- Your project must integrate data from **at least three distinct publicly accessible datasets** of similar scope and complexity to the sample datasets provided below. The datasets should be related to a common theme and capable of being integrated into the data model to support your proposed research questions



## Sample dataset
- The following datasets align with the project theme; your group could choose to use them or not for the project

| Name                                              | Type | Source                                                                                                                                   |
|---------------------------------------------------|------|----------------------------------------------------------------------------------------------------------------------------------------|
| Climate Change: Earth Surface Temperature Data    | CSV  | [Kaggle](https://www.kaggle.com/datasets/berkeleyearth/climate-change-earth-surface-temperature-data)                                    |
| Country Statistics                                | CSV  | [Kaggle](https://www.kaggle.com/sudalairajkumar/undata-country-profiles)                                                                 |
| COVID-19 General Statistics                       | CSV  | [Kaggle](https://www.kaggle.com/sudalairajkumar/novel-corona-virus-2019-dataset)                                                         |
| COVID-19 Vaccinations                             | CSV  | [Kaggle](https://www.kaggle.com/gpreda/covid-world-vaccination-progress)                                                                 |
| Global Trends in Mental Health Disorder           | CSV  | [Kaggle](https://www.kaggle.com/datasets/thedevastator/uncover-global-trends-in-mental-health-disorder)                                  |
| Data Science for Good: PASSNYC                    | CSV  | [Kaggle](https://www.kaggle.com/datasets/passnyc/data-science-for-good)                                                                  |
| Demographics and Employment in the United States  | CSV  | [Kaggle](https://www.kaggle.com/datasets/econdata/demographics-and-employment-in-the-united-states)                                      |
| World Air Quality Index by City and Coordinates   | CSV  | [Kaggle](https://www.kaggle.com/datasets/adityaramachandran27/world-air-quality-index-by-city-and-coordinates)                           |
| World University Rankings                         | CSV  | [Kaggle](https://www.kaggle.com/mylesoneill/world-university-rankings)                                                                   |
| Suicide Rates Overview                            | CSV  | [Kaggle](https://www.kaggle.com/datasets/russellyates88/suicide-rates-overview-1985-to-2016)                                             |
<!-- .element: style="font-size:90%" -->



## Submission
- **Project proposal (3%)**: Submit a single document in PDF format per group containing your project proposal to Canvas before the deadline. Attach the links to the publicly accessible datasets and / or the data files (e.g. Google Drive) when needed. You must follow the project proposal template from Canvas

- **Project report (25%)**: Submit a single document in PDF format per group containing all the contents of your project to Canvas before the deadline. Attach the links to your SQLite data warehouse and any other relevant artefact (e.g. Google Drive). You must follow the project report requirement

- **Project individual reflection (2%)**: Submit a single document in PDF format per student containing self reflection on the project and an assessment of contribution from each member of the group to Canvas before the deadline. You must follow the project individual reflection template from Canvas



## Project report requirement
- Executive summary (1.5%)
  - A concise half-page summary written for business stakeholder outlining the project's goals, data sources, questions, and key insights derived

- Research question (2%)
  - Based on the chosen datasets, come up with a minimum of 3 research questions that potentially could only be answered from your project
  - The question must be analytical by nature, aiming to discover new insight
  - Provide as much background information as needed to highlight the importance of the question


## Project report requirement
- Star schema design (5%)
  - Design a dimensional data model using star schema
  - Use [draw.io](https://draw.io) (or [mermaid.js](https://mermaid.js.org)) to clearly illustrate the star schema
  - The star schema must have at least 3 dimension tables and 2 attribute hierarchies
  - Provide explanation on how the data from the chosen datasets relate to the star schema

- ELT implementation in SQLite (8%)
  - Extract: Provide detail on how the data is extracted
  - Load: Describe and demonstrate the data import procedure involved to load data to SQLite
  - Transform: Explain and demonstrate transformation for the: i) fact table, ii) time dimension, iii) attribute hierarchy, and iv) all other relevant dimension and measure derived from the loaded data
  - You are expected to include all SQLite commands and SQL statements you have used


## Project report requirement
- SQL for business analytics (6%)
  - Write and execute a minimum of 3 SQL statements to answer the proposed research questions
  - Provide comment and explanation for each SQL statement

- Insight and future work (2%)
  - Briefly discuss key finding and insight derived from your analysis
  - Suggest further work and improvement

- Overall consideration (0.5%)
  - The project has sufficient complexity and appeal
  - The work submitted is professional, including formatting, grammar etc

- Optional: Data visualisation (1% bonus)
  - Visualise insight with [python](https://colab.research.google.com/), [streamlit](https://streamlit.io/), [d3](https://d3js.org/), [mermaid](https://mermaid.js.org) or any other tool



# 🌏 THE END
Don't forget the project is awesome!

[🖨](?print-pdf)
