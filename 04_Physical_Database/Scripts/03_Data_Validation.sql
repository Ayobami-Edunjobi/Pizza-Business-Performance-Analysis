-- 1. Validate expected row counts

SELECT 
    Table_Name,
    Actual_Row,
    Expected_Rows,
  CASE
    WHEN Actual_Row =  Expected_Rows THEN 'Pass'
    ELSE 'Fail'
  END AS Validation_Status
FROM(
         SELECT 'Cateory' AS Table_Name,
            COUNT(*) AS Actual_Row, 4 AS Expected_Rows
    FROM Pizza.Category

    UNION ALL

    SELECT 'Customer', COUNT(*), 679
    FROM Pizza.Customer

    UNION ALL

    SELECT 'Address', COUNT(*), 900 
    FROM Pizza.Address

    UNION ALL

    SELECT 'Product', COUNT(*), 30
    FROM Pizza.Product

    UNION ALL 

    SELECT 'Ingredient',COUNT(*), 42
    FROM Pizza.Ingredient

    UNION ALL

    SELECT 'Inventory', COUNT(*), 42
    FROM Pizza.Inventory

    UNION ALL

    SELECT 'Recipe', COUNT(*), 334
    FROM Pizza.Recipe

    UNION ALL

    SELECT 'Staff', COUNT(*), 20
    FROM Pizza.Staff

    UNION ALL

    SELECT 'Shift', COUNT(*), 13
    FROM Pizza.Shift

    UNION ALL

    SELECT 'Rota', COUNT(*), 900
    FROM Pizza.Rota

    UNION ALL

    SELECT 'Orders', COUNT(*), 4500
    FROM Pizza.[Order]

    UNION ALL

    SELECT 'Order_Items', COUNT(*), 12000
    FROM Pizza.Order_Item
) AS RowCountCheck;


-- This query helps to grasp and understand all relationships that exist across all tables. 

SELECT
   OBJECT_SCHEMA_NAME(fk.parent_Object_Id) AS Child_Schema,
   OBJECT_NAME(fk.parent_Object_Id) AS Child_Table,
   fk.name AS Foreign_Key,
   OBJECT_SCHEMA_NAME(fk.referenced_Object_id) AS Parent_Schema,
   OBJECT_NAME(fk.referenced_Object_Id) AS Parent_Table
FROM Sys.foreign_Keys AS Fk
ORDER BY Child_Table, Foreign_Key



-- 2. Validate order and customer relationships

SELECT 
   COUNT(*) AS Invalid_Order_Customer_Relationships
FROM Pizza.[Order] o
LEFT JOIN Pizza.Customer c
  ON o.Customer_Id = c.Customer_Id
WHERE c.Customer_Id IS NULL;

-- 3. Validate order and address relationships

SELECT 
   COUNT(*) AS Invalid_Order_Address_Realtionships
FROM Pizza.[Order] o
LEFT JOIN Pizza.Address a
   ON o.Address_Id = a.Address_Id
WHERE a.Address_Id IS NULL;

-- 4. Validate customer and address mismatch

SELECT
   COUNT(*) AS Customer_Address_Mismatches
FROM Pizza.[order] o
INNER JOIN Pizza.Address a
  ON o.Address_Id = a.Address_Id
WHERE o.Customer_Id <> a. Customer_Id ;

--5. Validate inventory and ingredient relationships

SELECT
  COUNT(*) AS Invalid_Inventory_Ingredient_Relationships
FROM Pizza.Inventory i
LEFT JOIN Pizza.Ingredient ing
 ON i.Ingredient_Id = ing.Ingredient_Id
WHERE ing.Ingredient_Id IS NULL;

--6. Validate order_Item and order relationships

SELECT
   COUNT(*) AS Invalid_Order_Item_Order_Relationships
FROM Pizza.Order_Item oi
LEFT JOIN Pizza.[Order] o
  ON oi.Order_Id = o.Order_Id
WHERE  o.Order_Id IS NULL

--7. Validate order_Item and product relationships

SELECT
   COUNT(*) AS Invalid_Order_Item_Product_Relationships
FROM Pizza.Order_Item oi
LEFT JOIN Pizza.Product p
  ON oi.Product_Id = p.Product_Id
WHERE p.Product_Id IS NULL;

--8. Validate product and category relationships

SELECT
   COUNT(*) AS Invalid_Product_Category_Relationships
FROM Pizza.Product p
LEFT JOIN Pizza.Category c
  ON  p.Category_Id = c.Category_Id
WHERE c.Category_Id IS NULL ;

--9. Validate recipe and ingredient relationships

SELECT
  COUNT(*) AS Invalid_Recipe_Ingredient_Relationships
FROM Pizza.Recipe r
LEFT JOIN Pizza.Ingredient ing
 ON r.Ingredient_Id = ing.Ingredient_Id
WHERE ing.Ingredient_Id IS NULL;

--10. Validate recipe and product relationships

SELECT
  COUNT(*) AS Invalid_Recipe_Ingredient_Relationships
FROM Pizza.Recipe r
LEFT JOIN Pizza.Product p
 ON r.Product_Id = p.Product_Id
WHERE  p.Product_Id IS NULL;


--11. Validate rota and shift relationships

SELECT
  COUNT(*) AS Invalid_Rota_Shift_Relationships
FROM Pizza.Rota r
LEFT JOIN Pizza.Shift s
 ON r.Shift_Id = s.Shift_Id
WHERE s.Shift_Id IS NULL;


--11. Validate rota and staff relationships

SELECT
  COUNT(*) AS Invalid_Rota_Staff_Relationships
FROM Pizza.Rota r
LEFT JOIN Pizza.Staff st
 ON r.Staff_Id = st.Staff_Id
WHERE st.Staff_Id IS NULL;
