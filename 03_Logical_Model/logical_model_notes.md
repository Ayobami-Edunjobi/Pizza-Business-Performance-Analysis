# Logical Data Model
## purpose

The logical data model translates the conceptual model into a structured representation of the data required to support the pizza business.
It defines the entities, attributes, primary keys, foreign keys, and relationships required before implementation in a physical relational database.

## key Modelling Decisions

### Customer
Customer represents individual who purchases products from the Pizza business and whose information maybe maintain to support order tracking and customer analysis over time.
'Birthdate' is used instead of storing 'Age' because age changes over time and can be derived from the birthdate

### Order and Order_Item
'Order' represents the overall customer transaction, while 'Order_Item' represents the individual product contained within an order.
This separation allows one order to contain multiple products.

### product and Category
Products are from separated from categories so that products can be grouped into business categories such as pizzas, sides, desserts, and beverages.

### Unit_Price
'Unit_Price' is stored in Order_Item because the prize charged at the time of an order may differ from the product's current menu price.

Order-Line amounts and order totals can therefore be calculated rather than permanently stored.

### Address
Addresses are stored separately from customers because a customer may have more than one delivery address.

Each order records the address used for that particular delivery.

### Recipe
'Recipe' resolves the many-to-many relationship between products and ingredients.

it also records the quantity and unit of an ingredient required for a particular product and size.

### Inventory
Inventory records the current stock level and reorder level for each ingredient.

A reorder requirement can be derived by comparing current stock against the reorder level.

### Staff, Rota, and Shift
'Staff' stores employee information

'Shift' defines working periods, while

'Rota' records which staff members are assigned to those shifts. 

### Date
A separate Date entity is not included in the operational relational model.

'Order_Date' records the transaction date and time. A dedicated Date dimension can later be created in Power BI for analytical reporting.


## Assumptions
- A customer can place one or more orders.
- An order can contain multiple order items.
- A product belongs to one category.
- A product can require multiple ingredients.
- Ingredient requirements can vary by product size.
- A customer can have multiple delivery addresses.
- An ingredient has an associated inventory record.
- Staff members can be assigned to shifts through the rota.
- Reorder requirements are derived from the current stock and reorder level.

  ## Next Stage
  The logical model will be translated into a physical relational database using SQL Server, where data types, constraints, indexes, and implementation-specific rules will be defined.
  




