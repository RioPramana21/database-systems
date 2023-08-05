USE FishingMania

-- 1
SELECT FishermanID, FishermanName
FROM MsFisherman
WHERE FishermanID IN ('FS001', 'FS003', 'FS011')

-- 2
SELECT FishName, FishPrice
FROM MsFish
WHERE FishTypeID IN (
	SELECT FishTypeID
	FROM MsFishType
	WHERE FishTypeName NOT IN ('Marlin', 'Grouper', 'Bass')
)

-- 3
SELECT CustomerName, CustomerEmail
FROM MsCustomer
WHERE CustomerGender = 'male'
AND CustomerID NOT IN (
	SELECT CustomerID FROM TransactionHeader
)

-- 4
SELECT FishTypeName, FishName, FishPrice
FROM MsCustomer mc
JOIN TransactionHeader th
ON mc.CustomerID = th.CustomerID
JOIN TransactionDetail td
ON td.TransactionID = th.TransactionID
JOIN MsFish mf
ON mf.FishID = td.FishID
JOIN MsFishType mft
ON mf.FishTypeID = mft.FishTypeID
WHERE CustomerGender = 'female'
AND TransactionDate IN (
	SELECT TransactionDate FROM TransactionHeader
	WHERE DATENAME(QUARTER, TransactionDate) = 2
	AND YEAR(TransactionDate) = 2020
)

-- 5
SELECT CustomerName, TransactionDate = CONVERT(VARCHAR, TransactionDate, 106)
FROM MsCustomer mc
JOIN TransactionHeader th
ON mc.CustomerID = th.CustomerID
WHERE EXISTS (
	SELECT * FROM TransactionDetail td
	JOIN MsFish mf
	ON td.FishID = mf.FishID
	WHERE FishPrice > 35
	AND td.TransactionID = th.TransactionID
)

-- 6
SELECT CustomerName, CustomerGender, CustomerEmail
FROM MsCustomer AS mc
WHERE EXISTS (
	SELECT * FROM TransactionHeader AS th
	JOIN MsFisherman AS mf
	ON th.FishermanID = mf.FishermanID
	WHERE FishermanGender = 'female'
	AND (LEFT(FishermanName, 1) = 'L' OR LEFT(FishermanName, 1) = 'R')
	AND mc.CustomerID IN (th.CustomerID)
)

-- 7
SELECT CustomerID, CustomerName
FROM MsCustomer mc
WHERE CustomerGender = 'Male'
AND CustomerID IN (
	SELECT CustomerID FROM TransactionHeader th
	WHERE NOT EXISTS(
		SELECT * FROM transactionDetail td
		JOIN MsFish mf
		ON mf.FishID = td.FishID
		JOIN MsFishType mft
		ON mft.FishTypeID = mf.FishTypeID
		WHERE FishTypeName = 'Tuna'
		AND td.TransactionID = th.TransactionID
	)
)

-- 8
SELECT FishName, FishTypeName, FishPrice
FROM MsFish mf JOIN MsFishType mft
ON mf.FishTypeID = mft.FishTypeID,
(SELECT AVG(FishPrice) AS Average FROM MsFish) aliasSubquery
WHERE FishPrice > aliasSubquery.Average

-- 9
SELECT FishName, FishPrice
FROM MsFish,
(SELECT MAX(FishPrice) AS MaxPrice, MIN(FishPrice) AS MinPrice FROM MsFish) X
WHERE FishPrice IN (X.MaxPrice, X.MinPrice)

-- 10
SELECT
	mc.CustomerName, CustomerEmail,
	[Fish Type Variant] = COUNT(*)
FROM
	MsCustomer mc JOIN
	TransactionHeader th ON
	mc.CustomerID = th.CustomerID JOIN
	TransactionDetail td ON
	td.TransactionID = th.TransactionID JOIN
	MsFish mf ON
	mf.FishID = td.FishID,
	(	SELECT MIN(x.FishTypeVariant) AS MinimumFishType
		FROM
		(
			SELECT
				COUNT(DISTINCT FishTypeID) AS FishTypeVariant,
				CustomerName
			FROM
				MsCustomer mc JOIN
				TransactionHeader th ON
				mc.CustomerID = th.CustomerID JOIN
				TransactionDetail td ON
				th.TransactionID = td.TransactionID JOIN
				MsFish mf ON
				td.FishID = mf.FishID
			GROUP BY
				CustomerName
		) x
	) y
GROUP BY
	mc.CustomerName, CustomerEmail, y.MinimumFishType
HAVING
	COUNT(*) = y.MinimumFishType

SELECT CustomerID, FishTypeID
FROM
	TransactionHeader th JOIN
	TransactionDetail td ON
	th.TransactionID = td.TransactionID JOIN
	MsFish mf ON
	mf.FishID = td.FishID
SELECT * FROM MsCustomer

INSERT INTO TransactionHeader
VALUES('TR099', 'CU010', 'FS001', '2021-08-09')

INSERT INTO TransactionDetail
VALUES('TR099', 'FI001', 1)