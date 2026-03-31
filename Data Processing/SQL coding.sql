select * from `workspace`.`default`.`1773682225332_bright_coffee_shop_analysis_case_study_1` limit 100;
--- I want to see my table in the coding to start exploryting each column

SELECT *
FROM `workspace`.`default`.`1773682225332_bright_coffee_shop_analysis_case_study_1` 
LIMIT 10;

------------------------------------------------
-- 1. Checking the Date Range
-------------------------------------------------
-- They started collecting the data 2023-01-01
SELECT MIN(transaction_date) AS earliest_date 
FROM `workspace`.`default`.`1773682225332_bright_coffee_shop_analysis_case_study_1`;
-- the duration of the data is 6 months
--  They last collected the data 2023-06-30

SELECT MAX(transaction_date) AS latest_date 
FROM `workspace`.`default`.`1773682225332_bright_coffee_shop_analysis_case_study_1`;

---SELECT DISTINCT store_location
---FROM `workspace`.`default`.`1773682225332_bright_coffee_shop_analysis_case_study_1`;

SELECT COUNT(DISTINCT store_id) AS number_of_stores
FROM `workspace`.`default`.`1773682225332_bright_coffee_shop_analysis_case_study_1`;
-------------------------------------------------
-- 3. Checking products sold at our stores 
------------------------------------------------
SELECT DISTINCT product_category
FROM `workspace`.`default`.`1773682225332_bright_coffee_shop_analysis_case_study_1`;
SELECT DISTINCT product_detail
FROM `workspace`.`default`.`1773682225332_bright_coffee_shop_analysis_case_study_1`;

SELECT DISTINCT product_type
FROM `workspace`.`default`.`1773682225332_bright_coffee_shop_analysis_case_study_1`;

SELECT DISTINCT product_category AS category,
                product_detail AS product_name
FROM `workspace`.`default`.`1773682225332_bright_coffee_shop_analysis_case_study_1`;

-------------------------------------------------
-- 1. Checking product prices
------------------------------------------------
SELECT MIN(unit_price) As highest_price
FROM `workspace`.`default`.`1773682225332_bright_coffee_shop_analysis_case_study_1`;

SELECT MAX(unit_price) As lowest_price
FROM `workspace`.`default`.`1773682225332_bright_coffee_shop_analysis_case_study_1`;

------------------------------------------------
SELECT 
COUNT(*) AS number_of_rows,
      COUNT(DISTINCT transaction_id) AS number_of_sales,
      COUNT(DISTINCT product_id) AS number_of_products,
      COUNT(DISTINCT store_id) AS number_of_stores
FROM `workspace`.`default`.`1773682225332_bright_coffee_shop_analysis_case_study_1`;
------------------------------------------------

SELECT transaction_id,
      transaction_date,
      Dayname(transaction_date) AS Day_name,
      Monthname(transaction_date) AS Month_name,
      transaction_qty*unit_price AS transaction_revenue
FROM `workspace`.`default`.`1773682225332_bright_coffee_shop_analysis_case_study_1`;
-----------------------------------------------------

SELECT 
      transaction_date,
      Dayname(transaction_date) AS Day_name,
      Monthname(transaction_date) AS Month_name,
      COUNT(DISTINCT transaction_id) AS Number_of_sales,
      SUM(transaction_qty*unit_price) AS revenue_per_day,
CASE
      WHEN Dayname(transaction_date) IN ('Saturday','Sunday') THEN 'Weekend'
       ELSE 'Weekday'
      END AS day_type
FROM `workspace`.`default`.`1773682225332_bright_coffee_shop_analysis_case_study_1`
GROUP BY transaction_date,
         Day_name,
         Month_name;

SELECT 
    transaction_date,
    DAYNAME(transaction_date) AS Day_name,
    MONTHNAME(transaction_date) AS Month_name,
    COUNT(DISTINCT transaction_id) AS Number_of_sales,
    SUM(transaction_qty * unit_price) AS revenue_per_day,

    CASE
        WHEN DAYNAME(transaction_date) IN ('Saturday','Sunday') THEN 'Weekend'
        ELSE 'Weekday'
    END AS day_type

FROM `workspace`.`default`.`1773682225332_bright_coffee_shop_analysis_case_study_1`

GROUP BY 
    transaction_date,
    DAYNAME(transaction_date),
    MONTHNAME(transaction_date);

SELECT 
      Dayname(transaction_date) AS Day_name,
      Monthname(transaction_date) AS Month_name,
      Dayofmonth(transaction_date) AS day_of_month,

      CASE 
            WHEN Dayname(transaction_date) IN ('Sun','Sat') THEN 'Weekend'
            ELSE 'Weekday'
      END AS day_of_the_week,

      -- Time bucket
    CASE 
        WHEN HOUR(TO_TIMESTAMP(transaction_time)) BETWEEN 5 AND 11 THEN 'Early'
        WHEN HOUR(TO_TIMESTAMP(transaction_time)) BETWEEN 12 AND 13 THEN 'Mid-day'
        WHEN HOUR(TO_TIMESTAMP(transaction_time)) BETWEEN 14 AND 16 THEN 'Afternoon'
        ELSE 'Evening'
    END AS time_bucket,

      COUNT(DISTINCT transaction_id) AS no_of_sales,
      COUNT(DISTINCT product_id) AS no_of_products,
      COUNT(DISTINCT store_id) AS no_of_stores,
      SUM(transaction_qty*unit_price) AS revenue_per_day,

      CASE
            WHEN revenue_per_day <=50 THEN 'minimal_revenue'
            WHEN revenue_per_day BETWEEN 51 AND 100 THEN 'Moderate_sales'
            ELSE 'High_sales'
      END AS spend_bucket,

-- Columns
      store_location,
      product_category,
      product_detail

FROM `workspace`.`default`.`bright_coffee_shop_analysis_case_study_1`
GROUP BY transaction_date,
         Dayname(transaction_date),
         Monthname(transaction_date),
         Dayofmonth(transaction_date),

         CASE 
            WHEN Dayname(transaction_date) IN ('Sun','Sat') THEN 'Weekend'
            ELSE 'Weekday'
         END,
        CASE 
        WHEN HOUR(TO_TIMESTAMP(transaction_time)) BETWEEN 5 AND 11 THEN 'Early'
        WHEN HOUR(TO_TIMESTAMP(transaction_time)) BETWEEN 12 AND 13 THEN 'Mid-day'
        WHEN HOUR(TO_TIMESTAMP(transaction_time)) BETWEEN 14 AND 16 THEN 'Afternoon'
        ELSE 'Evening'
    END,
         store_location,
         product_category,
         product_detail;



