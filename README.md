# Netflix-Analysis

## Project Overview
This project is designed to demonstrate SQL skills and techniques typically used by data analysts to explore, clean, and analyze retail sales data. The project involves setting up a retail sales database, performing exploratory data analysis (EDA), and answering specific business questions through SQL queries. This project is ideal for those who are starting their journey in data analysis and want to build a solid foundation in SQL.

## Project Structure
### 1. Database Setup
- Database Creation: The project starts by creating a database named netflix_db.
- Table Creation: A table named Netflix stores the sales data. The table structure includes columns for transaction ID, sale date, sale time, customer ID, gender, age, product category, quantity sold, price per unit, cost of goods sold (COGS), and total sale amount.

``` ruby
CREATE DATABASE netflix;

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

```
### 2. Data Exploration & Cleaning
- Record Count: Determine the total number of records in the dataset.
- Customer Count: Find out how many unique customers are in the dataset.
- Category Count: Identify all unique product categories in the dataset.
- Null Value Check: Check for any null values in the dataset and delete records with missing data.

```ruby
select * from [dbo].[Netflix]
select count(distinct customer_id) as TotalCustomer from [dbo].[Netflix]
select count(distinct category) as Category from [dbo].[Netflix]

select * from [dbo].[Netflix] where sale_date is null or sale_time is null or 
customer_id is null or gender is null or age is null or category is null or
quantiy is null or price_per_unit is null or cogs is null ;

delete from [dbo].[Netflix] where sale_date is null or sale_time is null or 
customer_id is null or gender is null or age is null or category is null or
quantiy is null or price_per_unit is null or cogs is null ;
```

### 3. Data Analysis & Finding
The following SQL queries were developed to answer specific business questions:

1. Write a SQL query to retrieve all columns for sales made on '2022-11-05:
```ruby
select * from [dbo].[Netflix] where sale_date='2022-11-05'
```
2. Write a SQL query to retrieve all transactions where the category is 'Clothing' and the quantity sold is more than 4 in the month of Nov-2022:
```ruby
select * from [dbo].[Netflix] where category='Clothing' and quantiy>=4 and 
month(sale_date)=11 
```
3. Write a SQL query to calculate each category's total sales (total_sale).
```ruby
select category,sum(total_sale) AS total_sales from [dbo].[netflix] group by category
```
4. Write a SQL query to find the average age of customers who purchased items from the 'Beauty' category.
```ruby
select avg(age) as Avg_age from [dbo].[Netflix] where category='Beauty' 
```
5. Write a SQL query to find all transactions where the total_sale is greater than 1000.
```ruby
select * from [dbo].[Netflix] where total_sale>1000
```
6. Write a SQL query to find the total number of transactions (transaction_id) made by each gender in each category.
```ruby
select category,gender,count(*) from [dbo].[Netflix]
group by gender,category
```
7. Write a SQL query to calculate the average sale for each month. Find out best selling month in each year
```ruby
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
```
8. Write a SQL query to find the top 5 customers based on the highest total sales 
```ruby
SELECT TOP 5 
    customer_id, 
    SUM(CAST(total_sale AS DECIMAL(10, 2))) AS total_sales
FROM 
    [dbo].[Netflix]
GROUP BY 
    customer_id
ORDER BY 
    SUM(CAST(total_sale AS DECIMAL(10, 2))) DESC;
```
9. Write a SQL query to find the number of unique customers who purchased items from each category.
```ruby
select category, count( distinct customer_id) as customer_id from [dbo].[Netflix] group by category
```
10. Write a SQL query to create each shift and number of orders (Example Morning <12, Afternoon Between 12 & 17, Evening >17)
```ruby
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
```
## Findings

* Customer Demographics: The dataset includes customers from various age groups, with sales distributed across different categories such as Clothing and Beauty.
* High-Value Transactions: Several transactions had a total sale amount greater than 1000, indicating premium purchases.
* Sales Trends: Monthly analysis shows variations in sales, helping identify peak seasons.
* Customer Insights: The analysis identifies the top-spending customers and the most popular product categories.

## Conclusion
This project serves as a comprehensive introduction to SQL for data analysts, covering database setup, data cleaning, exploratory data analysis, and business-driven SQL queries. The findings from this project can help drive business decisions by understanding sales patterns, customer behavior, and product performance.

