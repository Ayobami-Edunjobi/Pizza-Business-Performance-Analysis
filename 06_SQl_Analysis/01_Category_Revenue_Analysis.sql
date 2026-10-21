-- Which product categories generate the most sales revenue, and how much revenue does each category contribute?

WITH Cte_Overall_Sales AS (
 SELECT 
    c.Category_Id,c.Category_name,
    COUNT(*) AS Order_Item_Records,
    SUM(oi.Quantity) AS units_Sold,
    SUM(oi.Quantity * oi.Unit_Price) AS Revenue
 FROM  Pizza.Order_Item oi
 INNER JOIN Pizza.Product p   ON oi.Product_Id = p.Product_Id 
 INNER JOIN Pizza.Category c  ON p.Category_Id = c.Category_Id
  GROUP BY c.Category_Id,  c.Category_name
)
 SELECT
   Category_Name, Order_Item_Records, units_Sold, Revenue,
   SUM(Revenue) OVER () Overall_Sales,
   CONCAT(ROUND((CAST(Revenue AS FLOAT)/ SUM(Revenue) OVER ()) * 100, 2), '%') AS Percentage_Of_total
FROM Cte_Overall_Sales
ORDER BY Revenue DESC;

-- Pizza🍕 accounted for approximately 83.4% of total recorded revenue, making it the leading generating category in this dataset.

--Slides🍳 contributed approximately 9.8%.

--Beverages 🧃 contributed approximately 3.9%.

--Desserts🍰 contributed approximately 3.0%.
