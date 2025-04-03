SQL Query to transform into 1NF:
SELECT OrderID, CustomerName, TRIM(product) AS Product
FROM (
    SELECT OrderID, CustomerName, 
           UNNEST(string_to_array(Products, ', ')) AS product
    FROM ProductDetail
) AS normalized_products
ORDER BY OrderID;
SQL Query to transform into 2NF:
Step 1: Create the Orders table
CREATE TABLE Orders (
    OrderID INT PRIMARY KEY,
    CustomerName VARCHAR(100)
);

-- Insert distinct orders
INSERT INTO Orders (OrderID, CustomerName)
SELECT DISTINCT OrderID, CustomerName
FROM OrderDetails;
Step 2: Create the OrderDetails table
CREATE TABLE OrderDetails (
    OrderID INT,
    Product VARCHAR(100),
    Quantity INT,
    PRIMARY KEY (OrderID, Product),
    FOREIGN KEY (OrderID) REFERENCES Orders(OrderID)
);

-- Insert product details for each order
INSERT INTO OrderDetails (OrderID, Product, Quantity)
SELECT OrderID, Product, Quantity
FROM OrderDetails;



