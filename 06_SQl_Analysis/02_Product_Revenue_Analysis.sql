-- Which individual Products generate the most revenue ?
SELECT Product_Id,Product_Name, Revenue, Most_revenue 
FROM (
SELECT 
  Product_Id,
  Product_Name,
  Revenue,
  RANK() OVER (ORDER BY Revenue DESC) Most_revenue
FROM (
SELECT 
    p.Product_Id,
    p.Product_Name,
    SUM(o.Quantity * o.Unit_Price) AS Revenue
 FROM Pizza.Product p
 INNER JOIN Pizza.Order_Item o
 ON p.Product_Id = o.Product_Id
 GROUP BY  p.Product_Id,
           p.Product_Name) t) t
 WHERE Most_revenue = 1
