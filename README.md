# Project Background
Elist Electronics, established in 2018, is a global e-commerce company that sells popular electronic products worldwide via its website and mobile app. 

The company has significant amounts of data on its sales, marketing efforts, operational efficiency, product offerings, and loyalty program that has been previously underutilized. This project thoroughly analyzes and synthesizes this data in order to uncover critical insights that will improve Elist's commercial success. 

Insights and recommendations are provided on the following key areas:

- **Sales Trends Analysis:** Evaluation of historical sales patterns, both globally and by region, focusing on Revenue, Order Volume, and Average Order Value (AOV).
- **Product Level Performance:** An analysis of Elist's various product lines, understanding their impact on sales and returns 
- **Loyalty Program Success:** An assessment of the loyalty program on customer retention and sales
- **Operational Efficiency:** An evaluation of logistical effectiveness, including processing and shipping times
- **Sales and Marketing Channels:** An investigation into the success of Elist's various sales and marketing channels 

An interactive PowerBI dashboard can be downloaded [here.](https://github.com/nikolasscoolis/Elist-Electronics/raw/main/Elist%20Electronics.pbix)

The SQL queries utilized to inspect and perform quality checks can be found [here.](https://github.com/nikolasscoolis/Elist-Electronics/blob/main/SQL%20Queries/Example%20Initial%20Data%20Checks.sql)

The SQL queries utilized to clean, organize, and prepare data for dashboard can be found [here.](https://github.com/nikolasscoolis/Elist-Electronics/blob/main/SQL%20Queries/Cleaning%20Data%20for%20Analysis.sql)

Targeted SQL queries regarding various business questions can be found [here.](https://github.com/nikolasscoolis/Elist-Electronics/blob/main/SQL%20Queries/Cleaning%20Data%20for%20Analysis.sql)

# Data Structure & Initial Checks

Elist's database structure as seen below consists of four tables: orders, customers, geo_lookup, and order_status, with a total row count of 108,127 records.

![Elist Electronics ERD](https://github.com/nikolasscoolis/Elist-Electronics/assets/170461739/22274452-edb4-4f0e-aeeb-a558d15fa37b)

Prior to beginning the analysis, a variety of checks were conducted for quality control and familiarization with the datasets. The SQL queries utilized to inspect and perform quality checks can be found [here.](https://github.com/nikolasscoolis/Elist-Electronics/blob/main/SQL%20Queries/Example%20Initial%20Data%20Checks.sql)

# Executive Summary

### Overview of Findings

After peaking in late 2020, the company's sales have continued to decline, with significant drops in 2022. Key performance indicators have all shown year-over-year decreases: order volume by 40%, revenue by 46%, and average order value (AOV) by 10%. While this decline can be broadly attributed to a return to pre-pandemic normalcy, the following sections will explore additional contributing factors and highlight key opportunity areas for improvement.

Below are examples from the PowerBI dashboard, the entire interactive dashboard can be downloaded [here.](https://github.com/nikolasscoolis/Elist-Electronics/raw/main/Elist%20Electronics.pbix)

![Dashboard Overview](https://github.com/nikolasscoolis/Elist-Electronics/assets/170461739/04908c5c-b09d-497d-8558-f4451bdd9dbe)

![image](https://github.com/nikolasscoolis/Elist-Electronics/assets/170461739/a33f7892-cf65-44f8-ad20-7ba09c799037)

### Product Performance:

* 85% of the company’s revenue and 70% of orders are driven from 37.5% of its SKUs (Gaming Monitor, AirPods, MacBook Air).
* In the headphones category, the Bose SoundSport Headphones have been a considerable disappointment, accounting for less than 1% of total revenues and orders, while being $40 cheaper than the AirPods on average.
* The laptop category is the most diversified and is the fourth largest category, driving 33% of total revenue from 6% of total orders since 2019.
* The company is heavily reliant on the continued popularity of Apple products, with the brand accounting for 50% of its total sales and 48% of its total orders since 2019.
