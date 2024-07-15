# Project Background
Elist Electronics, established in 2018, is a global e-commerce company that sells popular electronic products worldwide via its website and mobile app. 

The company has significant amounts of data on its sales, marketing efforts, operational efficiency, product offerings, and loyalty program that has been previously underutilized. This project thoroughly analyzes and synthesizes this data in order to uncover critical insights that will improve Elist's commercial success. 

Insights and recommendations are provided on the following key areas:

- **Sales Trends Analysis:** Evaluation of historical sales patterns, both globally and by region, focusing on Revenue, Order Volume, and Average Order Value (AOV).
- **Product Level Performance:** An analysis of Elist's various product lines, understanding their impact on sales and returns.
- **Loyalty Program Success:** An assessment of the loyalty program on customer retention and sales.
- **Regional Comparisons:** An evaluation of sales and orders by region.



An interactive PowerBI dashboard can be downloaded [here.](https://github.com/nikolasscoolis/Elist-Electronics/raw/main/Elist%20Electronics.pbix)

The SQL queries utilized to inspect and perform quality checks can be found [here.](https://github.com/nikolasscoolis/Elist-Electronics/blob/main/SQL%20Queries/Example%20Initial%20Data%20Checks.sql)

The SQL queries utilized to clean, organize, and prepare data for the dashboard can be found [here.](https://github.com/nikolasscoolis/Elist-Electronics/blob/main/SQL%20Queries/Cleaning%20Data%20for%20Analysis.sql)

Targeted SQL queries regarding various business questions can be found [here.](https://github.com/nikolasscoolis/Elist-Electronics/blob/main/SQL%20Queries/Targeted%20Business%20Questions.sql)

# Data Structure & Initial Checks

Elist's database structure as seen below consists of four tables: orders, customers, geo_lookup, and order_status, with a total row count of 108,127 records.

![Elist Electronics ERD](https://github.com/nikolasscoolis/Elist-Electronics/assets/170461739/22274452-edb4-4f0e-aeeb-a558d15fa37b)

Prior to beginning the analysis, a variety of checks were conducted for quality control and familiarization with the datasets. The SQL queries utilized to inspect and perform quality checks can be found [here.](https://github.com/nikolasscoolis/Elist-Electronics/blob/main/SQL%20Queries/Example%20Initial%20Data%20Checks.sql)


# Executive Summary

### Overview of Findings

After peaking in late 2020, the company's sales have continued to decline, with significant drops in 2022. Key performance indicators have all shown year-over-year decreases: order volume by 40%, revenue by 46%, and average order value (AOV) by 10%. While this decline can be broadly attributed to a return to pre-pandemic normalcy, the following sections will explore additional contributing factors and highlight key opportunity areas for improvement.

Below is the overview page from the PowerBI dashboard and more examples are included throughout the report. The entire interactive dashboard can be downloaded [here.](https://github.com/nikolasscoolis/Elist-Electronics/raw/main/Elist%20Electronics.pbix)

![Dashboard Overview](https://github.com/nikolasscoolis/Elist-Electronics/assets/170461739/c20e3ed3-2a31-43e7-9edb-1eda1d087dcb)



### Sales Trends:

* **The company's sales peaked in December 2020 with 4,019 orders totaling $1,251,721 monthly revenue**. This corresponds with the boom in economy-wide spending due to pandemic-induced changing consumer behavior.
  
* Beginning in April 2021, **revenue declined on a year-over-year basis for 21 consecutive months**. Revenue hit a company lifetime low in October 2022, with the company earning just over $178K. In the following months, revenue recovered slightly, following normal holiday seasonality patterns.
  
* Despite the downward trend, full-year 2022 remained above the pre-COVID 2019 baseline in all three key performance indicators. This is primarily due to the stronger 1Q22, which recorded revenue and order count well above the same period in 2020, **up 37% and 23% respectively.**
  
* Average order value saw a one-month year-over-year increase in September 2022, this can be attributed to an increased share of high-cost laptop orders.

![Sales Trends](https://github.com/nikolasscoolis/Elist-Electronics/assets/170461739/a33f7892-cf65-44f8-ad20-7ba09c799037)


### Product Performance:

* **85% of the company's orders are from just three products**, Gaming Monitor, Apple AirPods Headphones, and Samsung Charging Cable Pack. These three products accounted for $3.5M in revenue in 2022, 70% of the company's total.
  
* In the headphones category, the Bose SoundSport Headphones have underperformed, contributing to less than 1% of total revenues and orders despite being, on average, $40 cheaper than the well-performing AirPods.
  
* The accessory category continues to grow as a share of orders, **now at 32% in 2022, up from 21% in 2020**. However, accessories remain less than 4% of total revenue.
  
* The company is heavily reliant on the continued popularity of Apple products, with the brand **accounting for 47% of total revenue in 2022**. Apple's iPhone has yet to make an impact though, registering less than 1% of orders in 2022.

![Product Performance](https://github.com/nikolasscoolis/Elist-Electronics/assets/170461739/3d908776-8317-496d-94e0-69030a66b9d9)


### Loyalty Program

* The loyalty program has grown in popularity since its implementation in 2019. Members as a share of revenue peaked in April 2022 at 62%. **On an annual basis, members have increased to 55% of revenue, up from 8% in 2019.**
  
* In 2022, l**oyalty members spent almost $35 more on average than non-members ($251 to $216)**. Annual order value (AOV) for members has steadily increased year-over-year, climbing 1.1% from 2021 while non-member AOV declined 18.7%.
  
* Non-members have historically outspent on their first orders with the company, but on **returning orders members outspent by nearly $60 in 2022.**

![Loyalty Program](https://github.com/nikolasscoolis/Elist-Electronics/assets/170461739/e0243a7e-abe7-4512-8e23-d5106473e5ab)


### Regional Comparisons:

* North America grew in importance in 2022, increasing revenue share to 55% and order share to 53% among known region sales.
  
* Sales and average order value (AOV) fell across all regions in 2022. **North America remains the largest AOV with $242, 39% above Latin America, the lowest performer.**
  
* Europe, the Middle East, and Africa saw a significant increase in order volume share in 4Q22, climbing from 26% to 33% quarter-over-quarter among known region sales.

![Regional Comparisons](https://github.com/nikolasscoolis/Elist-Electronics/assets/170461739/2a1aa7c9-49bd-4518-b0e7-2198d8423c55)


### Recommendations:

Based on the uncovered insights, the following recommendations have been provided: 

* With 85% of orders and 70% of revenue coming from just three products, diversifying the product portfolio is crucial. **Expanding the accessory category with new product lines, particularly Apple charging cables, would provide upsell opportunities.**
  
* Despite the general sales success of Apple products, iPhone sales have been disappointingly low (1% of revenue in 2022). **Enhancing marketing efforts to previous Apple product buyers could boost sales.**
  
* Look to capitalize on the growing share of Samsung accessories (32% of order count in 2022) by **introducing higher-cost Samsung products in already carried product categories such as laptops and cellphones.**
  
* **Re-evaluate Bose SoundSport Headphones.** As the product has never made up more than 1% of annual revenue, attempt to sell through the product by implementing bundle offers and flash sales to non-Apple ecosystem loyalty members before discontinuing.
  
* **Continue and push forward the loyalty program.** In order to convert non-members, consider offering a one-time sign-up discount paired with increased general marketing of membership benefits and savings. Focus targeted and personalized ads to previous customers, and utilize past order data to increase marketing efforts when previously purchased products may need replacing. 

