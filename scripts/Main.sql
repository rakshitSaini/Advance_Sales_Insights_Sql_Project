/*=============================================================START OF THE FILE==============================================================================*/

use gold;
select * from customers;
select * from sales;
select * from products;


/*===========================================================================================================================================*/

-- total sales  by year ( for long term understandanding)
SELECT 
   date_format(order_date,'%Y-%m') order_years,
    count(distinct customer_key) as customer_count,
    sum(quantity) total_quantity, 
    SUM(sales_amount) total_sales
    
FROM
    sales
    where YEAR(order_date) is not null 
GROUP BY order_years
order by order_years ;
	

/*===========================================================================================================================================*/

-- running total of sales 

select *,sum(total_sales) over(partition by left(order_years,5) order by order_years) Running_total from (
select date_format(order_date,'%Y-%m') order_years, sum(sales_amount) as total_sales
 from sales
 where date_format(order_date,'%Y-%m') is not null
 group by date_format(order_date,'%Y-%m')) as temp;


/*===========================================================================================================================================*/

-- Analyizing the yearly performance of the products by compairing 
-- each product sales to both its average sales performance and previous year sales 


select p.product_key ,p.product_name, year(s.order_date) years,
 sum(s.quantity) total_quantity, sum(s.sales_amount) total_sales,
avg(s.sales_amount) avg_sales
from products p 
left join sales s 
on p.product_key=s.product_key
group by p.product_key,p.product_name, year(s.order_date)
having total_quantity is not null and years is not null 
order by years ;




/*===========================================================================================================================================*/


-- Analyizing the yearly performance of the products by compairing 
-- each product sales to both its average sales performance and previous year sales


with total_sales_table AS (
select p.product_key ,p.product_name, year(s.order_date) years,
 sum(s.quantity) total_quantity, sum(s.sales_amount) total_sales
from products p 
left join sales s 
on p.product_key=s.product_key
group by p.product_name, year(s.order_date), p.product_key
having total_quantity is not null and years is not null 
order by p.product_name ,years)
select product_key, product_name, years, total_sales,previous_year_total_sales,
(total_sales- previous_year_total_sales) as total_sales_diff_previous_year,
CASE WHEN total_sales-previous_year_total_sales > 0 then 'Increase'
	 WHEN total_sales-previous_year_total_sales < 0 then 'Decrease'
     ELSE 'No Change'
END	Sales_changes,
total_sales,avg_total_sales,(total_sales-avg_total_sales) as avg_sales_diff_each_year,
CASE WHEN total_sales-avg_total_sales > 0 then 'Above Average'
	 WHEN total_sales-avg_total_sales < 0 then 'Below Average'
     ELSE 'Average'
END	Average_change
from 
(select product_key,product_name,years,total_sales,
coalesce( lag(total_sales) over(partition by product_name),0) previous_year_total_sales ,
avg(total_sales) over(partition by product_name) avg_total_sales 
from total_sales_table) 
as second_table;


/*===========================================================================================================================================*/

-- which category contributes the most of the overall sales 

with cte as(
select  p.category category,sum(s.sales_amount) sales from products p
Right join sales s 
on p.product_key =s.product_key
group by  p.category)

select category, sales ,
concat(round(((sales/sum(sales) over())*100),2),'%') as percentage
from cte
group by category 
order by percentage desc;




/*===========================================================================================================================================*/


-- segment into cost ranges  and count how many fall into each segment
select max(cost), min(cost) from products ;

select cost_category, count(product_key) total_products from  (select *, 
CASE WHEN COST <=750 THEN 'low Cost'
	 WHEN COST <=1500 THEN 'Medium Cost'
	 WHEN COST >1500 then 'High Cost'
     else 'NOt_valid'
end cost_category
 from products) as temp
 group by cost_category
 order by total_products desc;
 
 
 
 /*===========================================================================================================================================*/
 
 
 /* Group customers into three segments based on their spending behavior:
    - VIP: Customers with at least 12 months of history and spending more than €5,000.
    - Regular: Customers with at least 12 months of history but spending €5,000 or less.
    - New: Customers with a lifespan less than 12 months.
And find the total number of customers by each group
*/


with customer_spending as (
select customer_key  ,sum(sales_amount) total_sales,datediff(max(order_date),min(order_date)) as lifespan
from sales
group by customer_key 
)
select customer_value, count(customer_key) total_customer from (
select customer_key,
case
when lifespan >= 365 and total_sales >=5000 then 'VIP'
when lifespan >= 365 and total_sales <5000 then 'Regular'
else'New'
end Customer_value 
from customer_spending) as second_table
group by customer_value 
order by total_customer desc;


/*============================================================END OF THE FILE===============================================================================*/

