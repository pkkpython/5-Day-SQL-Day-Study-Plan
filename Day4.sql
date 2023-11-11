**Schema (MySQL v8.0)**

    CREATE TABLE products (
        product_id INT PRIMARY KEY,
        product_name VARCHAR(50),
        category VARCHAR(50)
    );
    
    CREATE TABLE sales (
        sale_id INT PRIMARY KEY,
        product_id INT,
        region VARCHAR(50),
        sale_date DATE,
        quantity INT,
        revenue DECIMAL(10, 2),
        FOREIGN KEY (product_id) REFERENCES products(product_id)
    );
    
    INSERT INTO products (product_id, product_name, category)
    VALUES
        (1, 'Product A', 'Category 1'),
        (2, 'Product B', 'Category 1'),
        (3, 'Product C', 'Category 2'),
        (4, 'Product D', 'Category 3'),
        (5, 'Product E', 'Category 3');
    
    INSERT INTO sales (sale_id, product_id, region, sale_date, quantity, revenue)
    VALUES
        (1, 1, 'Region 1', '2023-01-01', 10, 100.00),
        (2, 2, 'Region 1', '2023-01-02', 5, 75.00),
        (3, 3, 'Region 2', '2023-01-02', 8, 120.00),
        (4, 4, 'Region 2', '2023-01-03', 12, 150.00),
        (5, 5, 'Region 1', '2023-01-03', 6, 90.00),
        (6, 1, 'Region 2', '2023-01-04', 15, 200.00),
        (7, 3, 'Region 1', '2023-01-04', 10, 150.00),
        (8, 2, 'Region 2', '2023-01-05', 7, 105.00),
        (9, 4, 'Region 1', '2023-01-05', 9, 135.00),
        (10, 5, 'Region 2', '2023-01-05', 3, 45.00);
    

---


/*
## Questions

1. Retrieve the sales revenue for each product, along with the maximum revenue achieved for each product across all sales.
2. Calculate the average revenue for each product, considering only the three most recent sales for each product.
3. Calculate the difference in revenue between each sale and the previous sale for each product, sorted by product and sale date.
4. Retrieve the sales revenue for each product, along with the cumulative revenue for each product over time.
5. Rank the sales regions based on the total revenue generated, and display the top three regions along with their respective total revenue.

*/
-- 1. Retrieve the sales revenue for each product, along with the maximum revenue achieved for each product across all sales.

SELECT
    p.product_name,
    s.revenue AS sales_revenue,
    MAX(s.revenue) OVER (PARTITION BY p.product_id) AS max_revenue
FROM
    products p
JOIN
    sales s
ON
    p.product_id = s.product_id;


-- 2. Calculate the average revenue for each product, considering only the three most recent sales for each product.

WITH RankedSales AS (
    SELECT
        product_id,
        sale_date,
        revenue,
        ROW_NUMBER() OVER (PARTITION BY product_id ORDER BY sale_date DESC) AS row_num
    FROM
        sales
)
SELECT
    p.product_name,
    AVG(s.revenue) AS average_recent_revenue
FROM
    products p
JOIN
    RankedSales s
ON
    p.product_id = s.product_id
WHERE
    s.row_num <= 3
GROUP BY
    p.product_name;


-- 3. Calculate the difference in revenue between each sale and the previous sale for each product, sorted by product and sale date.

WITH RevenueChanges AS (
    SELECT
        product_id,
        sale_date,
        revenue - LAG(revenue, 1, 0) OVER (PARTITION BY product_id ORDER BY sale_date) AS revenue_change
    FROM
        sales
)
SELECT
    p.product_name,
    s.sale_date,
    s.revenue_change
FROM
    products p
JOIN
    RevenueChanges s
ON
    p.product_id = s.product_id
ORDER BY
    p.product_name,
    s.sale_date;

-- 4. Retrieve the sales revenue for each product, along with the cumulative revenue for each product over time.

SELECT
    p.product_name,
    s.sale_date,
    s.revenue,
    SUM(s.revenue) OVER (PARTITION BY p.product_id ORDER BY s.sale_date) AS cumulative_revenue
FROM
    products p
JOIN
    sales s
ON
    p.product_id = s.product_id
ORDER BY
    p.product_name,
    s.sale_date;

    
-- 5. Rank the sales regions based on the total revenue generated, and display the top three regions along with their respective total revenue.

SELECT
    region,
    total_region_revenue
FROM (
    SELECT
        region,
        SUM(revenue) AS total_region_revenue,
        DENSE_RANK() OVER (ORDER BY SUM(revenue) DESC) AS region_rank
    FROM
        sales
    GROUP BY
        region
) AS ranked_regions
WHERE region_rank <= 3;






**Query #1**

    SELECT
        p.product_name,
        s.revenue AS sales_revenue,
        MAX(s.revenue) OVER (PARTITION BY p.product_id) AS max_revenue
    FROM
        products p
    JOIN
        sales s
    ON
        p.product_id = s.product_id;

| product_name | sales_revenue | max_revenue |
| ------------ | ------------- | ----------- |
| Product A    | 100.00        | 200.00      |
| Product A    | 200.00        | 200.00      |
| Product B    | 75.00         | 105.00      |
| Product B    | 105.00        | 105.00      |
| Product C    | 120.00        | 150.00      |
| Product C    | 150.00        | 150.00      |
| Product D    | 150.00        | 150.00      |
| Product D    | 135.00        | 150.00      |
| Product E    | 90.00         | 90.00       |
| Product E    | 45.00         | 90.00       |

---
**Query #2**

    WITH RankedSales AS (
        SELECT
            product_id,
            sale_date,
            revenue,
            ROW_NUMBER() OVER (PARTITION BY product_id ORDER BY sale_date DESC) AS row_num
        FROM
            sales
    )
    SELECT
        p.product_name,
        AVG(s.revenue) AS average_recent_revenue
    FROM
        products p
    JOIN
        RankedSales s
    ON
        p.product_id = s.product_id
    WHERE
        s.row_num <= 3
    GROUP BY
        p.product_name;

| product_name | average_recent_revenue |
| ------------ | ---------------------- |
| Product A    | 150.000000             |
| Product B    | 90.000000              |
| Product C    | 135.000000             |
| Product D    | 142.500000             |
| Product E    | 67.500000              |

---
**Query #3**

    WITH RevenueChanges AS (
        SELECT
            product_id,
            sale_date,
            revenue - LAG(revenue, 1, 0) OVER (PARTITION BY product_id ORDER BY sale_date) AS revenue_change
        FROM
            sales
    )
    SELECT
        p.product_name,
        s.sale_date,
        s.revenue_change
    FROM
        products p
    JOIN
        RevenueChanges s
    ON
        p.product_id = s.product_id
    ORDER BY
        p.product_name,
        s.sale_date;

| product_name | sale_date  | revenue_change |
| ------------ | ---------- | -------------- |
| Product A    | 2023-01-01 | 100.00         |
| Product A    | 2023-01-04 | 100.00         |
| Product B    | 2023-01-02 | 75.00          |
| Product B    | 2023-01-05 | 30.00          |
| Product C    | 2023-01-02 | 120.00         |
| Product C    | 2023-01-04 | 30.00          |
| Product D    | 2023-01-03 | 150.00         |
| Product D    | 2023-01-05 | -15.00         |
| Product E    | 2023-01-03 | 90.00          |
| Product E    | 2023-01-05 | -45.00         |

---
**Query #4**

    SELECT
        p.product_name,
        s.sale_date,
        s.revenue,
        SUM(s.revenue) OVER (PARTITION BY p.product_id ORDER BY s.sale_date) AS cumulative_revenue
    FROM
        products p
    JOIN
        sales s
    ON
        p.product_id = s.product_id
    ORDER BY
        p.product_name,
        s.sale_date;

| product_name | sale_date  | revenue | cumulative_revenue |
| ------------ | ---------- | ------- | ------------------ |
| Product A    | 2023-01-01 | 100.00  | 100.00             |
| Product A    | 2023-01-04 | 200.00  | 300.00             |
| Product B    | 2023-01-02 | 75.00   | 75.00              |
| Product B    | 2023-01-05 | 105.00  | 180.00             |
| Product C    | 2023-01-02 | 120.00  | 120.00             |
| Product C    | 2023-01-04 | 150.00  | 270.00             |
| Product D    | 2023-01-03 | 150.00  | 150.00             |
| Product D    | 2023-01-05 | 135.00  | 285.00             |
| Product E    | 2023-01-03 | 90.00   | 90.00              |
| Product E    | 2023-01-05 | 45.00   | 135.00             |

---
**Query #5**

    SELECT
        region,
        total_region_revenue
    FROM (
        SELECT
            region,
            SUM(revenue) AS total_region_revenue,
            DENSE_RANK() OVER (ORDER BY SUM(revenue) DESC) AS region_rank
        FROM
            sales
        GROUP BY
            region
    ) AS ranked_regions
    WHERE region_rank <= 3;

| region   | total_region_revenue |
| -------- | -------------------- |
| Region 2 | 620.00               |
| Region 1 | 550.00               |

---

[View on DB Fiddle](https://www.db-fiddle.com/f/qEJ8hVpVa1fRVcHkeRAfJo/5)