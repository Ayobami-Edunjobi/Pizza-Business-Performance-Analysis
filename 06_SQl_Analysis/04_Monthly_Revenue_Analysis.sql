-- How does sales revenue change over time, and which months generates the highest and lowest revenue
SELECT 
   Order_Year,
   Order_Month,
   Revenue,
   Rnk
FROM
(
SELECT 
   DATENAME(YEAR, o.Order_Date) AS Order_Year,
   DATENAME(Month, o.Order_Date) AS Order_Month,
   SUM(Quantity * Unit_Price) AS Revenue,
   DENSE_RANK() OVER (ORDER BY SUM(Quantity * Unit_Price) DESC ) Rnk
FROM Pizza.Order_Item oi
INNER JOIN Pizza.[Order] o
   ON oi.Order_Id = o.Order_Id
GROUP BY  DATENAME(YEAR, o.Order_Date),
     DATENAME(Month, o.Order_Date)
) t
 WHERE Rnk IN (1,24)
