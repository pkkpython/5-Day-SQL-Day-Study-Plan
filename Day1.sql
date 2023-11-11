**Schema (MySQL v8.0)**

    CREATE TABLE products (
        product_id INT PRIMARY KEY,
        product_name VARCHAR(50),
        product_category VARCHAR(50),
        product_price DECIMAL(6, 2)
    );
    
    CREATE TABLE orders (
        order_id INT PRIMARY KEY,
        product_id INT,
        customer_id INT,
        quantity INT,
        order_date DATE,
        FOREIGN KEY (product_id) REFERENCES products(product_id)
    );
    
    INSERT INTO products (product_id, product_name, product_category, product_price)
    VALUES 
    (1, 'Product A', 'Category 1', 50.00),
    (2, 'Product B', 'Category 1', 25.00),
    (3, 'Product C', 'Category 2', 75.00),
    (4, 'Product D', 'Category 2', 100.00),
    (5, 'Product E', 'Category 3', 150.00);
    
    INSERT INTO orders (order_id, product_id, customer_id, quantity, order_date)
    VALUES 
    (1, 1, 101, 2, '2023-01-01'),
    (2, 2, 102, 1, '2023-01-02'),
    (3, 3, 103, 3, '2023-01-03'),
    (4, 1, 104, 1, '2023-01-04'),
    (5, 5, 105, 2, '2023-01-05'),
    (6, 4, 106, 4, '2023-01-06'),
    (7, 2, 107, 2, '2023-01-07'),
    (8, 3, 101, 1, '2023-01-08'),
    (9, 1, 108, 2, '2023-01-09'),
    (10, 5, 109, 3, '2023-01-10');
    

---



-- How many orders were placed for each product?
-- What is the total quantity sold for each product category?
-- Which product has generated the most sales revenue?
-- Which customers have purchased 'Product A'?
-- How many unique customers have made purchases?

-- checking tables
select * from  products;
select * from orders;


-- 1. How many orders were placed for each product?
select product_id, 
       count(order_id) as order_count
from orders
group by product_id;

-- 2. What is the total quantity sold for each product category?


SELECT p.product_category, t.total_quantity
FROM products p
JOIN (
    SELECT product_id, SUM(quantity) AS total_quantity
    FROM orders
    GROUP BY product_id
) AS t
ON p.product_id = t.product_id;

-- 3. Which product has generated the most sales revenue?


select p.product_id, p.product_name, product_price*quantity as sales_revenue
from products p
join orders o
on p.product_id = o.product_id
order by sales_revenue desc
limit 5;


-- 4. Which customers have purchased 'Product A'?


SELECT customer_id 

    FROM orders

    WHERE product_id = 4;
    

-- 5. How many unique customers have made purchases?


select count(distinct customer_id)
from orders;



**Query #1**

    select * from  products;

| product_id | product_name | product_category | product_price |
| ---------- | ------------ | ---------------- | ------------- |
| 1          | Product A    | Category 1       | 50.00         |
| 2          | Product B    | Category 1       | 25.00         |
| 3          | Product C    | Category 2       | 75.00         |
| 4          | Product D    | Category 2       | 100.00        |
| 5          | Product E    | Category 3       | 150.00        |

---
**Query #2**

    select * from orders;

| order_id | product_id | customer_id | quantity | order_date |
| -------- | ---------- | ----------- | -------- | ---------- |
| 1        | 1          | 101         | 2        | 2023-01-01 |
| 2        | 2          | 102         | 1        | 2023-01-02 |
| 3        | 3          | 103         | 3        | 2023-01-03 |
| 4        | 1          | 104         | 1        | 2023-01-04 |
| 5        | 5          | 105         | 2        | 2023-01-05 |
| 6        | 4          | 106         | 4        | 2023-01-06 |
| 7        | 2          | 107         | 2        | 2023-01-07 |
| 8        | 3          | 101         | 1        | 2023-01-08 |
| 9        | 1          | 108         | 2        | 2023-01-09 |
| 10       | 5          | 109         | 3        | 2023-01-10 |

---
**Query #3**

    select product_id, 
           count(order_id) as order_count
    from orders
    group by product_id;

| product_id | order_count |
| ---------- | ----------- |
| 1          | 3           |
| 2          | 2           |
| 3          | 2           |
| 4          | 1           |
| 5          | 2           |

---
**Query #4**

    SELECT p.product_category, t.total_quantity
    FROM products p
    JOIN (
        SELECT product_id, SUM(quantity) AS total_quantity
        FROM orders
        GROUP BY product_id
    ) AS t
    ON p.product_id = t.product_id;

| product_category | total_quantity |
| ---------------- | -------------- |
| Category 1       | 5              |
| Category 1       | 3              |
| Category 2       | 4              |
| Category 2       | 4              |
| Category 3       | 5              |

---
**Query #5**

    select p.product_id, p.product_name, product_price*quantity as sales_revenue
    from products p
    join orders o
    on p.product_id = o.product_id
    order by sales_revenue desc
    limit 5;

| product_id | product_name | sales_revenue |
| ---------- | ------------ | ------------- |
| 5          | Product E    | 450.00        |
| 4          | Product D    | 400.00        |
| 5          | Product E    | 300.00        |
| 3          | Product C    | 225.00        |
| 1          | Product A    | 100.00        |

---
**Query #6**

    SELECT customer_id 
    
        FROM orders
    
        WHERE product_id = 4;

| customer_id |
| ----------- |
| 106         |

---
**Query #7**

    select count(distinct customer_id)
    from orders;

| count(distinct customer_id) |
| --------------------------- |
| 9                           |

---

[View on DB Fiddle](https://www.db-fiddle.com/f/jeQknCYFGstK7Qxk6Tj6Uj/10)