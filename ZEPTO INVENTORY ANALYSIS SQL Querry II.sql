--- FIND AVGERAGE SELLING PRICE FOR EACH CATEGORY >150 ---
SELECT "Category",avgSellingPrice
	FROM(
		SELECT "Category", AVG("discountedSellingPrice") AS avgSellingPrice FROM zepto_inventory
			GROUP BY "Category") AS categorySummary 
				WHERE avgSellingPrice > 150;
				
---CALCULATE NO.OF PRODUCTS IN EACH CATEGORY WITH MORE THAN 100 PRODUCTS ---
SELECT "Category",productCount 
	FROM(
		SELECT "Category",COUNT(*) AS productCount FROM zepto_inventory
			GROUP BY "Category") AS countSummary
				WHERE productCount>100;

--- CALCULATE AVERAGE DISCOUNT FOR EACH CATEGORY & DISPLAY THE RESULTS IN DESCENDING ORDER ---
SELECT "Category",avgDiscountPercent
	FROM(
		SELECT "Category",AVG("discountPercent") AS avgDiscountPercent FROM zepto_inventory
					GROUP BY "Category") AS avgDiscountSummary
					ORDER BY avgDiscountPercent DESC;
					
--- FIND PRODUCTS PRICED ABOVE THEIR CATEGORY's AVERAGE ---
SELECT z."Category",z.name AS product,z."discountedSellingPrice",c.avgSellingPrice FROM zepto_inventory AS z
	JOIN(
		SELECT "Category", AVG("discountedSellingPrice") AS avgSellingPrice FROM zepto_inventory 
			GROUP BY "Category") AS c 
	ON z."Category"=c."Category"
	WHERE z."discountedSellingPrice">c.avgsellingPrice;

--- FIND CATEGORIES WITH ABOVE-AVERAGE DISCOUNTS ---
SELECT "Category",avgDiscount 
	FROM(
		SELECT "Category", AVG("discountPercent") AS avgDiscount FROM zepto_inventory
			GROUP BY "Category") AS discountSummary
				WHERE avgDiscount>10;
				
--- CALCULATE THE PERCENTAGE CONTRIBUTAION OF EACH CATEGORY ---
SELECT "Category",totalSellingPrice, ROUND(totalSellingPrice*100/totalListedPrice,2) AS percentageContributation
	FROM(
		SELECT "Category",SUM("discountedSellingPrice") AS totalSellingPrice,
			SUM(SUM("discountedSellingPrice")) OVER() AS totalListedPrice FROM zepto_inventory
				GROUP BY "Category") AS categorySummary
				ORDER BY percentageContributation DESC;

--- FIND CATEGORIES WITH MORE EXPENSIVE PRODUCTS THAN THE OVERALL AVERAGE ---
SELECT "Category",avgCategoryPrice 
	FROM(
		SELECT "Category", AVG("discountedSellingPrice") as avgCategoryPrice FROM zepto_inventory
			GROUP BY "Category") AS categorySummary
				WHERE avgCategoryPrice > (SELECT AVG("discountedSellingPrice") FROM zepto_inventory);

--- IDENTIFY CATEGORIES WITH HIGH OUT-OF-STOCK RATES ---
SELECT "Category",totalProducts,outOfStockProducts,ROUND(outOfStockProducts*100/totalProducts,2) AS outOfStockPercentage
FROM(
	SELECT "Category",COUNT(*) AS totalProducts,
		COUNT(*) FILTER(WHERE "outOfStock"=TRUE) AS outOfStockProducts FROM zepto_inventory
			GROUP BY "Category") AS inventorySummary
				WHERE outOfStockProducts*100/totalProducts > 20;

--- FIND PRODUCTS WHOSE DISCOUNT's ARE HIHGHER THAN CATEGORY AVERAGE DISCOUNT ---
SELECT z."Category",z.name as product,z."discountPercent",d.avgCategoryDiscount FROM zepto_inventory AS z
	JOIN(
		SELECT "Category",AVG("discountPercent") AS avgCategoryDiscount FROM zepto_inventory 
			GROUP BY "Category") AS d
	ON z."Category"=d."Category"
	WHERE z."discountPercent">d.avgCategoryDiscount ORDER BY z."Category",z."discountPercent" DESC; 

--- RANK CATEGORIES BY AVERAGE SELLING PRICE ---
SELECT "Category",avgSellingPrice, RANK() OVER(ORDER BY avgSellingPrice DESC) AS categoryRank
	FROM(
		SELECT "Category",AVG("discountedSellingPrice") AS avgSellingPrice FROM zepto_inventory
			GROUP BY "Category") AS categorySummary;

--- CALCULATE AVERAGE SELLING PRICE FOR EACH CATEGORY, THEN IDENTIFY THE CATEGORY WITH HIGHEST AVG PRICE---
SELECT "Category",avgSellingPrice 
	FROM(
		SELECT "Category",AVG("discountedSellingPrice") AS avgSellingPrice FROM zepto_inventory
			GROUP BY "Category") AS categorySummary
				ORDER BY avgSellingPrice DESC LIMIT 10;



				