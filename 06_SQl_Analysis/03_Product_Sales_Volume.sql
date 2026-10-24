-- Which products sell the highest and lowest quantities, and how does sales volume compare with revenue performance.
WITH Cte_Highest_Qunatities AS 
(
SELECT p.Product_Id, p.product_Name,
       SUM(oi.Quantity * oi.Unit_price) Revenue,
       SUM(Quantity) AS Total_sold
FROM Pizza.Order_Item oi
LEFT JOIN Pizza.Product p
  ON p.Product_Id = oi.Product_Id
GROUP BY   p.Product_Id, p.product_Name
)
SELECT Product_Id, Product_Name, Revenue, Total_Quantity_Sold, Rank_row
FROM 
(
SELECT Product_Id,  Product_Name, Revenue,
       Total_Sold AS Total_Quantity_Sold,
       RANK() OVER (ORDER BY Total_Sold DESC) AS Rank_row
FROM  Cte_Highest_Qunatities
)t 
WHERE Rank_row IN (1,30)
     
