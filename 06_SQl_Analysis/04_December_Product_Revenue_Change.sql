 -- Which products contributed most to the change in revenue between December 2024 and December 2025?
 WITH Cte_Product_Name AS (
 SELECT  Product_Id, Product_Name, Order_Year, Order_Month, Revenue
 FROM (
 SELECT p.Product_Name, p.Product_Id, DATENAME(YEAR, o.Order_Date) AS Order_Year, DATENAME(Month,o.Order_Date) AS Order_Month,
        SUM(Quantity * Unit_Price) AS  Revenue,
        SUM(Quantity) AS Total_Unit_Sold,
        COUNT(DISTINCT oi.Order_Id) AS Total_Orders
 FROM Pizza.Order_Item oi
 LEFT JOIN Pizza.[Order] o
    ON oi.Order_Id = o.Order_Id 
 LEFT JOIN Pizza.Product p
    ON oi.Product_Id = p.Product_Id
 WHERE     DATENAME(Month, o.Order_Date) = 'December'
 GROUP BY  DATENAME(YEAR, o. Order_Date), DATENAME(Month, o.Order_Date),  p.Product_Id,  p.Product_Name)t
)
SELECT  Product_Id, Product_Name, 
        COALESCE (SUM(CASE WHEN Order_Year  = 2024 THEN Revenue END),0) AS Revenue_2024,
       COALESCE  (SUM(CASE WHEN Order_Year = 2025 THEN Revenue END),0) AS Revenue_2025,
COALESCE(SUM(CASE WHEN Order_Year = 2025 THEN Revenue END),0) - COALESCE(SUM(CASE WHEN Order_Year  = 2024 THEN Revenue END),0) AS Revenue_Change
 FROM  Cte_Product_Name
 GROUP BY Product_Id, Product_Name
 ORDER BY Revenue_Change DESC 
