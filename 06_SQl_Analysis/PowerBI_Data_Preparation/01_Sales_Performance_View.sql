CREATE VIEW  Pizza.SalesPerformance AS 
--Sales Performance: preparing a consolidated sales dataset for Power BI, Dashbordd 1
SELECT 
   oi.Order_Item_Id,
   o.order_Id,
   c.Category_Id,
   p.Product_Id,
   cu.Customer_Id,
   c.Category_Name,
   p.Product_Name,
  CONCAT(cu.First_Name,' ',cu.Last_Name) AS Customer_Name,
  cu.Gender,
  oi.Quantity,
  oi.Unit_Price,
  oi.Size,
  cu.Birthdate,
  o.Order_date,
  cu.Email,
  a. City,
  a. State
FROM Pizza.Order_Item oi
LEFT JOIN Pizza.[Order] o  ON oi.Order_Id =    o.Order_Id
LEFT JOIN Pizza.Product p  ON oi.Product_Id =  p.Product_Id
LEFT JOIN Pizza.Category c ON  p.Category_Id = c.Category_Id
LEFT JOIN Pizza.Customer cu ON o.Customer_Id = cu.Customer_Id
LEFT JOIN Pizza.Address a   ON o.Address_Id =  a.Address_Id ;

SELECT *
FROM Pizza.SalesPerformance
