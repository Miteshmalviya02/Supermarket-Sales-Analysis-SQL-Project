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
-- 1. Which product line generated the highest revenue?
SELECT product_line,SUM(total) as Total_Revenue
FROM SALES 
GROUP BY product_line
ORDER BY Total_Revenue DESC
LIMIT 1;

-- 2.Which city has the highest revenue?
SELECT city,SUM(total) as Total_revenue
FROM SALES
GROUP BY city
order by Total_revenue DESC
LIMIT 1;

-- 3.Which product line incurred the highest VAT?
SELECT product_line,SUM(vat) as Total_Vat
FROM SALES
GROUP BY product_line
ORDER BY Total_Vat DESC
LIMIT 1;

-- 4.Retrieve each product line and add a column product_category,indicating 'Good' or 'Bad,' based on whether its sales are above the average.
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

-- 5. What is the most common payment method?
SELECT payment,count(*) as Payment_count
FROM sales
GROUP BY payment
ORDER BY Payment_count DESC
LIMIT 1;

-- 6.What is the most selling product line?
SELECT product_line ,count(quantity) as Total_count
FROM sales
GROUP BY product_line
ORDER BY Total_count DESC
LIMIT 1;

 -- 7. Total revenue by month
 SELECT month_name, SUM(total) as Monthly_Revenue
 FROM SALES
 GROUP BY month_name
 ORDER BY Monthly_Revenue DESC;
 
 -- 8. Which month recorded the highest Cost of Goods Sold (COGS)?
 SELECT month_name,SUM(COGS) AS Total_COGS
 FROM SALES
 GROUP BY month_name
 ORDER BY month_name DESC
 LIMIT 1;
 
 -- 9. Which branch sold more products than average sold across all branches? 
SELECT branch, SUM(quantity) AS total_sold
FROM sales
GROUP BY branch
HAVING total_sold > (SELECT AVG(total_quantity) FROM (
  SELECT branch, SUM(quantity) AS total_quantity
  FROM sales
  GROUP BY branch
) AS avg_branch);

-- 10. What is the average rating of each product line?
SELECT product_line, ROUND(AVG(rating),2) AS avg_rating
FROM sales
GROUP BY product_line
ORDER BY avg_rating DESC;

-- 11. Number of sales made in each time of the day per weekday
SELECT day_name, time_of_day, COUNT(*) AS num_sales
FROM sales
GROUP BY day_name, time_of_day
ORDER BY day_name, num_sales DESC;

-- 12. Identify the customer type that generates the highest revenue
SELECT customer_type, SUM(total) AS revenue
FROM sales
GROUP BY customer_type
ORDER BY revenue DESC;

-- 13. Which customer type pays the most VAT?
SELECT customer_type, SUM(vat) AS total_vat
FROM sales
GROUP BY customer_type
ORDER BY total_vat DESC;

-- 14. Which time of the day do customers give the most ratings?  
SELECT time_of_day, AVG(rating) AS avg_rating
FROM sales
GROUP BY time_of_day
ORDER BY avg_rating DESC;

-- 15.Which day of the week has the best average ratings?
SELECT day_name, ROUND(AVG(rating),2) AS avg_rating
FROM sales
GROUP BY day_name
ORDER BY avg_rating DESC;
 






