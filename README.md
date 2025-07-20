Supermarket-Sales-Analysis-SQL-Project
About

This project involves analyzing a supermarket sales dataset using SQL. The goal is to derive actionable business insights from raw transactional data. The project explores customer behavior, sales trends, product performance, and branch-level operations by writing SQL queries in MySQL Workbench.

Business Objectives
Identify top-performing products, branches, and cities
Understand customer behavior based on time, gender, and type
Reveal monthly revenue trends and peak business periods
Evaluate rating and customer satisfaction patterns
Support better decision-making for operations and marketing




About Data

This project's data was obtained from the Kaggle Sales Forecasting Competition and it encompasses sales transactions from three Walmart branches situated in Mandalay, Yangon, and Naypyitaw, respectively. The data contains 17 columns and 1000 rows:

Column	Description	Data Type
invoice_id	Invoice of the sales made	VARCHAR(30)
branch	Branch at which sales were made	VARCHAR(5)
city	The location of the branch	VARCHAR(30)
customer_type	The type of the customer	VARCHAR(30)
gender	Gender of the customer making purchase	VARCHAR(10)
product_line	Product line of the product sold	VARCHAR(100)
unit_price	The price of each product	DECIMAL(10, 2)
quantity	The amount of the product sold	INT
VAT	The amount of tax on the purchase	DECIMAL(6, 4)
total	The total cost of the purchase	DECIMAL(12, 4)
date	The date on which the purchase was made	DATETIME
time	The time at which the purchase was made	TIME
payment	The total amount paid	DECIMAL(10, 2)
cogs	Cost Of Goods sold	DECIMAL(10, 2)
gross_margin_pct	Gross margin percentage	DECIMAL(11, 9)
gross_income	Gross Income	DECIMAL(12, 4)
rating	Rating	DECIMAL(2, 1)
Analysis List:

Product Analysis Focuses on identifying top-selling product lines, understanding product performance across cities and genders, and evaluating revenue and tax contributions per product. Discover most sold and highest revenue-generating product lines. Analyze VAT contributions and average ratings by product line. Compare gender preferences per product line. Categorize product performance as "Good" or "Bad" based on average sales.

Sales Analysis Explores the sales trends over time—by month, day of the week, and time of the day—to pinpoint peak business hours and successful sales strategies. Identify sales frequency by time of day and weekday. Detect months with the highest revenue and COGS. Compare branch performance against average product sales. Assess which customer type or city contributes most to revenue and tax.

Customer Analysis Examines customer demographics, purchase behaviors, and preferences to better understand key customer segments. Segment customers by type and gender. Find the most common customer type and gender per branch. Analyze the time and day when customers leave the highest ratings. Evaluate the best-rated day per week and per branch.







CREATE DATABASE supermarket;

CREATE TABLE sales (
    invoice_id VARCHAR(30) NOT NULL PRIMARY KEY,
    branch VARCHAR(5) NOT NULL,
    city VARCHAR(30) NOT NULL,
    customer_type VARCHAR(30) NOT NULL,
    gender VARCHAR(10) NOT NULL,
    product_line VARCHAR(100) NOT NULL,
    unit_price DECIMAL(10,2) NOT NULL,
    quantity INT NOT NULL,
    vat DECIMAL(6,4) NOT NULL,
    total DECIMAL(12,4) NOT NULL,
    date DATETIME NOT NULL,
    time TIME NOT NULL,
    payment VARCHAR(15) NOT NULL,
    cogs DECIMAL(10,2) NOT NULL,
    gross_margin_pct DECIMAL(5,4),
    gross_income DECIMAL(12,4),
    rating DECIMAL(3,2)
);

-- Add time_of_day column
ALTER TABLE sales ADD COLUMN time_of_day VARCHAR(20);

-- Update time_of_day based on time
UPDATE sales
SET time_of_day = CASE
    WHEN `time` BETWEEN '00:00:00' AND '12:00:00' THEN 'Morning'
    WHEN `time` BETWEEN '12:01:00' AND '16:00:00' THEN 'Afternoon'
    ELSE 'Evening'
END;

-- Add day_name column
ALTER TABLE sales ADD COLUMN day_name VARCHAR(10);

-- Update day_name based on date
UPDATE sales
SET day_name = DAYNAME(`date`);

-- Add month_name column
ALTER TABLE sales ADD COLUMN month_name VARCHAR(10);

-- Update month_name based on date
UPDATE sales
SET month_name = MONTHNAME(`date`);




Business Questions to Answer

1. Which product line generated the highest revenue?
SELECT product_line,SUM(total) as Total_Revenue
FROM SALES 
GROUP BY product_line
ORDER BY Total_Revenue DESC
LIMIT 1;

2.Which city has the highest revenue?
SELECT city,SUM(total) as Total_revenue
FROM SALES
GROUP BY city
order by Total_revenue DESC
LIMIT 1;

3.Which product line incurred the highest VAT?
SELECT product_line,SUM(vat) as Total_Vat
FROM SALES
GROUP BY product_line
ORDER BY Total_Vat DESC
LIMIT 1;

4.Retrieve each product line and add a column product_category,indicating 'Good' or 'Bad,' based on whether its sales are above the average.
SELECT *,
  CASE 
    WHEN total_sales > (SELECT AVG(total_sales) FROM (
        SELECT product_line, SUM(quantity) AS total_sales
        FROM sales
        GROUP BY product_line
    ) AS avg_table) THEN 'Good'
    ELSE 'Bad'
  END AS product_category
FROM (
    SELECT product_line, SUM(quantity) AS total_sales
    FROM sales
    GROUP BY product_line
) AS sub;

5. What is the most common payment method?
SELECT payment,count(*) as Payment_count
FROM sales
GROUP BY payment
ORDER BY Payment_count DESC
LIMIT 1;

6.What is the most selling product line?
SELECT product_line ,count(quantity) as Total_count
FROM sales
GROUP BY product_line
ORDER BY Total_count DESC
LIMIT 1;

 7. Total revenue by month?
 SELECT month_name, SUM(total) as Monthly_Revenue
 FROM SALES
 GROUP BY month_name
 ORDER BY Monthly_Revenue DESC;
 
 8. Which month recorded the highest Cost of Goods Sold (COGS)?
 SELECT month_name,SUM(COGS) AS Total_COGS
 FROM SALES
 GROUP BY month_name
 ORDER BY month_name DESC
 LIMIT 1;
 
 9. Which branch sold more products than average sold across all branches? 
SELECT branch, SUM(quantity) AS total_sold
FROM sales
GROUP BY branch
HAVING total_sold > (SELECT AVG(total_quantity) FROM (
  SELECT branch, SUM(quantity) AS total_quantity
  FROM sales
  GROUP BY branch
) AS avg_branch);

10. What is the average rating of each product line?
SELECT product_line, ROUND(AVG(rating),2) AS avg_rating
FROM sales
GROUP BY product_line
ORDER BY avg_rating DESC;

11. Number of sales made in each time of the day per weekday
SELECT day_name, time_of_day, COUNT(*) AS num_sales
FROM sales
GROUP BY day_name, time_of_day
ORDER BY day_name, num_sales DESC;

12. Identify the customer type that generates the highest revenue
SELECT customer_type, SUM(total) AS revenue
FROM sales
GROUP BY customer_type
ORDER BY revenue DESC;

13. Which customer type pays the most VAT?
SELECT customer_type, SUM(vat) AS total_vat
FROM sales
GROUP BY customer_type
ORDER BY total_vat DESC;

14. Which time of the day do customers give the most ratings?  
SELECT time_of_day, AVG(rating) AS avg_rating
FROM sales
GROUP BY time_of_day
ORDER BY avg_rating DESC;

15.Which day of the week has the best average ratings?
SELECT day_name, ROUND(AVG(rating),2) AS avg_rating
FROM sales
GROUP BY day_name
ORDER BY avg_rating DESC;
 
