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
| VAT               | The amount of tax on the purchase             | DECIMAL(6, 4)      |
| total             | The total cost of the purchase                | DECIMAL(12, 4)   |
| date              | The date on which the purchase was made       | DATETIME         |
| time              | The time at which the purchase was made       | TIME             |
| payment           | The total amount paid                         | DECIMAL(10, 2)   |
| cogs              | Cost Of Goods sold                            | DECIMAL(10, 2)   |
| gross_margin_pct  | Gross margin percentage                       | DECIMAL(11, 9)     |
| gross_income      | Gross Income                                  | DECIMAL(12, 4)   |
| rating            | Rating                                        | DECIMAL(2, 1)      |


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
   

