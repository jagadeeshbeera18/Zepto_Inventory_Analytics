🛒 Zepto Data Analytics Using SQL

📌 Project Overview

This project focuses on analyzing Zepto product listing data using PostgreSQL to uncover insights related to product pricing, discounts, category-wise product distribution, and inventory availability.

The objective is to transform raw product data into meaningful business insights by applying SQL queries and data analysis techniques.

This project demonstrates practical SQL skills and a business-oriented approach to data analytics.

🎯 Project Objectives

- Analyze product prices across different categories.
- Calculate average and total selling prices.
- Identify unique products within each category.
- Evaluate discount patterns and price differences.
- Identify the highest- and lowest-priced products.
- Analyze product availability and stock status.
- Estimate potential inventory selling value.
- Identify duplicate product listings.
- Generate insights that can support pricing and inventory decisions.

🛠️ Tools & Technologies

- Database: PostgreSQL
- Query Tool: pgAdmin 4
- Language: SQL
- Dataset: Zepto product dataset (CSV)



📊 Analysis Performed

1. Product Pricing Analysis

Analyzed product selling prices to understand pricing patterns across categories.

Key tasks:

- Calculate the average selling price.
- Calculate the total of listed selling prices.
- Identify the highest and lowest selling prices.
- Find the top 10 most expensive products.
- Compare product prices with category averages.

2. Category-Wise Product Analysis

Investigated how products are distributed across categories.

Key tasks:

- Count products in each category.
- Identify unique products within each category.
- Compare average selling prices across categories.
- Rank products within their respective categories.

3. Discount Analysis

Analyzed the discounts offered on listed products.

Key tasks:

- Calculate the discount amount for each product.
- Identify products with high discount percentages.
- Calculate average discounts by category.
- Segment products into discount ranges.
- Identify products with high original prices and substantial discounts.

4. Inventory Analysis

Explored product availability and estimated inventory value.

Key tasks:

- Identify out-of-stock products.
- Calculate out-of-stock percentages by category.
- Estimate potential inventory selling value using available quantities.
- Identify products with high potential inventory value.

Note: Potential inventory value is an estimate based on listed prices and available quantities. It should not be interpreted as actual sales revenue.

5. Data Quality Analysis

Performed checks to identify potential data quality issues.

Key tasks:

- Identify duplicate product listings.
- Check for missing values.
- Examine product pricing and discount information.
- Identify potential inconsistencies in product records.

💡 Business Questions Addressed

This project explores questions such as:

1. Which categories contain the most unique products?
2. Which products have the highest and lowest selling prices?
3. Which categories have the highest average selling prices?
4. Which products offer the largest discounts?
5. How are products distributed across price segments?
6. Which categories have the highest out-of-stock percentages?
7. Which products have the highest potential inventory selling value?
8. Which products are priced above or below their category average?
9. Are there duplicate product listings that require investigation?
10. Which categories account for the largest share of potential inventory value?

🧠 SQL Concepts Practiced

The project applies the following SQL concepts:

- "SELECT" and "WHERE"
- "ORDER BY" and "LIMIT"
- Aggregate functions: "SUM()", "AVG()", "MIN()", "MAX()", and "COUNT()"
- "GROUP BY" and "HAVING"
- "COUNT(DISTINCT column)"
- "CASE" statements
- Conditional aggregation using "FILTER"
- String aggregation using "STRING_AGG()"
- Common Table Expressions (CTEs)
- Subqueries
- Window functions
- Ranking using "ROW_NUMBER()"
- Null handling using "NULLIF()"
- Data quality checks and duplicate identification

📈 Expected Outcomes

The analysis helps develop an understanding of:

- Product pricing patterns.
- Category-level price differences.
- Discount distribution.
- Product availability.
- Potential inventory value.
- Data quality issues affecting analysis.

The results can support further analysis of pricing strategies and inventory management.

⚠️ Data Limitations

This project analyzes product listing data rather than confirmed customer transactions.

Therefore:

- Total listed selling price is not the same as total sales revenue.
- Available inventory value does not represent realized revenue.
- Discount percentages alone do not measure discount effectiveness.
- Actual sales growth, customer purchasing behavior, and revenue trends require transaction-level data.

These limitations are important when interpreting the findings.

🚀 Future Improvements

Potential extensions include:

- Build an interactive dashboard using Power BI.
- Perform exploratory data analysis using Python and Pandas.
- Visualize category-wise pricing and discount distributions.
- Integrate transaction-level data to analyze actual revenue.
- Analyze monthly sales trends when dated transactions are available.
- Investigate product profitability using cost data.
- Develop automated data quality checks.

👨‍💻 Skills Demonstrated

SQL | PostgreSQL | Data Cleaning | Exploratory Data Analysis | Product Pricing Analysis | Discount Analysis | Inventory Analysis | Business Insights

📌 Conclusion

This project demonstrates how PostgreSQL can be used to explore product data, investigate pricing and discount patterns, evaluate inventory availability, and identify potential data quality issues.

It provides a foundation for more advanced analytics projects involving transaction-level sales, revenue performance, and business intelligence.

---

⭐ If you find this project useful, feel free to explore the repository and share your feedback.
