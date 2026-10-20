# Zepto Inventory and Sales Analysis (SQL)

A PostgreSQL project for exploring a Zepto product catalog and analyzing product prices, discounts, category mix, and stock availability. The project includes a CSV dataset and SQL scripts that progress from data exploration and cleaning to sales and inventory analysis.

## Dataset

`zepto_v2.csv` contains 3,732 product records across 14 categories. Its columns are:

| Column | Description |
| --- | --- |
| `Category` | Product category |
| `name` | Product name |
| `mrp` | Maximum retail price, stored in the source as an integer amount in paise |
| `discountPercent` | Discount percentage |
| `availableQuantity` | Listed available quantity |
| `discountedSellingPrice` | Discounted selling price, stored in paise |
| `weightInGms` | Product weight in grams |
| `outOfStock` | Stock status (`TRUE` / `FALSE`) |
| `quantity` | Quantity field from the source dataset |

The CSV is encoded in Windows-1252 (CP1252). When importing it, select that encoding if your database client does not detect it automatically.

## Project files

- `zepto_v2.csv` — source product catalog.
- `DATA EXPLORATION & CLEANING.sql` — creates the database/table and includes profiling, quality checks, and cleaning statements.
- `ZEPTO INVENTORY SALES ANALYSIS I .sql` — category and product sales-price, discount, and inventory-value analysis, including subqueries and window functions.
- `ZEPTO INVENTORY ANALYSIS II.sql` — inventory and category analysis queries.
- `ZEPTO INVENTORY ANALYSIS III.sql` — additional inventory analysis queries.

## Requirements

- PostgreSQL
- A PostgreSQL client such as `psql` or pgAdmin

## Getting started

1. Create a PostgreSQL database named `Zepto_SQL_Project` (or use the `CREATE DATABASE` statement in the exploration script).
2. Create the `zepto_inventory` table using the CSV columns, then import `zepto_v2.csv` with its header row. The exploration script defines a table, but does not import the CSV itself.
3. Review the column names and casing before running the analysis scripts. The CSV header is `Category`, while the table definition uses unquoted `category`; PostgreSQL treats quoted `"Category"` and unquoted `category` as different identifiers. Make the table definition and SQL references consistent (for example, use lowercase `category` throughout).
4. Run `DATA EXPLORATION & CLEANING.sql` first, then run the sales and inventory analysis scripts against the populated table.

## Analysis covered

The SQL examples include:

- Row and column counts, data types, nulls, duplicates, invalid values, and stock-status consistency checks.
- Product counts and product listings by category.
- Average, minimum, and maximum selling prices by category.
- Discount averages, discount amounts, and discount bands.
- Estimated inventory value using selling price multiplied by available quantity.
- Out-of-stock rates by category.
- Products priced above category averages and categories compared with overall averages.
- Category rankings, top products, running totals, percentage contributions, and price groupings using window functions.

## Notes before running the cleaning statements

- The source prices are represented in paise. The cleaning script includes an update intended to convert `mrp` and `discountedSellingPrice` to rupees. Review the numeric types and conversion logic before running it; integer division can discard fractional rupees, and repeated execution would convert the values again.
- The script deletes rows where `mrp = 0`. Review the affected records and consider running the cleaning steps on a copy or inside a transaction first.
- The SQL files contain analysis queries as well as data-changing statements. Read each statement before executing it on a database you need to preserve.

## License and data source

No license or dataset attribution is included in the project files. Add the appropriate license and source attribution here before publishing the repository publicly.
