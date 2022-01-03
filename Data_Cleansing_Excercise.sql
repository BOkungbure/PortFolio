--- Data cleaning Excercise
SELECT * FROM HousingData.dbo.HousingData;

--- Refining the date to YYYY-MM-DD
--- testing to see if the convert function successfully removes the timestamps from the SaleDate Column
SELECT HousingData.SaleDate, CONVERT(date,HousingData.SaleDate) AS NewSaleDate
FROM HousingData.dbo.HousingData;

--- After verifying that the code runs successfully, it's time to attempt a driect substitution in the HousingData table
UPDATE HousingData.dbo.HousingData
SET HousingData.SaleDate = CONVERT(DATE,HousingData.SaleDate);

--- I tried working on using the update function but this didn't have the desired effect, I'd use ALTER and test the results
ALTER TABLE HousingData.dbo.HousingData
ADD SaleDateRefined Date;

--- I'll attempt updating table directly
UPDATE HousingData.dbo.HousingData
SET HousingData.SaleDateRefined = CONVERT(DATE,HousingData.SaleDate);

--- Refining Property address data
SELECT *
FROM HousingData.dbo.HousingData
WHERE HousingData.PropertyAddress IS NULL;

--- The last query shows that there are 29 rows without data in the property address field,
--- Now since I gone through this data before, I know that the ParcelID field has duplicates and its the duplicates in that filed that are null
--- The approcah I'm going to use is going to be a join, essentially, I'll join the table to itself and use the corresponding entries in Property address to substitute the nulls

--- 1. Ordering the query by parcel ID, We can see that row 159 & 160 have the same ParcelID but 160 has a null value for propertyAdress
SELECT *
FROM HousingData.dbo.HousingData
ORDER BY ParcelID;

--- 2. Joining the table to itself
SELECT *
FROM HousingData.dbo.HousingData a
JOIN HousingData.dbo.HousingData b
	ON a.ParcelID = b.ParcelID
	AND a.[UniqueID ] <> b.[UniqueID ]

--- 3. Narrowing down the columns on display so its easier to see the subsitituion in action
SELECT a.ParcelID, a.PropertyAddress, b.ParcelID, b.PropertyAddress
FROM HousingData.dbo.HousingData a
JOIN HousingData.dbo.HousingData b
	ON a.ParcelID = b.ParcelID
	AND a.[UniqueID ] <> b.[UniqueID ]
WHERE a.PropertyAddress IS NULL;

--- 4. Using ISNULL for the substitution
SELECT a.ParcelID, a.PropertyAddress, b.ParcelID, b.PropertyAddress, ISNULL(a.PropertyAddress, b.PropertyAddress)
FROM HousingData.dbo.HousingData a
JOIN HousingData.dbo.HousingData b
	ON a.ParcelID = b.ParcelID
	AND a.[UniqueID ] <> b.[UniqueID ]
WHERE a.PropertyAddress IS NULL;


--- 5. Updating the table a with the address
UPDATE a
SET PropertyAddress = ISNULL(a.PropertyAddress, b.PropertyAddress)
FROM HousingData.dbo.HousingData a
JOIN HousingData.dbo.HousingData b
	ON a.ParcelID = b.ParcelID
	AND a.[UniqueID ] <> b.[UniqueID ]
WHERE a.PropertyAddress IS NULL;


--- 6. If Step 4 is run again, we see that the query result is blank, meaning are no more null values
SELECT a.ParcelID, a.PropertyAddress, b.ParcelID, b.PropertyAddress, ISNULL(a.PropertyAddress, b.PropertyAddress)
FROM HousingData.dbo.HousingData a
JOIN HousingData.dbo.HousingData b
	ON a.ParcelID = b.ParcelID
	AND a.[UniqueID ] <> b.[UniqueID ]
WHERE a.PropertyAddress IS NULL;


--- Now that we have addresses for all teh entries, one of the things we may want to do is break down the address into cities and states

SELECT PropertyAddress
FROM HousingData.dbo.HousingData;

--- We can split the data in the property address using the delimiter ',' since that's what separates the street address from the city
--- To do that, we'd have to use the SUBSTRING function to isolate the ',' and and split the adress before and after the comma

SELECT
SUBSTRING(
		PropertyAddress,
		1,
		CHARINDEX(',',PropertyAddress)-1
		)
AS Address,
--- This 1st block of code will separate the street address, the next block will isolate the city
SUBSTRING(
		PropertyAddress,
		CHARINDEX(',',PropertyAddress)+1,
		LEN(PropertyAddress)
		)
AS CityAddress

FROM HousingData.dbo.HousingData;

--- After both blocks of code have been run together, You now have the street address and the city adress in their separate columns
--- We still need to update these values as new columns in our table


--- Creating and updating the 1st atble
ALTER TABLE HousingData.dbo.HousingData
ADD PropertyAddressSteet Nvarchar(255);

UPDATE HousingData.dbo.HousingData
SET PropertyAddressSteet = SUBSTRING(PropertyAddress, 1, CHARINDEX(',',PropertyAddress)-1);


--- Creating and updating the 2nd atble
ALTER TABLE HousingData.dbo.HousingData
ADD PropertySplitCity Nvarchar(255);

UPDATE HousingData.dbo.HousingData
SET PropertySplitCity = SUBSTRING(PropertyAddress, CHARINDEX(',',PropertyAddress)+1, LEN(PropertyAddress));


--- New previewing the newly modified table
SELECT * FROM HousingData.dbo.HousingData;