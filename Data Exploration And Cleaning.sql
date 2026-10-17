create database Zepto_SQL_Project;

CREATE TABLE zepto_inventory(
    category VARCHAR(250),
    name VARCHAR(250) NOT NULL,
    mrp INT,
    discountPercent INT,
    availableQuantity INT,
    discountedSellingPrice INT,
    weightInGms INT,
    outOfStock VARCHAR(25),
    quantity INT
);

ALTER TABLE zepto_inventory
ADD COLUMN sku_id integer GENERATED ALWAYS AS IDENTITY PRIMARY KEY;
select * from zepto_inventory limit 10;

--- COUNT ROWS ---
SELECT COUNT(*) AS total_rows FROM zepto_inventory;

--- COUNT COLUMNS ---
SELECT COUNT(*) AS total_columns FROM information_schema.columns WHERE TABLE_NAME='zepto_inventory';

--- DISPLAY COLUMN NAMES & DATA_TYPES---
SELECT ordinal_position,column_name,data_type 
	FROM information_schema.columns WHERE TABLE_NAME='zepto_inventory' ORDER BY ordinal_position;
	
--- CHECK NULL VALUES IN EVERY COLUMN ---
SELECT 
	'SELECT' ||
		string_agg(
			format(
				'COUNT(*) FILTER (WHERE %I IS NULL) AS %I', column_name,column_name || '_nulls'), ', ') ||
				'FROM' || quote_ident('zepto_inventory') || ';' 
					AS generated_sql FROM information_schema.columns WHERE TABLE_NAME='zepto_inventory';
					
SELECT COUNT(*) FILTER (WHERE quantity IS NULL) AS quantity_nulls, 
		COUNT(*) FILTER (WHERE "outOfStock" IS NULL) AS "outOfStock_nulls", 
		COUNT(*) FILTER (WHERE sku_id IS NULL) AS sku_id_nulls, 
		COUNT(*) FILTER (WHERE mrp IS NULL) AS mrp_nulls, 
		COUNT(*) FILTER (WHERE "discountPercent" IS NULL) AS "discountPercent_nulls", 
		COUNT(*) FILTER (WHERE "availableQuantity" IS NULL) AS "availableQuantity_nulls", 
		COUNT(*) FILTER (WHERE "discountedSellingPrice" IS NULL) AS "discountedSellingPrice_nulls", 
		COUNT(*) FILTER (WHERE "weightInGms" IS NULL) AS "weightInGms_nulls", COUNT(*) FILTER (WHERE "Category" IS NULL) AS "Category_nulls", 
		COUNT(*) FILTER (WHERE name IS NULL) AS name_nulls FROM zepto_inventory;

--- CHECK DUPLICATE VALUES ---
SELECT name, COUNT(*) AS duplicate_names 
	FROM zepto_inventory GROUP BY name HAVING COUNT(*)>1 ORDER BY COUNT(*) DESC;

--- CHECK NEGATIVE OR INVALID VALUES ---
SELECT * FROM zepto_inventory
	WHERE mrp<0 
		OR "discountedSellingPrice"<0 
		OR "availableQuantity"<0 
		OR quantity<0;
		
--- CHECK ZERO VALUES ---
SELECT * FROM zepto_inventory
	WHERE mrp=0 
		OR "discountedSellingPrice"=0 
		OR "availableQuantity"=0 
		OR quantity=0;

--- CHECK NO.OF INSTOCK AND OUT OF STOCK PRODUCTS ---	
SELECT "outOfStock",COUNT(sku_id) FROM zepto_inventory
	GROUP BY "outOfStock" ORDER BY COUNT(sku_id) DESC;

--- CHECK WHEHTER AVALIABLE_QUANTITY AND STOCK LISITIG IS TRUE? ---
SELECT * FROM zepto_inventory 
	WHERE ("availableQuantity"=0 AND "outOfStock"='FALSE')
	OR ("availableQuantity">0 AND "outOfStock"='TRUE');

--- CHECK TYPES OF CATEGORY---
SELECT "Category" AS Categories FROM zepto_inventory GROUP BY "Category";

---CHECK EMPTY OR WHITESPACES IN PRODUCT NAMES ---
SELECT * FROM zepto_inventory WHERE name IS NULL OR TRIM(name)='';

--- CHECK DUPLICATE PRODUCT NAMES IN CATEGORY ---
SELECT "Category",name,COUNT(*) as duplicate_count FROM zepto_inventory 
	GROUP BY "Category",name HAVING COUNT(*)>1 ORDER BY duplicate_count DESC;

--- CHECK CATEGORY VALUES --
SELECT "Category",count(*) AS product_count FROM zepto_inventory
	GROUP BY "Category" ORDER BY product_count DESC;

--- CHECK PRODUCTS IN EACH CATEGORY ---
SELECT "Category",name,count(*) AS product_count FROM zepto_inventory
	GROUP BY "Category",name ORDER BY "Category";

	

																		--- DATA CLEANING ---
SELECT * FROM zepto_inventory WHERE mrp=0 or "discountedSellingPrice"=0;
DELETE FROM zepto_inventory WHERE mrp=0;

--- FILLTER ROWS WHERE DISCOUNTPERCENT IS ABOVE 100 OR BELOW 0  ---
SELECT * FROM zepto_inventory WHERE "discountPercent">100 or "discountPercent"<0;

--- CHECK SELLING PRICE EXCEEDS MRP ---
SELECT * FROM zepto_inventory WhERE "discountedSellingPrice">mrp;

---CONVERT PAISE INTO RUPEES ---
UPDATE zepto_inventory SET mrp=mrp/100,"discountedSellingPrice"="discountedSellingPrice"/100;

--- CHECK INCONSISTENT PRODUCT NAMES ---
SELECT * FROM zepto_inventory WHERE name <> TRIM(name);

---CHECK REPEATEAD PRODUCTS IN EACH CATEGORY ---
SELECT "Category",name,COUNT(*) AS occurrences FROM zepto_inventory	
	GROUP BY "Category",name HAVING COUNT(*)>1 ORDER BY occurrences DESC;