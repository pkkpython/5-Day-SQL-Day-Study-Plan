**Schema (MySQL v8.0)**

    CREATE TABLE customers (
      customer_id INT PRIMARY KEY,
      customer_name VARCHAR(50),
      email VARCHAR(100),
      location VARCHAR(100)
    );
    
    CREATE TABLE products (
      product_id INT PRIMARY KEY,
      product_name VARCHAR(100),
      category VARCHAR(50),
      price DECIMAL(10, 2)
    );
    
    CREATE TABLE orders (
      order_id INT PRIMARY KEY,
      customer_id INT,
      product_id INT,
      quantity INT,
      order_date DATE,
      FOREIGN KEY (customer_id) REFERENCES customers(customer_id),
      FOREIGN KEY (product_id) REFERENCES products(product_id)
    );
    
    INSERT INTO customers (customer_id, customer_name, email, location)
    VALUES
      (1, 'John Doe', 'johndoe@example.com', 'New York'),
      (2, 'Jane Smith', 'janesmith@example.com', 'Los Angeles'),
      (3, 'Mike Johnson', 'mikejohnson@example.com', 'Chicago'),
      (4, 'Emily Brown', 'emilybrown@example.com', 'Houston'),
      (5, 'David Wilson', 'davidwilson@example.com', 'Miami');
    
    INSERT INTO products (product_id, product_name, category, price)
    VALUES
      (1, 'iPhone 12', 'Electronics', 999.99),
      (2, 'Samsung Galaxy S21', 'Electronics', 899.99),
      (3, 'Nike Air Max', 'Fashion', 129.99),
      (4, 'Sony PlayStation 5', 'Gaming', 499.99),
      (5, 'MacBook Pro', 'Electronics', 1499.99);
    
    INSERT INTO orders (order_id, customer_id, product_id, quantity, order_date)
    VALUES
      (1, 1, 1, 2, '2023-01-01'),
      (2, 2, 3, 1, '2023-01-02'),
      (3, 3, 2, 3, '2023-01-03'),
      (4, 4, 4, 1, '2023-01-04'),
      (5, 5, 1, 1, '2023-01-05'),
      (6, 1, 3, 2, '2023-01-06'),
      (7, 2, 2, 1, '2023-01-07'),
      (8, 3, 5, 1, '2023-01-08'),
      (9, 4, 4, 2, '2023-01-09'),
      (10, 5, 1, 3, '2023-01-10');
    

---


/*
## Questions
1. Retrieve the customer names and their corresponding orders.
2. Find the total quantity and revenue generated from each product category.
3. Retrieve the top-selling products in each category.
4. Retrieve the average order value for each customer.
5. Retrieve the customers who have made more than the average order quantity.
*/



-- 1. Retrieve the customer names and their corresponding orders.

SELECT c.customer_name,p.product_name, o.quantity
FROM products p
JOIN orders o
ON p.product_id = o.product_id
JOIN customers c
ON c.customer_id = o.customer_id;

-- 2. Find the total quantity and revenue generated from each product category.

SELECT p.category, 
       SUM(o.product_id) AS total_quantity, 
       SUM(price*quantity) AS total_revenue
FROM products p
JOIN orders o
ON p.product_id = o.product_id
GROUP BY p.category;

-- 3. Retrieve the top-selling products in each category.

WITH ProductTotalQuantity AS (
  SELECT p.category, p.product_name, SUM(o.quantity) AS total_quantity
  FROM products p
  JOIN orders o ON p.product_id = o.product_id
  GROUP BY p.category, p.product_name
)
SELECT category, product_name, total_quantity
FROM ProductTotalQuantity
WHERE (category, total_quantity) IN (
  SELECT category, MAX(total_quantity)
  FROM ProductTotalQuantity
  GROUP BY category
);

-- 4. Retrieve the average order value for each customer.

SELECT c.customer_id, 
       c.customer_name, 
       ROUND(avg(price*quantity),2) as average_order_value
FROM products p
JOIN orders o
ON p.product_id = o.product_id
JOIN customers c
ON c.customer_id = o.customer_id
GROUP BY c.customer_id, c.customer_name
ORDER BY average_order_value DESC;

-- 5. Retrieve the customers who have made more than the average order quantity.
SELECT c.customer_id, 
       c.customer_name
FROM customers c
JOIN
(SELECT customer_id, AVG(quantity) AS avg_quantity
FROM orders
GROUP BY customer_id) as avg_orders
ON c.customer_id = avg_orders.customer_id
JOIN orders o ON c.customer_id = o.customer_id
WHERE o.quantity > avg_quantity;

**Query #1**

    SELECT c.customer_name,p.product_name, o.quantity
    FROM products p
    JOIN orders o
    ON p.product_id = o.product_id
    JOIN customers c
    ON c.customer_id = o.customer_id;

| customer_name | product_name       | quantity |
| ------------- | ------------------ | -------- |
| John Doe      | iPhone 12          | 2        |
| Jane Smith    | Nike Air Max       | 1        |
| Mike Johnson  | Samsung Galaxy S21 | 3        |
| Emily Brown   | Sony PlayStation 5 | 1        |
| David Wilson  | iPhone 12          | 1        |
| John Doe      | Nike Air Max       | 2        |
| Jane Smith    | Samsung Galaxy S21 | 1        |
| Mike Johnson  | MacBook Pro        | 1        |
| Emily Brown   | Sony PlayStation 5 | 2        |
| David Wilson  | iPhone 12          | 3        |

---
**Query #2**

    SELECT p.category, 
           SUM(o.product_id) AS total_quantity, 
           SUM(price*quantity) AS total_revenue
    FROM products p
    JOIN orders o
    ON p.product_id = o.product_id
    GROUP BY p.category;

| category    | total_quantity | total_revenue |
| ----------- | -------------- | ------------- |
| Electronics | 12             | 11099.89      |
| Fashion     | 6              | 389.97        |
| Gaming      | 8              | 1499.97       |

---
**Query #3**

    WITH ProductTotalQuantity AS (
      SELECT p.category, p.product_name, SUM(o.quantity) AS total_quantity
      FROM products p
      JOIN orders o ON p.product_id = o.product_id
      GROUP BY p.category, p.product_name
    )
    SELECT category, product_name, total_quantity
    FROM ProductTotalQuantity
    WHERE (category, total_quantity) IN (
      SELECT category, MAX(total_quantity)
      FROM ProductTotalQuantity
      GROUP BY category
    );

| category    | product_name       | total_quantity |
| ----------- | ------------------ | -------------- |
| Electronics | iPhone 12          | 6              |
| Fashion     | Nike Air Max       | 3              |
| Gaming      | Sony PlayStation 5 | 3              |

---
**Query #4**

    SELECT c.customer_id, 
           c.customer_name, 
           ROUND(avg(price*quantity),2) as average_order_value
    FROM products p
    JOIN orders o
    ON p.product_id = o.product_id
    JOIN customers c
    ON c.customer_id = o.customer_id
    GROUP BY c.customer_id, c.customer_name
    ORDER BY average_order_value DESC;

| customer_id | customer_name | average_order_value |
| ----------- | ------------- | ------------------- |
| 3           | Mike Johnson  | 2099.98             |
| 5           | David Wilson  | 1999.98             |
| 1           | John Doe      | 1129.98             |
| 4           | Emily Brown   | 749.99              |
| 2           | Jane Smith    | 514.99              |

---
**Query #5**

    SELECT c.customer_id, 
           c.customer_name
    FROM customers c
    JOIN
    (SELECT customer_id, AVG(quantity) AS avg_quantity
    FROM orders
    GROUP BY customer_id) as avg_orders
    ON c.customer_id = avg_orders.customer_id
    JOIN orders o ON c.customer_id = o.customer_id
    WHERE o.quantity > avg_quantity;

| customer_id | customer_name |
| ----------- | ------------- |
| 3           | Mike Johnson  |
| 4           | Emily Brown   |
| 5           | David Wilson  |

---

[View on DB Fiddle](https://www.db-fiddle.com/f/xtvT8co9LVD2K41UcpYcaE/11)