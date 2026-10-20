                                          									--- --- WINDOW FUNCTION's --- ---

--- CATGEORY PRODUCT COUNT ---
SELECT "Category",name as product,COUNT(*) 
	OVER(PARTITION BY "Category") AS productsINCategory FROM zepto_inventory

--- CATEGORY LEVEL LISTED PRICE TOTAL ---
SELECT "Category","discountedSellingPrice",SUM("discountedSellingPrice") OVER(PARTITION BY "Category") AS categoryTotalPrice 
	FROM zepto_inventory;
	
--- PRODUCTS WITH OVERALL AVERAGE SELLING PRICE ---
SELECT name as product,"discountedSellingPrice",AVG("discountedSellingPrice") OVER() AS avgsellingprice
	FROM zepto_inventory;

--- RANK PRODUCTS WITHIN EACH CATEGORY ---
SELECT "Category",name AS product ,"discountedSellingPrice",
	RANK() OVER(PARTITION BY "Category" ORDER BY "discountedSellingPrice" DESC) AS Category_Rank
		FROM zepto_inventory;
		
--- FIND TOP THREE PRODUCTS IN EACH CATEGORY ---
SELECT * FROM(
	SELECT "Category",name AS product ,"discountedSellingPrice",
		DENSE_RANK() OVER(PARTITION BY "Category" ORDER BY "discountedSellingPrice" DESC) AS Category_Rank
			FROM zepto_inventory) AS rankedProducts
				WHERE Category_Rank<=3;

--- FIND MINIMUM & MAXIMUM SELLING PRICE WITHIN EACH CATEGORY ---
SELECT "Category",name AS product,"discountedSellingPrice",
	MIN("discountedSellingPrice") OVER(PARTITION BY "Category") AS minCategoryPrice,
	MAX("discountedSellingPrice") OVER(PARTITION BY "Category") AS maxCategoryPrice
		FROM zepto_inventory;

--- CALCULATE RUNNING TOTAL OF SELLING PRICE ---
SELECT "Category",name as product,"discountedSellingPrice", SUM("discountedSellingPrice") 
		OVER(ORDER BY "discountedSellingPrice",name ROWS BETWEEN UNBOUNDED PRECEDING AND CURRENT ROW) AS runningTotal
			FROM zepto_inventory;

---PRODUCTS PRICES ABOVE THEIR CATEGORY AVERAGE ---
SELECT * FROM(
	SELECT "Category",name as product,"discountedSellingPrice",
		AVG("discountedSellingPrice") OVER(PARTITION BY "Category") AS avgCategoryPrice FROM zepto_inventory) AS productAnalysis
			WHERE "discountedSellingPrice">avgCategoryPrice;
			
--- THREE HIGHEST PRICED PRODUCTS IN EVERY CATEGORY ---
SELECT * FROM(
	SELECT "Category",name as product,"discountedSellingPrice",
		DENSE_RANK() OVER(PARTITION BY "Category" ORDER BY "discountedSellingPrice" DESC ) AS priceRank 
			FROM zepto_inventory) AS rankedProducts WHERE priceRank<=3
		
--- PRODUCT PERCENTAGE CONTRIBUTION TO SUM OF SELLING PRICE ---
SELECT "Category",name AS product,"discountedSellingPrice",
	ROUND("discountedSellingPrice"::numeric*100/NULLIF(SUM("discountedSellingPrice")OVER(),0),2) AS percentageContribution
		FROM zepto_inventory ORDER BY percentageContribution ASC;

--- DIVIDE PRODUCTS INTO 4 PRICE GROUPS ---
SELECT "Category",name as product,"discountedSellingPrice",NTILE(4) OVER(PARTITION BY "Category" ORDER BY "discountedSellingPrice" ASC) AS priceGroup
	FROM zepto_inventory;






