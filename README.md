# Supermarket-Sales-Analysis-SQL-Project
## About
This project involves analyzing a supermarket sales dataset using SQL. The goal is to derive actionable business insights from raw transactional data. The project explores customer behavior, sales trends, product performance, and branch-level operations by writing SQL queries in MySQL Workbench.

## Business Objectives
Identify top-performing products, branches, and cities

Understand customer behavior based on time, gender, and type

Reveal monthly revenue trends and peak business periods

Evaluate rating and customer satisfaction patterns

Support better decision-making for operations and marketing

## About Data
This project's data was obtained from the Kaggle Sales Forecasting Competition and it encompasses sales transactions from three Walmart branches situated in Mandalay, Yangon, and Naypyitaw, respectively.
The data contains 17 columns and 1000 rows:
| Column            | Description                                   | Data Type        |
|-------------------|-----------------------------------------------|------------------|
| invoice_id        | Invoice of the sales made                     | VARCHAR(30)      |
| branch            | Branch at which sales were made               | VARCHAR(5)       |
| city              | The location of the branch                    | VARCHAR(30)      |
| customer_type     | The type of the customer                       | VARCHAR(30)      |
| gender            | Gender of the customer making purchase        | VARCHAR(10)      |
| product_line      | Product line of the product sold               | VARCHAR(100)     |
| unit_price        | The price of each product                     | DECIMAL(10, 2)   |
| quantity          | The amount of the product sold                 | INT              |
| VAT               | The amount of tax on the purchase             | FLOAT(6, 4)      |
| total             | The total cost of the purchase                | DECIMAL(12, 4)   |
| date              | The date on which the purchase was made       | DATETIME         |
| time              | The time at which the purchase was made       | TIME             |
| payment           | The total amount paid                         | DECIMAL(10, 2)   |
| cogs              | Cost Of Goods sold                            | DECIMAL(10, 2)   |
| gross_margin_pct  | Gross margin percentage                       | FLOAT(11, 9)     |
| gross_income      | Gross Income                                  | DECIMAL(12, 4)   |
| rating            | Rating                                        | FLOAT(2, 1)      |


## Analysis List:

1. Product Analysis
    Focuses on identifying top-selling product lines, understanding product performance across cities and genders, and evaluating revenue and tax contributions per product.
    Discover most sold and highest revenue-generating product lines.
    Analyze VAT contributions and average ratings by product line.
    Compare gender preferences per product line.
    Categorize product performance as "Good" or "Bad" based on average sales.

2. Sales Analysis
    Explores the sales trends over time—by month, day of the week, and time of the day—to pinpoint peak business hours and successful sales strategies.
    Identify sales frequency by time of day and weekday.
    Detect months with the highest revenue and COGS.
    Compare branch performance against average product sales.
    Assess which customer type or city contributes most to revenue and tax.

3. Customer Analysis
    Examines customer demographics, purchase behaviors, and preferences to better understand key customer segments.
    Segment customers by type and gender.
    Find the most common customer type and gender per branch.
    Analyze the time and day when customers leave the highest ratings.
    Evaluate the best-rated day per week and per branch.
    

## Business Questions + SQL Queries + Insights:

-- 1. Which product line generated the highest revenue?
SELECT product_line, SUM(total) AS revenue
FROM sales
GROUP BY product_line
ORDER BY revenue DESC;
-- Insight: Focus marketing on top revenue-generating product lines.

-- 2. Which city has the highest revenue?
SELECT city, SUM(total) AS revenue
FROM sales
GROUP BY city
ORDER BY revenue DESC;
-- Insight: Helps decide where to expand or allocate more resources.

-- 3. Which product line incurred the highest VAT?
SELECT product_line, SUM(vat) AS total_vat
FROM sales
GROUP BY product_line
ORDER BY total_vat DESC;
-- Insight: Indicates which product lines are high value and taxed more.

-- 4. Classify product lines as 'Good' or 'Bad' based on average quantity sold
SELECT product_line, SUM(quantity) AS total_sold,
  CASE
    WHEN SUM(quantity) > (SELECT AVG(total_q) FROM (
        SELECT product_line, SUM(quantity) AS total_q
        FROM sales
        GROUP BY product_line) AS avg_table) THEN 'Good'
    ELSE 'Bad'
  END AS product_category
FROM sales
GROUP BY product_line;
-- Insight: Quick classification for inventory or promotion focus.

-- 5. What is the most common payment method?
SELECT payment, COUNT(*) AS count
FROM sales
GROUP BY payment
ORDER BY count DESC
LIMIT 1;
-- Insight: Helps in optimizing transaction systems and offers.

-- 6. What is the most selling product line?
SELECT product_line, SUM(quantity) AS total_quantity
FROM sales
GROUP BY product_line
ORDER BY total_quantity DESC;
-- Insight: Top-performing products by volume, not just revenue.

-- 7. What is the total revenue by month?
SELECT month_name, SUM(total) AS monthly_revenue
FROM sales
GROUP BY month_name
ORDER BY monthly_revenue DESC;
-- Insight: Understand seasonality and monthly sales trends.

-- 8. Which month recorded the highest COGS?
SELECT month_name, SUM(cogs) AS total_cogs
FROM sales
GROUP BY month_name
ORDER BY total_cogs DESC
LIMIT 1;
-- Insight: High COGS could indicate more sales or higher production costs.

-- 9. Which branch sold more products than average?
SELECT branch, SUM(quantity) AS total_quantity
FROM sales
GROUP BY branch
HAVING total_quantity > (
    SELECT AVG(total_branch_qty) FROM (
        SELECT branch, SUM(quantity) AS total_branch_qty
        FROM sales
        GROUP BY branch
    ) AS avg_branch_table
);
-- Insight: Helps identify best-performing branches.

-- 10. What is the average rating of each product line?
SELECT product_line, ROUND(AVG(rating), 2) AS avg_rating
FROM sales
GROUP BY product_line
ORDER BY avg_rating DESC;
-- Insight: Shows customer satisfaction level by product category.

-- 11. Number of sales made in each time of day per weekday
SELECT day_name, time_of_day, COUNT(*) AS total_sales
FROM sales
GROUP BY day_name, time_of_day
ORDER BY day_name, total_sales DESC;
-- Insight: Understand when customers shop the most.

-- 12. Which customer type generates the most revenue?
SELECT customer_type, SUM(total) AS total_revenue
FROM sales
GROUP BY customer_type
ORDER BY total_revenue DESC;
-- Insight: Helps prioritize retention or acquisition strategies.

-- 13. Which customer type pays the most VAT?
SELECT customer_type, SUM(vat) AS total_vat
FROM sales
GROUP BY customer_type
ORDER BY total_vat DESC;
-- Insight: Indicates most valuable customer types.

-- 14. Which time of the day do customers give the most ratings?
SELECT time_of_day, ROUND(AVG(rating), 2) AS avg_rating
FROM sales
GROUP BY time_of_day
ORDER BY avg_rating DESC;
-- Insight: Engagement or mood trend based on time.

-- 15. Which day of the week has the best average ratings?
SELECT day_name, ROUND(AVG(rating), 2) AS avg_rating
FROM sales
GROUP BY day_name
ORDER BY avg_rating DESC;
-- Insight: Helps understand which days customers are most satisfied.

