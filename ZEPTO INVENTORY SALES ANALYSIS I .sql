                                             						--- --- CLAUSE's --- ---
--- COUNT NO.OF PRODUCTS IN EACH CATEGORY ---
SELECT "Category",COUNT(*) AS total_products FROM zepto_inventory
	GROUP BY "Category" ORDER BY total_products DESC;

--- RETRIVE ALL PRODUCTS IN EACH CATEGORY ---
SELECT "Category",STRING_AGG(name,', 'ORDER BY name) AS products FROM zepto_inventory
	GROUP BY "Category" ORDER BY "Category";
	
--- DISPLAY SELLING PRICE FOR EACH PRODUCT ---
SELECT name,"discountedSellingPrice" AS sellingPrice From zepto_inventory;

--- DISPLAY CATEGORY, PRODUCT AND IT's SELLING PRICE ---
SELECT "Category",name AS product,"discountedSellingPrice" AS sellingPrice FROM zepto_inventory
	ORDER BY "Category";

--- FIND AVERAGE SELLING PRICE AND TOTAL SELLING PRICE ACROSS CATEGORIES ---
SELECT "Category", AVG("discountedSellingPrice") AS averageSellingPrice, 
	SUM("discountedSellingPrice") AS totalSellingPrice FROM zepto_inventory
		GROUP BY "Category" ORDER BY averageSellingPrice; 

--- FIND HIGHEST AND LOWEST SELLING PRICE's BY CATEGORY ---
SELECT "Category", MIN("discountedSellingPrice") AS lowestSellingPrice, 
	MAX("discountedSellingPrice") highestSellingPrice FROM zepto_inventory
		GROUP BY "Category" ORDER BY "Category";

--- FIND TOP 10 EXPENSIVE PRODUCTS ---
SELECT "Category",name as product, "discountedSellingPrice" AS sellingPrice FROM zepto_inventory
	ORDER BY sellingPrice DESC limit 10;

--- FIND AVERAGE DISCOUNT BY CATEGORY ---
SELECT "Category", AVG("discountPercent") AS averageDiscountPercent FROM zepto_inventory
	GROUP BY "Category" ORDER BY averageDiscountPercent DESC;

---IDENTIFY PRODUCTS WITH HIGHEST DISCOUNT AMOUNT ---
SELECT "Category", name AS product, mrp, "discountedSellingPrice", 
	mrp- "discountedSellingPrice" AS discountAmount FROM zepto_inventory
	ORDER BY discountAmount DESC LIMIT 10;
	
--- COMPARE NO.OF PRODUCTS WITH DISCOUNTS BELOW 10%, BETWEEN 10% AND 30% AND ABOVE 30% ---
SELECT CASE WHEN "discountPercent"<10 THEN 'LOW DISCOUNT'
	WHEN "discountPercent"<30 THEN 'MODERATE DISCOUNT' ELSE 'HIGH DISCOUNT' END AS discountSegment,
		COUNT(*) AS productCount FROM zepto_inventory
			GROUP BY discountSegment ORDER BY productCount DESC;

--- FIND PRODUCTS WITH DISCOUNT GREATER THAN 30% ---
SELECT "Category",name AS product, "discountPercent", "discountedSellingPrice",mrp FROM zepto_inventory
	WHERE "discountPercent">30 ORDER BY "discountPercent" DESC;

--- CALCUALTE THE ACTUAL DISCOUNT AMOUNT ---
SELECT "Category",name AS product, mrp,"discountedSellingPrice",
	mrp-"discountedSellingPrice" AS discountPrice FROM zepto_inventory
		ORDER BY discountprice DESC;

--- IDENTIFY PRODUCTS WHERE DISCOUNT EXCEEDS A THRESHOLD ---
SELECT "Category",name AS product, "discountPercent", "discountedSellingPrice",mrp FROM zepto_inventory
	WHERE "discountPercent">50 ORDER BY "discountPercent" DESC;

--- CALCULATE POTENTIAL INVENTORY VALUE --- 
SELECT COALESCE("Category", 'TOTAL_VALUE') AS category,
	SUM("discountedSellingPrice"*"availableQuantity") AS inventoryValue FROM zepto_inventory
		GROUP BY GROUPING SETS (("Category"),()) ORDER BY GROUPING("Category"),"Category";

--- CALCULATE PRODUCTS WITH HIGHEST POTENTIAL INVENTORY VALUE ---
SELECT name AS product, "Category", "availableQuantity", "discountedSellingPrice",
	"discountedSellingPrice"*"availableQuantity" AS potential_inventory_value FROM zepto_inventory
		ORDER BY potential_inventory_value DESC LIMIT 10;

--- CALCUlATE OUT-OF-STOCK PERCENTAGE BY CATGEORY ---
SELECT "Category", COUNT(*) AS total_products, COUNT(*) FILTER(WHERE "outOfStock"=TRUE) AS outOfStockProducts,
	ROUND(100*COUNT(*) FILTER(WHERE "outOfStock"=TRUE)/NULLIF(COUNT(*),0),2) AS outOfStockPercentage FROM zepto_inventory
		GROUP BY "Category" ORDER BY outOfStockPercentage DESC;





