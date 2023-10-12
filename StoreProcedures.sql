
USE PIZZA_SALES;

/* Store Procedure to find Month wise total sales and percentage of sales of a pizza category */

CREATE PROCEDURE Sales_by_Pizza_Category @Month_Number int
AS
SELECT SALES_TABLE.pizza_category As Pizza_Category, ROUND(SUM(SALES_TABLE.total_price),2) AS Total_Sales,
ROUND(SUM(SALES_TABLE.total_price) * 100 /(SELECT SUM(SALES_TABLE.total_price) FROM SALES_TABLE WHERE MONTH(order_date) = @Month_Number),2) AS Total_Sales_Percentage
From SALES_TABLE
WHERE MONTH(order_date) = @Month_Number
GROUP BY pizza_category
ORDER BY 2 DESC;

/* Store Procedure to Quater wise total sales and percentage of sales of a pizza category */

CREATE PROCEDURE Sales_by_Pizza_Size_QTR @QTR int
AS
SELECT CASE 
WHEN SALES_TABLE.pizza_size = 'L' THEN 'LARGE'
WHEN SALES_TABLE.pizza_size = 'M' THEN 'MEDIUM'
WHEN SALES_TABLE.pizza_size = 'S' THEN 'SMALL'
WHEN SALES_TABLE.pizza_size = 'XL' THEN 'EXTRA_LARGE'
ELSE '2EXTRA_LARGE'
END AS Pizza_Size, CAST(SUM(SALES_TABLE.total_price) AS DECIMAL(10,2)) AS Total_Sales,
CAST(SUM(SALES_TABLE.total_price) * 100 /(SELECT SUM(SALES_TABLE.total_price) FROM SALES_TABLE WHERE DATEPART(QUARTER,order_date) = @QTR) AS DECIMAL(10,2)) AS Total_Sales_Percentage
From SALES_TABLE
WHERE DATEPART(QUARTER,order_date) = @QTR
GROUP BY pizza_size
ORDER BY 2 DESC;