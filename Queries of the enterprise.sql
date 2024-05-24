-- Which product is the worst-selling?
SELECT 
    produ.ProductName, COUNT(orders.ProductID) AS sells
FROM
    enterprise.orderdetails AS orders
        LEFT JOIN
    products AS produ ON produ.ProductID = orders.ProductID
GROUP BY orders.ProductID, produ.ProductName
ORDER BY sells ASC;

-- "Mishi Kobe Niku", "Røgede sild", "Chocolade", and "Laughing Lumberjack Lager" are the worst-selling
-- But
-- Which product is the best-selling?
SELECT 
    produ.ProductName, COUNT(orders.ProductID) AS sells
FROM
    enterprise.orderdetails AS orders
        LEFT JOIN
    products AS produ ON produ.ProductID = orders.ProductID
GROUP BY orders.ProductID, produ.ProductName
ORDER BY sells DESC;

-- "Raclette Courdavault", "Gorgonzola Telino", and "Mozzarella di Giovanni" are the best-sellers
-- But they may not be the most profitable products
-- So, which products generated the most revenue?

SELECT 
    pr.ProductName, SUM(orde.Quantity * pr.Price) AS revenue
FROM
    orderdetails AS orde
        LEFT JOIN
    products AS pr ON pr.ProductID = orde.ProductID
GROUP BY orde.ProductID, pr.ProductName
ORDER BY revenue DESC;

-- And, which products generated the least revenue?
SELECT 
    pr.ProductName, SUM(orde.Quantity * pr.Price) AS revenue
FROM
    orderdetails AS orde
        LEFT JOIN
    products AS pr ON pr.ProductID = orde.ProductID
GROUP BY orde.ProductID, pr.ProductName
ORDER BY revenue ASC;

-- Which supplier provides the most revenue-generating product?
SELECT 
    suppliers.SupplierName, SUM(orde.Quantity * pr.Price) AS revenue
FROM
    orderdetails AS orde
        LEFT JOIN
    products AS pr ON pr.ProductID = orde.ProductID
        JOIN
    suppliers ON suppliers.SupplierID = pr.SupplierID
GROUP BY suppliers.SupplierID, suppliers.SupplierName
ORDER BY revenue DESC
LIMIT 1;

-- Which employee generates the most revenue?
SELECT 
    employees.EmployeeID,
    employees.FirstName,
    SUM(orderdetails.Quantity * products.Price) AS TotalSales
FROM
    employees
        JOIN
    orders ON orders.EmployeeID = employees.EmployeeID
        JOIN
    orderdetails ON orders.OrderID = orderdetails.OrderID
        JOIN
    products ON products.ProductID = orderdetails.ProductID
GROUP BY employees.EmployeeID, employees.FirstName
ORDER BY TotalSales DESC
LIMIT 1;

-- And which employee generates the least revenue?
SELECT 
    employees.EmployeeID,
    employees.FirstName,
    SUM(orderdetails.Quantity * products.Price) AS TotalSales
FROM
    employees
        JOIN
    orders ON orders.EmployeeID = employees.EmployeeID
        JOIN
    orderdetails ON orders.OrderID = orderdetails.OrderID
        JOIN
    products ON products.ProductID = orderdetails.ProductID
GROUP BY employees.EmployeeID, employees.FirstName
ORDER BY TotalSales ASC
LIMIT 1;

-- Who is the best customer?
SELECT 
    customers.CustomerName,
    SUM(orderdetails.Quantity * products.Price) AS Buys
FROM
    customers
        JOIN
    orders ON orders.CustomerID = customers.CustomerID
        JOIN
    orderdetails ON orders.OrderID = orderdetails.OrderID
        JOIN
    products ON products.ProductID = orderdetails.ProductID
GROUP BY customers.CustomerID, customers.CustomerName
ORDER BY Buys DESC
LIMIT 1;

-- Which city does this customer come from?
SELECT 
    customers.CustomerName, customers.City,
    SUM(orderdetails.Quantity * products.Price) AS Buys
FROM
    customers
        JOIN
    orders ON orders.CustomerID = customers.CustomerID
        JOIN
    orderdetails ON orders.OrderID = orderdetails.OrderID
        JOIN
    products ON products.ProductID = orderdetails.ProductID
GROUP BY customers.CustomerID, customers.CustomerName, customers.City
ORDER BY Buys DESC
LIMIT 1;

-- Which employee generates the most revenue with the customer called "Maison Dewey"?
SELECT 
    employees.EmployeeID, employees.FirstName, SUM(orderdetails.Quantity * products.Price) AS revenue
FROM
    employees
        JOIN
    orders ON orders.EmployeeID = employees.EmployeeID
        JOIN
    customers ON orders.CustomerID = customers.CustomerID
        JOIN
    orderdetails ON orderdetails.OrderID = orders.OrderID
        JOIN
    products ON products.ProductID = orderdetails.ProductID
WHERE
    customers.CustomerName = 'Maison Dewey'
GROUP BY employees.EmployeeID, employees.FirstName
ORDER BY revenue DESC
LIMIT 1;

-- I didn't find anything, so I will see if this "customer" has orders
SELECT * 
FROM Orders 
WHERE CustomerID = (SELECT CustomerID FROM Customers WHERE CustomerName = 'Maison Dewey');

-- It doesn't have orders
--

-- Let's try with the next customer with an ID of 51
SELECT 
    Employees.EmployeeID,
    Employees.FirstName,
    SUM(OrderDetails.Quantity * Products.Price) AS TotalRevenue
FROM 
    Employees
JOIN 
    Orders ON Employees.EmployeeID = Orders.EmployeeID
JOIN 
    OrderDetails ON Orders.OrderID = OrderDetails.OrderID
JOIN 
    Products ON OrderDetails.ProductID = Products.ProductID
JOIN 
    Customers ON Orders.CustomerID = Customers.CustomerID
WHERE 
    Customers.CustomerID = 51
GROUP BY 
    Employees.EmployeeID, 
    Employees.FirstName
ORDER BY 
    TotalRevenue DESC
LIMIT 1;

-- Robert has a good relationship with that client

