/**** Querying all tables ****/

SELECT * FROM salesdb..Customers;/***Customer Table****/
SELECT * FROM salesdb..Employees;/***Employees Table****/
SELECT * FROM salesdb..Products;/***Products Table****/
SELECT * FROM salesdb..Sales;/***Sales Table****/


/***The queries below are to demonstrate the different views in the different types of joins****/
/***INNER JOIN****/

SELECT * FROM salesdb..Sales
	INNER JOIN salesdb..Products ON
	Sales.ProductID = Products.ProductID;


/***LEFT JOIN****/
SELECT * FROM salesdb..Sales
	LEFT JOIN salesdb..Products ON
	Sales.ProductID = Products.ProductID;

/***RIGHT JOIN****/
SELECT * FROM salesdb..Sales
	RIGHT JOIN salesdb..Products ON
	Sales.ProductID = Products.ProductID;

/***FULL OUTER JOIN****/
SELECT* FROM salesdb..Sales
	FULL OUTER JOIN salesdb..Products ON
	Sales.ProductID = Products.ProductID;


/***Using a left join to combine the product table to the sales table, I decided to add extra formatting to the item price and total sales calculation,
mainly for presentation, incase consumers of the information need to see the currency & commas****/
SELECT Sales.SalesPersonID, Sales.CustomerID, Sales.ProductID, Products.Name, Sales.Quantity, 
	FORMAT (Products.Price,'$###,###,###,###') AS 'Unit Price',
	FORMAT (Sales.Quantity * Products.Price, '$###,###,###,###') AS TotalSales
	FROM salesdb..Sales
	LEFT JOIN salesdb..Products ON
	Sales.ProductID = Products.ProductID;

/***Now, I'm going to pull the customer names as well as employee names in to the new join query****/
SELECT
	Sales.SalesPersonID, 
	CONCAT (Employees.FirstName,' ',Employees.LastName) AS 'Sales Person',
	Sales.CustomerID,
	CONCAT (Customers.FirstName,' ',Customers.LastName) AS 'Customer Name',
	Sales.ProductID,
	Products.Name,
	Sales.Quantity, 
	FORMAT (Products.Price,'$###,###,###,###') AS 'Unit Price',
	FORMAT (Sales.Quantity * Products.Price, '$###,###,###,###') AS 'Total Sales'
	FROM salesdb..Sales
	JOIN salesdb..Products ON Sales.ProductID = Products.ProductID
	JOIN salesdb..Employees ON Sales.SalesPersonID = Employees.EmployeeID
	JOIN salesdb..Customers ON Sales.CustomerID = Customers.CustomerID
	;

/***Creating general sales viewfrom above query****/
CREATE VIEW "TotalSalesData" AS 
SELECT
	Sales.SalesPersonID, 
	CONCAT (Employees.FirstName,' ',Employees.LastName) AS 'Sales Person',
	Sales.CustomerID,
	CONCAT (Customers.FirstName,' ',Customers.LastName) AS 'Customer Name',
	Sales.ProductID,
	Products.Name,
	Sales.Quantity, 
	FORMAT (Products.Price,'$###,###,###,###') AS 'Unit Price',
	FORMAT (Sales.Quantity * Products.Price, '$###,###,###,###') AS 'Total Sales'
	FROM salesdb..Sales
	JOIN salesdb..Products ON Sales.ProductID = Products.ProductID
	JOIN salesdb..Employees ON Sales.SalesPersonID = Employees.EmployeeID
	JOIN salesdb..Customers ON Sales.CustomerID = Customers.CustomerID
	;
SELECT * FROM TotalSalesData;

/***Creating a city tabel for canadian cities and provinces****/

DROP TABLE IF EXISTS canadacities;
CREATE TABLE canadacities (
  city VARCHAR(120),
  city_ascii VARCHAR(120),
  province_id VARCHAR(2),
  province_name VARCHAR(50),
  lat VARCHAR(20),
  lng VARCHAR(20),
  population FLOAT,
  density FLOAT,
  timezone VARCHAR(120),
  ranking INT,
  postal VARCHAR(4000),
  id VARCHAR(10)
)
/***SELECT RAND(salesdb..Customers)***/

SELECT * FROM canadacities;

/***Updating the customer tables to include location****/

ALTER TABLE salesdb..Customers ADD
	city VARCHAR(120);

SELECT * FROM salesdb..Customers;
UPDATE salesdb..Customers