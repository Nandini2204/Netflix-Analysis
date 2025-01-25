
-- SQL Retail Sales Analysis - P1
CREATE DATABASE netflix;


-- Create Table
CREATE TABLE Netflix
            (
                transaction_id INT PRIMARY KEY,	
                sale_date DATE,	 
                sale_time TIME,	
                customer_id	INT,
                gender	VARCHAR(15),
                age	INT,
                category VARCHAR(15),	
                quantity	INT,
                price_per_unit FLOAT,	
                cogs	FLOAT,
                total_sale FLOAT
            );



select * from [dbo].[Netflix]

-- Total number of Customer

select count(distinct customer_id) as TotalCustomer from [dbo].[Netflix]

-- Toyal number of category

select count(distinct category) as Category from [dbo].[Netflix]

-- Data Cleaning

select * from [dbo].[Netflix] where sale_date is null or sale_time is null or 
customer_id is null or gender is null or age is null or category is null or
quantiy is null or price_per_unit is null or cogs is null ;


delete from [dbo].[Netflix] where sale_date is null or sale_time is null or 
customer_id is null or gender is null or age is null or category is null or
quantiy is null or price_per_unit is null or cogs is null ;



 -- Q.1 Write a SQL query to retrieve all columns for sales made on '2022-11-05

select * from [dbo].[Netflix] where sale_date='2022-11-05'


-- Q.2 Write a SQL query to retrieve all transactions where the category is 'Clothing' and the quantity sold is more than 4 in the month of Nov-2022

select * from [dbo].[Netflix] where category='Clothing' and quantiy>=4 and 
month(sale_date)=11 


-- Q.3 Write a SQL query to calculate the total sales (total_sale) for each category.

select category,sum(total_sale) AS total_sales from [dbo].[netflix] group by category


-- Q.4 Write a SQL query to find the average age of customers who purchased items from the 'Beauty' category.

select avg(age) as Avg_age from [dbo].[Netflix] where category='Beauty' 


-- Q.5 Write a SQL query to find all transactions where the total_sale is greater than 1000.

select * from [dbo].[Netflix] where total_sale>1000


-- Q.6 Write a SQL query to find the total number of transactions (transaction_id) made by each gender in each category.

select category,gender,count(*) from [dbo].[Netflix]
group by gender,category


-- Q.7 Write a SQL query to calculate the average sale for each month. Find out best selling month in each year

SELECT 
    year,
    month,
    total_sales
FROM (
    SELECT 
        YEAR(CAST(sale_date AS DATE)) AS year,
        MONTH(CAST(sale_date AS DATE)) AS month,
        SUM(CAST(total_sale AS DECIMAL(10, 2))) AS total_sales,
        RANK() OVER (PARTITION BY YEAR(CAST(sale_date AS DATE)) ORDER BY SUM(CAST(total_sale AS DECIMAL(10, 2))) DESC) AS rank
    FROM 
        [dbo].[Netflix]
    GROUP BY 
        YEAR(CAST(sale_date AS DATE)), MONTH(CAST(sale_date AS DATE))
) ranked_sales
WHERE rank = 1;


-- Q.8 Write a SQL query to find the top 5 customers based on the highest total sales 

SELECT TOP 5 
    customer_id, 
    SUM(CAST(total_sale AS DECIMAL(10, 2))) AS total_sales
FROM 
    [dbo].[Netflix]
GROUP BY 
    customer_id
ORDER BY 
    SUM(CAST(total_sale AS DECIMAL(10, 2))) DESC;

-- Q.9 Write a SQL query to find the number of unique customers who purchased items from each category.

select category, count( distinct customer_id) as customer_id from [dbo].[Netflix] group by category


-- Q.10 Write a SQL query to create each shift and number of orders (Example Morning <12, Afternoon Between 12 & 17, Evening >17)

SELECT 
    CASE 
        WHEN CAST(sale_time AS TIME) < '12:00:00' THEN 'Morning'
        WHEN CAST(sale_time AS TIME) BETWEEN '12:00:00' AND '17:00:00' THEN 'Afternoon'
        ELSE 'Evening'
    END AS shift,
    COUNT(*) AS number_of_orders
FROM 
    [dbo].[Netflix]
GROUP BY 
    CASE 
        WHEN CAST(sale_time AS TIME) < '12:00:00' THEN 'Morning'
        WHEN CAST(sale_time AS TIME) BETWEEN '12:00:00' AND '17:00:00' THEN 'Afternoon'
        ELSE 'Evening'
    END;

-- End of Project


