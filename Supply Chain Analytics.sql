create database RetailSupplyChain;
use RetailSupplyChain;

select * from retail_orders;
select count(*) from retail_orders;
SELECT * FROM retail_orders LIMIT 5;


-- . What is the total number of orders?
SELECT 
    COUNT(*)
FROM
    retail_orders;

-- 2. What is the total sales revenue?
SELECT 
    ROUND(SUM(Sales), 2) AS Total_revenue
FROM
    retail_orders;
    
-- What is the total profit earned?
SELECT 
    ROUND(SUM(Profit), 2) AS Total_Prfit
FROM
    retail_orders;

-- What is the average order value?
SELECT 
    ROUND((SUM(Sales) / COUNT(DISTINCT Order_ID)),
            2) AS avg_orders
FROM
    retail_orders;

-- 5. What is the total quantity of products sold?
SELECT 
    SUM(Quantity) as Total_Quantity
FROM
    retail_orders;

-- How many unique customers does the company have?
SELECT 
    COUNT(DISTINCT Customer_ID) AS Unique_cus
FROM
    retail_orders;

-- How many unique products are available?
SELECT 
    COUNT(DISTINCT Product_ID) AS Unique_product
FROM
    retail_orders;

--  What is the average profit per order?
select round(avg(order_profite),2) as avg_perorder 
from
(
select Order_ID , sum(Profit)  as order_profite
from retail_orders
group by order_ID
) t;

-- What is the average discount offered?
SELECT 
    ROUND(avg(Discount), 2) AS avg_discount
FROM
    retail_orders;
    
    -- . What is the average shipping cost?
SELECT 
    ROUND(AVG(Shipping_Cost), 2) as Avg_shiping_order
FROM
    retail_orders;

 --  Which product category generates the highest sales?
SELECT 
    Category, MAX(Sales) AS Highest_Sales
FROM
    retail_orders
GROUP BY Category
ORDER BY Highest_Sales DESC
LIMIT 1
;

	-- . Which product category generates the highest profit?
	SELECT 
		Category, round(Sum(Profit),2) AS Highest_Profit
	FROM
		retail_orders
	GROUP BY Category
	ORDER BY Highest_Profit DESC
	LIMIT 1
	;

--  Which sub-category generates the highest sales?
SELECT 
    Sub_Category, ROUND(MAX(Profit), 2) AS Highest_Sale
FROM
    retail_orders
GROUP BY Sub_Category
ORDER BY Highest_Sale DESC
LIMIT 1
	;
    
--  Which sub-category generates the highest profit?
SELECT 
    Sub_Category, ROUND(SUM(Profit), 2) AS Highest_Profit
FROM
    retail_orders
GROUP BY Sub_Category
ORDER BY Highest_Profit DESC
LIMIT 1
	;
  
  --  What are the top 10 products by sales?
  SELECT 
    Product_Name, ROUND(SUM(Sales),2) AS Total_sale
FROM
    retail_orders
GROUP BY Product_Name
ORDER BY Total_sale DESC
LIMIT 10;
  
-- What are the top 10 products by profit?
SELECT 
    Product_Name, ROUND(SUM(Profit),2) AS Total_Profit
FROM
    retail_orders
GROUP BY Product_Name
ORDER BY Total_Profit DESC
LIMIT 10;

--  Which products are generating losses?
SELECT 
    Product_Name, total_profite
FROM
    (SELECT 
        Product_Name, ROUND(SUM(Profit), 2) AS total_profite
    FROM
        retail_orders
    GROUP BY Product_Name) t
WHERE
    total_profite < 0;

--  Which products have the highest discounts?
SELECT 
    Product_Name, MAX(Discount) AS Hight_discount
FROM
    retail_orders
GROUP BY Product_Name
ORDER BY Hight_discount DESC
LIMIT 1
;

--  Which products are sold in the highest quantity?
SELECT 
    Product_Name, sum(Quantity) AS Hight_quantity
FROM
    retail_orders
GROUP BY Product_Name
ORDER BY Hight_quantity DESC
limit 1
;

-- Customer Analysis
-- Who are the top 10 customers by sales?

SELECT 
    Customer_Name, ROUND(SUM(Sales), 2) AS top_custmer
FROM
    retail_orders
GROUP BY Customer_Name
ORDER BY top_custmer DESC
LIMIT 10
;


--  Who are the top 10 customers by profit?

SELECT 
    Customer_Name, ROUND(SUM(Profit), 2) AS Top_custmer_Byprofite
FROM
    retail_orders
GROUP BY Customer_Name
ORDER BY Top_custmer_Byprofite DESC
LIMIT 10
;

--  Which customer segment generates the highest sales?
SELECT 
    Segment, ROUND(SUM(Sales), 2) AS Top_Segment_BySale
FROM
    retail_orders
GROUP BY Segment
ORDER BY Top_Segment_BySale DESC
LIMIT 1
;

--  Which customer segment generates the highest profit?
SELECT 
    Segment, ROUND(SUM(Profit), 2) AS Top_Segment_ByProfit
FROM
    retail_orders
GROUP BY Segment
ORDER BY Top_Segment_ByProfit DESC
LIMIT 1
;


-- How many customers belong to each segment?
SELECT 
    Segment, COUNT(*) AS total_cus
FROM
    retail_orders
GROUP BY Segment
;

--  Which customers have placed the most orders?
SELECT 
    Customer_Name, COUNT(DISTINCT Order_ID) AS total_order
FROM
    retail_orders
GROUP BY Customer_Name
ORDER BY total_order DESC
LIMIT 1
;


--  Which customers generated losses?
SELECT 
    Customer_Name, SUM(Profit) AS total_lose
FROM
    retail_orders
GROUP BY Customer_Name
ORDER BY total_lose ASC
LIMIT 1
;

--  What is the average sales per customer?
SELECT 
    Customer_Name, AVG(Sales) AS avg_Sales
FROM
    retail_orders
GROUP BY Customer_Name
ORDER BY avg_Sales DESC
;

--  Which country generates the highest sales?
SELECT 
    Country, ROUND(SUM(Sales), 2) AS Total_sales
FROM
    retail_orders
GROUP BY Country
ORDER BY Total_sales DESC
LIMIT 1
;

--  Which market contributes the highest revenue?
SELECT 
    Market, ROUND(SUM(Sales), 2) AS Total_revenue
FROM
    retail_orders
GROUP BY Market
ORDER BY Total_revenue DESC
LIMIT 1;


--  Which region has the highest number of orders?
SELECT 
    Region, ROUND(count(Order_ID), 2) AS Total_order
FROM
    retail_orders
GROUP BY Region
ORDER BY Total_order DESC
LIMIT 1;

-- Which shipping mode is used the most?
SELECT 
    Ship_Mode, COUNT(*) AS used_times
FROM
    retail_orders
GROUP BY Ship_Mode
ORDER BY used_times DESC
LIMIT 1
;

-- Which shipping mode generates the highest profit?
SELECT 
    Ship_Mode, round(sum(Profit),2)  AS Total_profit
FROM
    retail_orders
GROUP BY Ship_Mode
ORDER BY Total_profit DESC
LIMIT 1
;

-- Which order priority has the highest number of orders?---
SELECT 
    Order_Priority, count(*)  AS Total_order
FROM
    retail_orders
GROUP BY Order_Priority
ORDER BY Total_order DESC
LIMIT 1
;

-- What are the monthly sales trends?
SELECT
    MONTH(Order_Date_New),
    SUM(Sales)
FROM retail_orders
GROUP BY MONTH(Order_Date_New);

ALTER TABLE retail_orders
ADD COLUMN Order_Date_New DATE;

UPDATE retail_orders
SET Order_Date_New = STR_TO_DATE(Order_Date, '%d-%m-%Y');

SET SQL_SAFE_UPDATES = 0;
UPDATE retail_orders
SET Order_Date_New = STR_TO_DATE(Order_Date, '%d-%m-%Y');

SET SQL_SAFE_UPDATES = 1;

SELECT Order_Date, Order_Date_New
FROM retail_orders
;


ALTER TABLE retail_orders
RENAME COLUMN Order_Date_New TO Order_Date;


-- What are the monthly profit trends?
SELECT 
    MONTH(Order_Date_New) AS Monthly_profite,
    ROUND(SUM(Profit), 2) AS Total_profite
FROM
    retail_orders
GROUP BY Monthly_profite
ORDER BY Monthly_profite;

-- Which month has the highest sales?
SELECT 
    MONTH(Order_Date_New) AS Monthly_profite,
    ROUND(SUM(Profit), 2) AS Total_profite
FROM
    retail_orders
GROUP BY Monthly_profite
ORDER BY Monthly_profite
desc
limit 1;

-- What is the profit margin for each category?
SELECT 
    Category,
    ROUND((SUM(Profit) / NULLIF(SUM(Sales), 0)) * 100, 2) AS Profit_margin
FROM
    retail_orders
GROUP BY Category
;

--  Which category has the highest average discount?
SELECT 
    Category, ROUND(AVG(Discount), 2) AS Avg_discount
FROM
    retail_orders
GROUP BY Category
ORDER BY Avg_discount DESC
LIMIT 1;


--  Which products contribute to 80% of total sales?
WITH product_sales AS (
    SELECT 
        Product_Name,
        SUM(Sales) AS Total_Sales
    FROM retail_orders
    GROUP BY Product_Name
),
cumulative_sales AS (
    SELECT
        Product_Name,
        Total_Sales,
        SUM(Total_Sales) OVER (ORDER BY Total_Sales DESC) AS Running_Sales,
        SUM(Total_Sales) OVER () AS Overall_Sales
    FROM product_sales
)
SELECT
    Product_Name,
    Total_Sales,
    ROUND((Running_Sales / Overall_Sales) * 100, 2) AS Cumulative_Percentage
FROM cumulative_sales
WHERE (Running_Sales / Overall_Sales) <= 0.80;


--  Which customer segment is the most profitable?

select  Segment ,
Round(sum(Profit),2) as total_profite
from retail_orders 
group by Segment
order by  total_profite 
desc limit 1
;


--  Which products should be prioritized based on sales and profit?
SELECT 
    Product_Name,
    ROUND(SUM(Profit), 2) AS total_profit,
    ROUND(SUM(Sales), 2) AS total_sale
FROM
    retail_orders
GROUP BY Product_Name
ORDER BY total_profit DESC , total_sale DESC
LIMIT 1
;


