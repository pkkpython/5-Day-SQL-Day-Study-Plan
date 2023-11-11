# 5-Day-SQL-Day-Study-Plan
![](https://miro.medium.com/v2/resize:fit:1400/format:webp/1*ZUXenDgD-KPSAo9CuM13ZA.png)
Review basic and intermediate SQL concepts, including data extraction, joining tables, and working with aggregate functions. Understand how to manipulate and query data from multiple tables in a database.
## Day 1: Review of Basics & Intermediate Concepts 
<p align="center">
  <img src="https://i1.wp.com/teamwbfitness.com/wp-content/uploads/2018/01/day-1.jpg?fit=513%2C531&ssl=1" alt="Sublime's custom image"/>
</p>

[Clike Here](https://lnkd.in/dfysMD9v)

### Part 1: SQL Basics
The basics of SQL consist of understanding how to select data from a database and manipulate it to get desired results. The topics included in this part are the fundamental SQL statements — SELECT, WHERE, GROUP BY, and ORDER BY. These SQL commands are used to extract, filter, group, and order the data in the ways needed. For example, you may need to select certain columns from a database table, filter out rows based on specific conditions, group the data by a certain column, or sort the result set in a particular order.

### Part 2: Joins
In this part, we discuss the concept of SQL joins. Joins are used to combine rows from two or more tables, based on a related column between them. Understanding SQL joins is essential for working with relational databases, where data is often spread across several related tables. We’ll explore different types of joins — INNER JOIN, LEFT JOIN, RIGHT JOIN, and FULL JOIN — and understand the use cases for each.

### Part 3: Set Operations
Set operations in SQL provide ways to combine rows from two or more tables. We’ll delve into the three primary set operations — UNION, INTERSECT, and EXCEPT - and learn how to use them effectively. Set operations can be a powerful tool when you want to combine or compare results from multiple SQL queries.

### Part 4: Aggregate Functions
Aggregate functions are
Aggregate functions are used in SQL to perform calculations on a set of values and return a single value. They can be very useful for tasks such as counting the number of records, calculating the sum or average of a column, or finding the minimum or maximum value. This part covers the essential aggregate functions COUNT, AVG, SUM, MIN, and MAX, and shows how to use them in different scenarios.

### Part 5: Subqueries
A subquery is a SQL query nested inside a larger query, and it can be used in various ways to create more complex queries. Understanding subqueries is crucial for writing efficient and flexible SQL code. They allow you to perform operations in multiple steps, handle complex data manipulation tasks, and even base your main query on the results of a separate query. We’ll learn the syntax for subqueries and look at some common use cases.

### [Case Study: Analyzing an E-commerce Database](https://lnkd.in/dQR-i39H)

## Day 2: Advanced Filtering, Functions and Operators

<p align="center">
  <img src="https://tse2.mm.bing.net/th?id=OIP.JfNFysade61J-yffVp-OUwHaHq&pid=Api&P=0&w=300&h=300" alt="Sublime's custom image"/>
</p>

Explore advanced filtering techniques in SQL, including string functions, date/time functions, numeric functions, and operators. Learn how to apply these functions to filter and manipulate data effectively.
[Click Here](https://lnkd.in/dya3THJs)

### Part 1: String Functions
In this part, we will explore various string functions in SQL. String functions allow us to manipulate and extract information from text data stored in database tables. We’ll cover essential string functions such as LENGTH, UPPER, LOWER, SUBSTRING, and CONCAT. These functions will enable us to perform tasks like finding the length of a string, converting strings to uppercase or lowercase, extracting substrings from strings, and concatenating strings together.

### Part 2: Date/Time Functions
Dates and times are crucial data types in many databases, and SQL provides several functions to work with them effectively. In this part, we will learn about date/time functions in SQL. We’ll cover concepts like CURRENT_DATE for obtaining the current date, DATE_FORMAT for formatting dates as per specified formats, DATE_ADD and DATE_SUB for adding or subtracting time intervals from dates, and DATEDIFF for calculating the difference between two dates.

### Part 3: Numeric Functions
Numeric functions play a significant role in performing calculations and manipulations on numeric data in SQL. In this part, we will explore important numeric functions like ABS for obtaining the absolute value of a number, ROUND for rounding numbers to a specified decimal place, FLOOR for rounding down to the nearest integer, and CEILING for rounding up to the nearest integer. Understanding these functions will allow us to perform various calculations and transformations on numeric data.

### Part 4: Advanced Filtering using Operators
In this part, we will dive into advanced filtering techniques using operators in SQL. Operators provide powerful tools for filtering and selecting specific data based on certain conditions. We’ll cover operators like LIKE for pattern matching, IN for specifying multiple values, BETWEEN for selecting values within a range, NULL for handling NULL values, and NOT for negating a condition. These operators will enable us to write more complex and precise SQL queries for data extraction and analysis.

### [Case Study: Customer Segmentation for a Telecommunication Company](https://www.db-fiddle.com/f/t6abyQXdU8tXJZLADXkf4u/4)

## Day 3: Advanced Joins, Nested Queries, and Advanced Subqueries
<p align="center">
  <img src="https://i0.wp.com/pfitblog.com/wp-content/uploads/2015/03/day-3.jpg" alt="Sublime's custom image"/>
</p>

Dive deeper into SQL joins, nested queries, and advanced subqueries to enhance your data retrieval and manipulation skills. Understand how to perform complex joins, utilize nested queries to extract data from multiple tables, and leverage advanced subqueries for advanced filtering and data transformation.

### Part 1: Advanced Joins
In this part, we will explore advanced join techniques to enhance your data retrieval capabilities. We’ll dive into self joins and cross joins. Self joins are useful when comparing records within the same table. Cross joins create a Cartesian product of two tables. By understanding these advanced join types, you’ll have more flexibility in combining data from multiple tables and solving complex data retrieval problems.

## Part 2: Nested Queries
A nested select statement, also known as a subquery, is a query nested within another query. It can be used in the SELECT, FROM, WHERE, or HAVING clause to retrieve data based on specific conditions.

## Part 3: Advanced Subqueries
In this part, we will uncover the potential of advanced subqueries. We’ll explore correlated subqueries, which enable dynamic filtering and calculations by referencing columns from the outer query. Scalar subqueries allow us to retrieve a single value as an expression within the SELECT clause or use it within a WHERE clause. We’ll also dive into derived tables, which are subqueries used as virtual tables within the main query, allowing us to perform complex calculations or filtering before joining or further processing the data. Understanding advanced subqueries will enhance your ability to perform sophisticated data analysis and manipulation tasks in SQL.

### [Case Study: Sales Data Analysis for an E-commerce Platform](https://www.db-fiddle.com/f/xtvT8co9LVD2K41UcpYcaE/11)

## Day 4: Window Functions
<p align="center">
  <img src="https://i1.wp.com/pfitblog.com/wp-content/uploads/2015/03/day-4.jpg" alt="Sublime's custom image"/>
</p>

Learn about window functions in SQL for advanced data analysis. Understand how to perform calculations and aggregations on specific windows or partitions of data. Explore concepts such as ranking, row numbering, aggregating over windows, and more.

### Part 1: Introduction to Window Functions
Window functions are SQL functions that perform calculations and aggregations over a set of rows called a “window” or “partition” within a table. They allow you to apply calculations to a subset of data based on specified criteria or order.

### Part 2: Ranking Functions
Ranking functions allow us to assign a rank or row number to each row within a window based on a specific order or criteria. In this part, we’ll explore three ranking functions: ROW_NUMBER, RANK, and DENSE_RANK. These functions are useful for tasks such as identifying top performers, finding the highest or lowest values within a group, and understanding the relative positions of rows within a window. By mastering ranking functions, we can easily analyze and compare data based on specific ranking criteria.

### Part 3: Aggregate Functions with Window
Aggregate functions, such as SUM, AVG, MIN, and MAX, are commonly used to perform calculations on groups of rows. In this part, we'll discover how to combine aggregate functions with window functions to perform calculations and aggregations on specific partitions or windows of data. This enables us to calculate running totals, moving averages, and other aggregations based on customized windows within our data. By leveraging aggregate functions with windows, we can gain deeper insights into the patterns and trends within our data.

### Part 4: Analytical Functions
Analytical functions provide access to data from previous or subsequent rows within a window, allowing us to perform complex analyses and comparisons. In this part, we’ll explore two fundamental analytical functions: LEAD and LAG. These functions enable us to retrieve data from the next or previous rows, which is particularly useful for tasks like calculating differences, identifying trends, and detecting anomalies. Additionally, we'll delve into FIRST_VALUE and LAST_VALUE, which allow us to extract the first and last values within a window, respectively. Understanding analytical functions empowers us to perform advanced analyses and gain deeper insights into our data.

### [Case Study: Sales Analysis with Window Functions](https://lnkd.in/dMuwJqzb)

## Day 5: Advanced SQL Queries with Common Table Expressions (CTEs)
<p align="center">
  <img src="https://www.thefinancialfairytales.com/blog/wp-content/uploads/2019/08/day-5.png" alt="Sublime's custom image"/>
</p>

Learn about Common Table Expressions (CTEs), a powerful feature in SQL that allows us to create temporary named result sets. Understand how to use CTEs to write complex and efficient SQL queries. Explore concepts such as recursive CTEs, multiple CTEs, and inline views.

### Part 1: Introduction to Common Table Expressions (CTEs)
In this part, we will explore Common Table Expressions (CTEs), a powerful feature in SQL that allows us to create temporary named result sets. CTEs provide a way to break down complex queries into smaller, more manageable parts, improving query readability and maintainability. We will learn the syntax of CTEs and understand how to use them to write efficient and concise SQL queries.

### Part 2: Recursive CTEs
Recursive CTEs are a fascinating aspect of CTEs that enable us to perform hierarchical or graph-based queries. In this part, we will delve into the world of recursive CTEs and learn how they can be used to traverse tree structures, find connected components in graphs, and perform other iterative operations. We will understand the recursive CTE syntax, including the anchor member and recursive member, and see practical examples of their usage.

### Part 3: Multiple CTEs
Multiple CTEs allow us to define and use multiple CTEs within a single SQL statement. In this part, we will explore the concept of multiple CTEs and understand how they can help break down complex queries into smaller logical parts. We will learn how to define and reference multiple CTEs in a query and discover their usefulness in improving query organization and reusability.

Part 4: Inline Views
Inline views, also known as derived tables, provide a powerful way to treat the result of a subquery as a temporary table within a SQL statement. In this part, we will explore the concept of inline views and understand how they can be used to manipulate and reference intermediate result sets in the main query. We will learn the syntax of inline views and see practical examples of their application.

### Part 5: Combining CTEs and Inline Views
Combining CTEs and inline views allows us to create even more complex SQL queries. In this part, we will learn how to leverage the power of both CTEs and inline views together to break down complex queries, create temporary result sets, and perform advanced analysis. We will explore examples demonstrating how CTEs and inline views can work harmoniously to enhance query readability and maintainability.

### [Case Study: Employee Management System](https://www.db-fiddle.com/f/3i2ugMuWWkMDrqmbVs72Xm/5)
