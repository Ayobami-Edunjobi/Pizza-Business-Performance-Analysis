/*
===========================================================================================================================================
Pizza Business Performance Analysis Physical Database Schema 
Database Platform: Microsoft SQL Server 
Schema: Pizza


Purpose: Creates the physical relational database structure required to support customer orders, products, inventory, staff, scheduling, and business performance analysis.

Important: This script is designed to be rerunnable. Exsisting tables in the pizza schema are dropped before the schema is recreated.

WARNING: Running this script will delete existing data in these tables.
===========================================================================================================================================
*/

-- ==========================================================================================================================================
-- 1. CREATE SCHEMA
-- ==========================================================================================================================================
IF SCHEMA_ID ('Pizza') IS NULL
BEGIN
    EXEC('CREATE SCHEMA Pizza');
END;
GO

-- ==========================================================================================================================================
-- 2. DROP EXISTING TABLES
-- Tables are dropped in reverse dependency order so that existing foreign-key relationships do not prevent the tables from being removed 
-- ============================================================================================================================================
IF OBJECT_iD('Pizza.Rota', 'U') IS NOT NULL
      DROP TABLE Pizza.Rota;
GO

IF OBJECT_iD('Pizza.Shift', 'U') IS NOT NULL
      DROP TABLE Pizza.Shift;
GO

IF OBJECT_iD('Pizza.Inventory', 'U') IS NOT NULL
      DROP TABLE Pizza.Inventory;
GO

IF OBJECT_iD('Pizza.Recipe', 'U') IS NOT NULL
      DROP TABLE Pizza.Recipe;
GO

IF OBJECT_iD('Pizza.Order_Item', 'U') IS NOT NULL
      DROP TABLE Pizza.Order_Item;
GO

IF OBJECT_iD('Pizza.[Order]', 'U') IS NOT NULL
      DROP TABLE Pizza.[Order];
GO

IF OBJECT_iD('Pizza.Product', 'U') IS NOT NULL
      DROP TABLE Pizza.Product;
GO

IF OBJECT_iD('Pizza.Address', 'U') IS NOT NULL
      DROP TABLE Pizza.Address;
GO

IF OBJECT_iD('Pizza.Ingredient', 'U') IS NOT NULL
      DROP TABLE Pizza.Ingredient;
GO

   IF OBJECT_iD('Pizza.Category', 'U') IS NOT NULL
      DROP TABLE Pizza.Category;
GO

IF OBJECT_iD('Pizza.Customer', 'U') IS NOT NULL
      DROP TABLE Pizza.Customer;
GO

-- ============================================================================================
-- 3. CUSTOMER
-- Stores customer information so that customer activity can be analysed across multiple orders.
-- =============================================================================================
CREATE TABLE Pizza.Customer (
    Customer_Id INT IDENTITY (1,1) PRIMARY KEY,
    First_Name VARCHAR(50) NOT NULL,
    Last_Name VARCHAR (50) NOT NULL,
    Gender VARCHAR (20) NULL,
    Birthdate DATE NULL,
    Email VARCHAR (255) NULL UNIQUE,
    Phone VARCHAR (30)  NULL
);
GO

 -- ============================================================================================
 -- 4. CATEGORY
 -- Stores the product categories such as pizzas, sides, desserts, and beverages.
 -- ============================================================================================
CREATE TABLE Pizza.Category (
    Category_Id INT IDENTITY (1,1) PRIMARY KEY,
    Category_Name VARCHAR (50) UNIQUE NOT NULL
 );
 GO

   -- ============================================================================================
  -- 5. INGREDIENT
  -- Stores the raw materials used in preparation of products.
   -- ============================================================================================
  CREATE TABLE Pizza.Ingredient (
     Ingredient_Id INT IDENTITY (1,1) PRIMARY KEY,
     Ingredient_Name VARCHAR (100)  UNIQUE NOT NULL
  );
  GO

       
  -- ============================================================================================
  -- 6. ADDRESS
  -- Stores delivery addresses associated with customers. A customer may have multiple addresses, while each address belongs to one customer.
  -- =============================================================================================
CREATE TABLE Pizza.Address (
    Address_Id VARCHAR (20) PRIMARY KEY,
    Customer_Id INT NOT NULL,
    Address_Line VARCHAR (255) NOT NULL,
    City VARCHAR (100) NOT NULL,

      CONSTRAINTS FK_Address_Customer
          FOREIGN KEY (Customer_Id) 
          REFERENCES Pizza.Customer (Customer_Id) 
  );
  GO
  
 -- ============================================================================================
 -- 7. PRODUCT
 -- It represents each distinct goods the business offers for sale. Current_Price represents the current menu price, while the actual price charged at the time of an order is stored seperately in Order_Item.Unit_Price.
 -- ============================================================================================
CREATE TABLE Pizza.Product (
   Product_Id INT IDENTITY (1,1) PRIMARY KEY,
   Product_Name VARCHAR (100) UNIQUE NOT NULL,
   Category_Id INT NOT NULL,
   Current_Price DECIMAL (10,2) NOT NULL,

  CONSTRAINT FK_Product_Category
     FOREIGN KEY  (Category_Id)
     REFERENCES Pizza.Category (Category_Id),
  
  CONSTRAINT Ck_Current_Price
      CHECK (Current_Price >=0) 
  );
 GO

 -- ============================================================================================
 -- 8. ORDER
 -- Stores the overall customer transaction. Address_Id is nullable because the business can support both delivery and pickup orders.
 -- =============================================================================================
CREATE TABLE Pizza.[Order] (
    Order_Id INT IDENTITY (1,1) PRIMARY KEY,
    Customer_Id INT NOT NULL,
    Order_Date DATETIME2 NOT NULL
    Address_Id VARCHAR(20) NULL,
  
 CONSTRAINT FK_Order_Customer
    FOREIGN KEY (Customer_Id)
    REFERENCES Pizza.Customer (Customer_Id),
  
  CONSTRAINT FK_Order_Address
    FOREIGN KEY (Address_Id)
    REFERENCES Pizza.Address (Address_Id)
);
GO
  
 -- ==============================================================================================
 -- 9. ORDER_ITEM
 -- Represents an individual product line within an order. Unit_Price records the price charged at the time of the transaction rather than relying on the produuct's current menu price
 -- =============================================================================================
CREATE TABLE Pizza.Order_Item (
    Order_Item_Id INT IDENTITY (1,1) PRIMARY KEY,
    Order_Id INT NOT NULL,
    Product_Id INT NOT NULL,
    Quantity INT NOT NULL,
    Unit_Price DECIMAL (10,2) NOT NULL,
    Size VARCHAR (20) NULL,

  CONSTRAINT FK_OrderItem_Product
     FOREIGN KEY (Product_Id) 
     REFERENCES Pizza.Product (Product_Id) ,

  CONSTRAINT CK_OrderItem_Quantity
     CHECK (Quantity) > 0) ,

 CONSTRAINT CK_OrderItem_UnitPrice
     CHECK (Unit_Price >= 0) 
);
GO

  -- ==============================================================================================
  -- 10. RECIPE
  -- Resolves many-to-many relationship between products and ingredients. Quantity_Required records the amount of an ingredient required for a particular product and size.
  -- ==============================================================================================
  CREATE TABLE Pizza.Recipe (
      Recipe_Id INT IDENTITY (1,) PRIMARY KEY,
      Product_Id INT NOT NULL,
      Ingredient_Id INT NOT NULL,
      Quantity_Required DECIMAL (10,3) NOT NULL,
      Size VARCHAR (20) NULL,
      Unit VARCHAR (20) NOT NULL,

      CONSTRAINTS FK_Recipe_Product
         FOREIGN KEY (Product_Id)
         REFERENCES Pizza.Product (Product_Id),
      
      CONSTRAINTS FK_Recipe_Ingredient
         FOREIGN KEY (Ingredient_Id)
         REFERENCES Pizza.Ingredient (Ingredient_Id),

      CONSTRAINTS CK_Recipe_Quantity
         CHECK (Quantity_Required > 0)
     );
     GO

     -- ==============================================================================================
     -- 11. INVENTORY
     -- Stores the current stock position and reorder threshold for each ingredient. The business actually operates with one physical inventory location, with each ingredients having one inventory record.
     -- ==============================================================================================
    CREATE TABLE Pizza.Inventory (
       Inventory_Id INT IDENTITY ( 1,1) PRIMARY KEY,
       Ingredient_Id INT UNIQUE NOT NULL,
       Current_Stock DECIMAL (10,3) NOT NULL,
       Reoder_Level  DECIMAL (10,3) NOT NULL,
       Unit VARCHAR (20) NOT NULL,

       CONSTRAINT Fk_Inventory_Ingredient
          FOREIGN KEY  (Ingredient_Id)
          REFERENCES Pizza.Ingredient (Ingredient_id),

       CONSTRAINT Ck_Inventory_CurrentStock
          CHECK (Current_Stock >= 0),

       CONSTRAINT Ck_Inventory_ReorderLevel
          CHECK (Reoder_Level >= 0)
       );
      GO
        
    -- ==============================================================================================
    -- 12. STAFF
    -- Stores employee information required for staff scheduling and labour-cost analysis.
    -- ==============================================================================================
      CREATE TABLE Pizza.Staff (
          Staff_Id INT IDENTTITY (1,1) PRIMARY KEY,
          First_Name VARCHHAR (50) NOT NULL,
          Last_Name  VARCHAR (50)  NOT NULL,
          Role  VARCHAR (50) NOT NULL,
          Salary DECIMAL (12,2) NOT NULL,

          CONSTRAINT Ck_Staff_Salary
             CHECK (Salary >=0) 
         );
        GO

    -- ==============================================================================================
    -- 13. SHIFT
    -- Defines the working periods available for staff scheduling.
    -- ==============================================================================================
      CREATE TABLE Pizza.Shift (
          Shift_Id INT IDENTITY(1,1) PRIMARY KEY,
          Shift_Name VARCHAR(70) NOT NULL,
          Shift_Time TIME NOT NULL,
          Start_Time TIME NOT NULL,
          End_Time  TIME  NOT NULL,
          Day VARCHAR(20) NOT NULL,

            CONSTRAINT Ck_Shift_Time
                CHECK (End_Time > Start_Time)
           );
          GO

         -- ==============================================================================================
         -- 14. ROTA
         -- Links staff members to their assigned working shifts (associative/scheduling table).
         -- ==============================================================================================
        CREATE TABLE Pizza.Rota (
            Rota_Id INT IDENTITY (1,1) PRIMARY KEY,
            Staff_id INT NOT NULL,
            Shift_Id INT  NOT NULL,

            CONSTRAINT Fk_Rota_Staff
               FOREIGN KEY (Staff_id)
               REFERENCES pizza.Staff (Staff_id),

            CONSTRAINT Fk_Rota_Shift
               FOREIGN KEY (Shift_Id)
               REFERENCES Pizza.Shift (Shift_Id)
            );
            GO

           



           











         

      
      










     




















  
