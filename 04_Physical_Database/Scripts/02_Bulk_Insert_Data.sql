/*
=========================================================================================================================
Pizza Business Performance Analysis

Script: 02_Bulk_Insert_Data.sql

Purpose:
  Load the synthetic source data from CSV files into the corresponding tables in the Pizza database.

Prerequisites:
  1. The Pizza database and destination tables must exist.
  2. All 12 CSV files must be available to SQL Server.
  3. File paths must be updated for the user's environment.
  4. CSV column order and data types must match the destination tables.

Important:
  Run the imports only when the destination tables are ready
  Check for existing records before rerunning imports to avoid duplicate data or primary-key conflicts.
=========================================================================================================================
*/

USE PizzaBusiness;
GO

-- ======================================================================================================================
-- 1. Import the Customer records from the source CSV

BULK INSERT Pizza.Customer
FROM 'C:\Users\HP\OneDrive\Pizza Business Data\Customer.csv'
WITH (
FIRSTROW = 2,
FIELDTERMINATOR = ',',
ROWTERMINATOR = '0X0a',
KEEPIDENTITY,
TABLOCK
);
GO
SELECT *
FROM Pizza.Customer
ORDER BY Customer_Id;

-- ======================================================================================================================
-- 2. Import the Category records from the source CSV

BULK INSERT Pizza.Category
FROM 'C:\Users\HP\OneDrive\Pizza Business Data\Category.csv'
WITH (
FIRSTROW = 2,
FIELDTERMINATOR = ',',
ROWTERMINATOR = '0X0a',
KEEPIDENTITY,
TABLOCK
);
GO
SELECT *
FROM Pizza.Category
ORDER BY Category_Id;

-- =======================================================================================================================
-- 3. Import the Ingredient records from the source CSV

BULK INSERT Pizza.Ingredient
FROM 'C:\Users\HP\OneDrive\Pizza Business Data\Ingredient.csv'
WITH (
FIRSTROW = 2,
FIELDTERMINATOR = ',',
ROWTERMINATOR = '0X0a',
KEEPIDENTITY,
TABLOCK
);
GO
SELECT *
FROM Pizza.Ingredient
ORDER BY Ingredient_Id;

-- ======================================================================================================================
-- 4. Import the Address records from the source CSV

BULK INSERT Pizza.Address
FROM 'C:\Users\HP\OneDrive\Pizza Business Data\Address.csv'
WITH (
FIRSTROW = 2,
FIELDTERMINATOR = ',',
ROWTERMINATOR = '0X0a',
KEEPIDENTITY,
TABLOCK
);
GO
SELECT *
FROM Pizza.Address
ORDER BY Address_Id;

-- ======================================================================================================================
-- 5. Import the Product records from the source CSV

BULK INSERT Pizza.Product
FROM 'C:\Users\HP\OneDrive\Pizza Business Data\Products.csv'
WITH (
FIRSTROW = 2,
FIELDTERMINATOR = ',',
ROWTERMINATOR = '0X0a',
KEEPIDENTITY,
TABLOCK
);
GO
SELECT *
FROM Pizza.Product
ORDER BY Product_Id;

-- ======================================================================================================================
-- 6. Import the [Order] records from the source CSV

BULK INSERT Pizza.[Order]
FROM 'C:\Users\HP\OneDrive\Pizza Business Data\Orders.csv'
WITH (
FIRSTROW = 2,
FIELDTERMINATOR = ',',
ROWTERMINATOR = '0X0a',
KEEPIDENTITY,
TABLOCK
);
GO
SELECT *
FROM Pizza.[Order]
ORDER BY Order_Id;

-- ======================================================================================================================
-- 7. Import the Order_Item records from the source CSV

BULK INSERT Pizza.Order_Item
FROM 'C:\Users\HP\OneDrive\Pizza Business Data\Order_Item.csv'
WITH (
FIRSTROW = 2,
FIELDTERMINATOR = ',',
ROWTERMINATOR = '0X0a',
KEEPIDENTITY,
TABLOCK
);
GO
SELECT *
FROM Pizza.Order_Item
ORDER BY Order_item_Id;

-- ======================================================================================================================
-- 8. Import the Recipe records from the source CSV
BULK INSERT Pizza.Recipe
FROM 'C:\Users\HP\OneDrive\Pizza Business Data\Recipe.csv'
WITH (
FIRSTROW = 2,
FIELDTERMINATOR = ',',
ROWTERMINATOR = '0X0a',
KEEPIDENTITY,
TABLOCK
);
GO
SELECT *
FROM Pizza.Recipe
ORDER BY Recipe_Id;

-- ======================================================================================================================
-- 9. Import the Inventory records from the source CSV

BULK INSERT Pizza.Inventory
FROM 'C:\Users\HP\OneDrive\Pizza Business Data\Inventory.csv'
WITH (
FIRSTROW = 2,
FIELDTERMINATOR = ',',
ROWTERMINATOR = '0X0a',
KEEPIDENTITY,
TABLOCK
);
GO
SELECT *
FROM Pizza.Inventory
ORDER BY Inventory_Id;

-- ======================================================================================================================
-- 10. Import the Staff records from the source CSV

BULK INSERT Pizza.Staff
FROM 'C:\Users\HP\OneDrive\Pizza Business Data\Staff.csv'
WITH (
FIRSTROW = 2,
FIELDTERMINATOR = ',',
ROWTERMINATOR = '0X0a',
KEEPIDENTITY,
TABLOCK
);
GO
SELECT *
FROM Pizza.Staff
ORDER BY Staff_Id;

-- ======================================================================================================================
-- 11. Import the Shift records from the source CSV

BULK INSERT Pizza.Shift
FROM 'C:\Users\HP\OneDrive\Pizza Business Data\Shift.csv'
WITH (
FIRSTROW = 2,
FIELDTERMINATOR = ',',
ROWTERMINATOR = '0X0a',
KEEPIDENTITY,
TABLOCK
);
GO
SELECT *
FROM Pizza.Shift
ORDER BY Shift_Id;

-- ======================================================================================================================
-- 12. Import the Rota records from the source CSV

BULK INSERT Pizza.Rota
FROM 'C:\Users\HP\OneDrive\Pizza Business Data\Rota.csv'
WITH (
FIRSTROW = 2,
FIELDTERMINATOR = ',',
ROWTERMINATOR = '0X0a',
KEEPIDENTITY,
TABLOCK
);
GO
SELECT *
FROM Pizza.Rota
ORDER BY Rota_Id;







