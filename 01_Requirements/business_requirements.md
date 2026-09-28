# Pizza Business Requirements

## 1. Project Overview

The objective of this project is to design and implement a bespoke relational database for a pizza business.

The database should capture business-generated information relating to customer orders, stock control, and staff scheduling, and provide a reliable data foundation for business performance analysis and dashboard reporting.

The database design should be driven by the business requirements and rules rather than beginning with directly with SQL implementation.


## 2. Business Requirements

### 2.1 Customer Orders

The business needs to capture information about customer orders, including:
- Customer details
- Product ordered
- Product price
- Quantity ordered
- Product size where applicable
- Order date and time
- Delivery address where applicable
- Product category

  The database should support multiple products within a single order.

  The business should also be able to identify customer ordering activity and frequency.

  ### 2.2 Products and Menu

  The business sells different types of products, including:
  - Pizzas
  - Sides
  - Desserts
  - Beverages
 
     Products may have different sizes where appicable.

     The database should store the current product price while also preserving the price actually charged when an order is placed.

    ### 2.3 Stock Control

     The business needs to monitor ingredients used in product preparation.

    The database should allow the business to:

    - Identify the ingredients required for each product
    - Record the quantity of each ingredient required
    - account for different product sizes where ingredient requirements vary
    - Monitor current ingredient stock
    - Define a reorder level
    - Identity when stock falls below the reorder level
   
      ### 2.4 Staff

      The business needs to maintain little information about its employees, including:

      - First name
      - Last name
      - Role
      - Salary
     
      Staff information should support scheduling and labour-cost analysis.

      ### 2.5 Staff Scheduling
      
      The business wants to know which staff members are assigned to working shifts.

      The database should therefore support:

      - Definition of working shifts
      - Shift start and end times
      - Day of the week
      - Assignment of staff members to shifts
     

       The business operstes:

       - Monday-Saturday: 9:00 AM -8:00 PM
       - Sunday: 12:00 PM - 6:00  PM
     
      ## 3. Business Rules

      The following business rules were identified during the modelling process:

      1. A customer can place one or multiple orders.
      2. An order can contain multiple order_items.
      3. Each order item represents a product purchased as part of an order.
      4. A product belongs to one category.
      5. A product can require multiple ingredients.
      6. An ingredient can be used in multiple products
      7. Ingredient quantities can very according to product size.
      8. A customer can have multiple delivery addresses.
      9. An order may use a delivery address where applicable.
      10. Current stock should be compared against the reorder level to identify replenishment requirements.
      11. Staff members can be assigned to shifts through the rota.
      12. Staff salary information can support labour-cost analysis
      13. Product cost analysis an incorporate ingredient, labour, and delivery costs.
     
      ## 4. Modelling Approach

      The requirements and business rules were translated into a series of data models before physical implementation.

      The modelling process followed:

      Business Requirements → Conceptual Model → Logical Model → Physical Database → SQL Server Implementation

      The conceptual and logical models were designed using dbdiagrams.io before the physical database was implemented in Microsoft SQL Server.

      ## 5. Scope Decisions

      The operational database focuses on the core requirements of:

      - Customer orders
      - Products and categories
      - Ingredients and recipes
      - Inventory
      - Staff
      - Staff scheduling
     
        A dedicated Date dimension is not included in the operational relational database. Transaction date and time are captured through 'Order_Date'. A dedicated Date dimension can be introduced later within the analytical/ reporting layer.

        ## 6. Expected Outcome

        The final database should provide a structured and reliable foundation for:

        - Capturing operational business data
        - Maintaining relationships between business entities
        - Enforcing key business rules through database constraints
        - Performing SQL-based analysis
        - Building power BI dashboards
        - Generating business insights to support decison-making
      
      

      














      












