/*========================================================START OF FILE===================================================================================*/
-- Advanced KPIs

-- Top 5 Most Valuable Customers
SELECT customer_name, total_sales
FROM report_customers
ORDER BY total_sales DESC
LIMIT 5;


/*===========================================================================================================================================*/


-- Customer Age Group Distribution
SELECT age_group, COUNT(*) AS total_customers
FROM report_customers
GROUP BY age_group
ORDER BY total_customers DESC;


/*===========================================================================================================================================*/


-- Customer Lifetime Value (CLV)
SELECT customer_name, ROUND(avg_order_value * total_orders, 2) AS customer_lifetime_value
FROM report_customers
ORDER BY customer_lifetime_value DESC
LIMIT 10;


/*===========================================================================================================================================*/


-- Customer Order Frequency
SELECT customer_name, CASE WHEN lifespan = 0 THEN total_orders ELSE ROUND(total_orders / lifespan, 2) END AS order_frequency_per_month
FROM report_customers
ORDER BY order_frequency_per_month DESC
LIMIT 10;


/*===========================================================================================================================================*/


-- Average Customer Lifespan
SELECT ROUND(AVG(lifespan), 1) AS avg_customer_lifespan_months
FROM report_customers;

-- Top 5 Best-Selling Products
SELECT product_name, total_sales
FROM report_products
ORDER BY total_sales DESC
LIMIT 5;


/*===========================================================================================================================================*/


-- Product Category-wise Sales
SELECT category, SUM(total_sales) AS category_sales
FROM report_products
GROUP BY category
ORDER BY category_sales DESC;


/*===========================================================================================================================================*/


-- Product Profitability
SELECT product_name, total_sales - (cost * total_quantity) AS profit
FROM report_products
ORDER BY profit DESC
LIMIT 10;


/*===========================================================================================================================================*/


-- Average Product Lifespan
SELECT ROUND(AVG(lifespan), 1) AS avg_product_lifespan_months
FROM report_products;


/*==============================================================END OF FILE=============================================================================*/

