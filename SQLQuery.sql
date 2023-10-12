/* Creating a database called Pizza_Sales */
CREATE DATABASE PIZZA_SALES;
USE PIZZA_SALES;

/* Table creation and data importing has been done using SSMS UI */
SELECT * FROM SALES_TABLE;

/* Total Revenue */
SELECT ROUND(SUM(SALES_TABLE.total_price),2) AS Total_Revenue
FROM SALES_TABLE;

/* Average Order Value */

WITH Total_Revenue_CTE AS
(SELECT ROUND(SUM(SALES_TABLE.total_price),2) AS Total_Revenue
FROM SALES_TABLE),
Count_of_Orders_CTE AS
(SELECT COUNT(DISTINCT(SALES_TABLE.order_id)) AS Count_of_Orders
FROM SALES_TABLE)

SELECT ROUND(Total_Revenue_CTE.Total_Revenue/Count_of_Orders_CTE.Count_of_Orders,2) AS Average_Order_Value
FROM Total_Revenue_CTE,Count_of_Orders_CTE;


/* Total Pizza Sold */

SELECT SUM(SALES_TABLE.quantity) AS Total_Pizza_Sold
FROM SALES_TABLE;

/* Total Orders Placed */

SELECT COUNT(DISTINCT(SALES_TABLE.order_id)) AS Total_Pizza_Sold
FROM SALES_TABLE;

/* Average Pizzas Per Order */

WITH Total_Pizza_Sold_CTE AS
(SELECT SUM(SALES_TABLE.quantity) AS Total_Pizza_Sold
FROM SALES_TABLE),
Count_of_Orders_CTE AS
(SELECT COUNT(DISTINCT(SALES_TABLE.order_id)) AS Count_of_Orders
FROM SALES_TABLE)

SELECT Total_Pizza_Sold_CTE.Total_Pizza_Sold/Count_of_Orders_CTE.Count_of_Orders AS Average_Pizzas_Per_Order
FROM Total_Pizza_Sold_CTE,Count_of_Orders_CTE;

/* Daily Trend For Total Orders */

SELECT DATENAME(DW,SALES_TABLE.order_date) AS Order_Day, COUNT(DISTINCT SALES_TABLE.order_id) AS Total_Orders
FROM SALES_TABLE
GROUP BY DATENAME(DW,SALES_TABLE.order_date)
ORDER BY 2 DESC;

/* Monthly Trend For Total Orders */

SELECT DATENAME(MONTH,SALES_TABLE.order_date) AS Month_Name, COUNT(DISTINCT SALES_TABLE.order_id) AS Total_Orders
FROM SALES_TABLE
GROUP BY DATENAME(MONTH,SALES_TABLE.order_date)
ORDER BY 2 DESC;

/* Percentage of Sales by Pizza Category */

SELECT SALES_TABLE.pizza_category As Pizza_Category, ROUND(SUM(SALES_TABLE.total_price),2) AS Total_Sales,
ROUND(SUM(SALES_TABLE.total_price) * 100 /(SELECT SUM(SALES_TABLE.total_price) FROM SALES_TABLE),2) AS Total_Sales_Percentage
From SALES_TABLE
GROUP BY pizza_category
ORDER BY 2 DESC;

/* Executing Store Procedure to find out Month wise total sales and percentage of sales of a pizza category */

EXEC Sales_by_Pizza_Category 1 ;


/* Percentage of Sales by Pizza Size */

SELECT 
CASE 
WHEN SALES_TABLE.pizza_size = 'L' THEN 'LARGE'
WHEN SALES_TABLE.pizza_size = 'M' THEN 'MEDIUM'
WHEN SALES_TABLE.pizza_size = 'S' THEN 'SMALL'
WHEN SALES_TABLE.pizza_size = 'XL' THEN 'EXTRA_LARGE'
ELSE '2EXTRA_LARGE'
END AS Pizza_Size, 
CAST(SUM(SALES_TABLE.total_price) AS DECIMAL(10,2)) AS Total_Sales,
CAST(SUM(SALES_TABLE.total_price) * 100 /(SELECT SUM(SALES_TABLE.total_price) FROM SALES_TABLE) AS DECIMAL(10,2)) AS Total_Sales_Percentage
From SALES_TABLE
GROUP BY pizza_size
ORDER BY 2 DESC;


/* Executing Store Procedure to find out Quater wise total sales and percentage of sales of a pizza category */

EXEC Sales_by_Pizza_Size_QTR 1 ;

/* Top five Best Sellers by Revenue */

SELECT TOP 5 SALES_TABLE.pizza_name AS Pizza_Name, CAST(SUM(SALES_TABLE.total_price) AS DECIMAL(10,2)) AS Total_Revenue
FROM SALES_TABLE
GROUP BY Pizza_Name
ORDER BY 2 DESC;

/* Bottom five Worst Sellers by Revenue */

SELECT TOP 5 SALES_TABLE.pizza_name AS Pizza_Name, CAST(SUM(SALES_TABLE.total_price) AS DECIMAL(10,2)) AS Total_Revenue
FROM SALES_TABLE
GROUP BY Pizza_Name
ORDER BY 2 ASC;

/* Top five Best Sellers by Total Quantity */

SELECT TOP 5 SALES_TABLE.pizza_name AS Pizza_Name, SUM(SALES_TABLE.quantity) AS Total_Quantity
FROM SALES_TABLE
GROUP BY Pizza_Name
ORDER BY 2 DESC;

/* Bottom five Worst Sellers by Total Quantity */

SELECT TOP 5 SALES_TABLE.pizza_name AS Pizza_Name, SUM(SALES_TABLE.quantity) AS Total_Quantity
FROM SALES_TABLE
GROUP BY Pizza_Name
ORDER BY 2 ASC;

/* Top five Best Sellers by Total Orders */

SELECT TOP 5 SALES_TABLE.pizza_name AS Pizza_Name, COUNT(DISTINCT SALES_TABLE.order_id) AS Total_Orders
FROM SALES_TABLE
GROUP BY Pizza_Name
ORDER BY 2 DESC;

/* Bottom five Worst Sellers by Total Orders */

SELECT TOP 5 SALES_TABLE.pizza_name AS Pizza_Name, COUNT(DISTINCT SALES_TABLE.order_id) AS Total_Orders
FROM SALES_TABLE
GROUP BY Pizza_Name
ORDER BY 2 ASC;
