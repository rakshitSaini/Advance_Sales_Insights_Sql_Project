# Advance_Sales_Insights_Sql_Project

## Project Overview

This SQL project is designed to analyze and report on sales and customer data. It includes several SQL scripts that create views and perform various analyses to derive insights from the data. Below is an overview of the key components and insights provided by the project.

# Key Components

## Main.sql
Purpose: Contains SQL queries for analyzing sales data.
Analyses Performed:
Total sales by year and running totals.
Yearly product performance comparison.
Category contributions to sales.
Customer segmentation based on spending behavior.
Product cost segmentation.


## Advance_KPIs and Extra_Findings.sql
Purpose: Provides advanced KPIs and extra findings from customer and product data.
Analyses Performed:
Identifying top customers and their lifetime value.
Customer age distribution and order frequency.
Best-selling products and category-wise sales.
Product profitability and average product lifespan.


## final_customers_report.sql
Purpose: Creates a view named report_customers that aggregates customer data from the sales and customers tables.
Metrics Calculated:
Total orders, total sales, and customer age groups.
Customer segmentation based on purchasing behavior and recency.
Average order value and monthly spend for each customer.


## final_products_report.sql
Purpose: Creates a view named report_products that aggregates sales data from the sales and products tables.
Metrics Calculated:
Total sales, total orders, and average selling price per product.
Product segmentation based on sales performance (High-Performer, Mid-Range, Low-Performer).
Recency, lifespan, and average monthly revenue for each product.


# Insights
Product Performance: The project categorizes products into segments based on their sales performance, allowing for targeted strategies to improve sales.
Customer Segmentation: Customers are segmented into VIP, Regular, and New categories based on their spending behavior and lifespan, enabling personalized marketing efforts.
Sales Trends: The analysis of total sales by year and running totals provides insights into long-term sales trends and seasonal patterns.
Category Contributions: Understanding which categories contribute the most to overall sales helps in focusing on high-performing categories.
Advanced KPIs: The project provides advanced KPIs such as customer lifetime value, order frequency, and product profitability, which are crucial for strategic decision-making.


# Usage
To use this project, ensure you have the necessary data in the sales, products, and customers tables. Run the SQL scripts in your database management system to create the views and perform the analyses. The results can be used to generate reports and dashboards for business intelligence purposes.

