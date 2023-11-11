**Schema (MySQL v8.0)**

    CREATE TABLE employees (
        employee_id INT PRIMARY KEY,
        employee_name VARCHAR(50),
        department_id INT,
        manager_id INT,
        salary DECIMAL(10, 2)
    );
    
    CREATE TABLE departments (
        department_id INT PRIMARY KEY,
        department_name VARCHAR(50)
    );
    
    INSERT INTO departments (department_id, department_name)
    VALUES
        (1, 'HR'),
        (2, 'Finance'),
        (3, 'Sales'),
        (4, 'Marketing'),
        (5, 'IT');
    
    INSERT INTO employees (employee_id, employee_name, department_id, manager_id, salary)
    VALUES
        (1, 'John Doe', 1, NULL, 5000.00),
        (2, 'Jane Smith', 2, 1, 6000.00),
        (3, 'Michael Johnson', 3, 2, 4500.00),
        (4, 'Emily Brown', 3, 2, 5500.00),
        (5, 'David Wilson', 4, 1, 4000.00),
        (6, 'Sarah Davis', 4, 5, 4800.00),
        (7, 'Robert Anderson', 5, 6, 5200.00),
        (8, 'Laura Clark', 5, 6, 4700.00),
        (9, 'Daniel Turner', 3, 2, 5200.00),
        (10, 'Olivia Harris', 2, 1, 5500.00);
    

---

--  Question 1: Calculate the total salary expenditure for each department and display the departments in descending order of the total salary expenditure.

WITH department_salary AS
(
SELECT 
      department_id, 
      SUM(salary) as total_salary
FROM employees 
GROUP BY department_id
)
SELECT 
       d1.department_name,
       d2.total_salary as total_salary_expenditure
FROM departments d1
JOIN department_salary d2
ON d1.department_id = d2.department_id
ORDER BY total_salary_expenditure DESC;



SELECT
    d.department_name,
    SUM(e.salary) AS total_salary_expenditure
FROM
    departments d
LEFT JOIN
    employees e ON d.department_id = e.department_id
GROUP BY
    d.department_name
ORDER BY
    total_salary_expenditure DESC;


-- Question 2: Retrieve the employees who have at least two subordinates.

SELECT
    e1.employee_name AS employee_with_subordinates,
    COUNT(*) AS num_subordinates
FROM
    employees e1
INNER JOIN
    employees e2 ON e1.employee_id = e2.manager_id
GROUP BY
    e1.employee_name
HAVING
    COUNT(*) >= 2;
    
    
-- --- ----- 

WITH subordinate_count AS (
    SELECT manager_id, COUNT(*) AS num_subordinates
    FROM employees
    GROUP BY manager_id
)
SELECT e.employee_name, sc.num_subordinates
FROM employees e
JOIN subordinate_count sc ON e.employee_id = sc.manager_id
WHERE sc.num_subordinates >= 2;

-- -- Question 2: Retrieve the employees who have at least two subordinates.

SELECT
    e1.employee_name AS employee_with_subordinates,
    COUNT(*) AS num_subordinates
FROM
    employees e1
INNER JOIN
    employees e2 ON e1.employee_id = e2.manager_id
GROUP BY
    e1.employee_name
HAVING
    COUNT(*) >= 2;
    
    
-- --- ----- 

WITH subordinate_count AS (
    SELECT manager_id, COUNT(*) AS num_subordinates
    FROM employees
    GROUP BY manager_id
)
SELECT e.employee_name, sc.num_subordinates
FROM employees e
JOIN subordinate_count sc ON e.employee_id = sc.manager_id
WHERE sc.num_subordinates >= 2;


-- Question 3: Calculate the average salary for each department, considering only employees with a salary greater than the department average.

WITH DepartmentAvgSalary AS (
    SELECT
        d.department_id,
        AVG(e.salary) AS avg_salary
    FROM
        departments d
    LEFT JOIN
        employees e ON d.department_id = e.department_id
    GROUP BY
        d.department_id
)
SELECT
    d.department_name,
    ROUND(AVG(e.salary),2) AS average_salary
FROM
    departments d
LEFT JOIN
    employees e ON d.department_id = e.department_id
JOIN
    DepartmentAvgSalary a ON d.department_id = a.department_id
WHERE
    e.salary > a.avg_salary
GROUP BY
    d.department_name;


-- ---

WITH department_avg AS (
    SELECT department_id, AVG(salary) AS avg_salary
    FROM employees
    GROUP BY department_id
)
SELECT  d.department_name, ROUND(AVG(e.salary),2) AS avg_salary
FROM employees e
JOIN department_avg da ON e.department_id = da.department_id
JOIN departments d ON e.department_id = d.department_id
WHERE e.salary > da.avg_salary
GROUP BY  d.department_name;

  -- Question 4: Find the employees who have the highest salary in their respective departments.  
WITH max_salary_per_department AS
(SELECT department_id, MAX(salary) as max_salary
FROM employees 
GROUP BY department_id)
SELECT 
      employee_name,
      salary,
      department_name
FROM employees e
JOIN max_salary_per_department d1
ON e.department_id = d1.department_id
JOIN departments d2
ON d1.department_id = d2.department_id
WHERE e.salary = d1.max_salary;


-- ---------------

SELECT
    d.department_name,
    e.employee_name,
    e.salary
FROM
    departments d
LEFT JOIN
    employees e ON d.department_id = e.department_id
WHERE
    (e.department_id, e.salary) IN (
        SELECT
            department_id,
            MAX(salary)
        FROM
            employees
        GROUP BY
            department_id
    );

      
-- Question 5: Calculate the running total of salaries for each department, ordered by department ID and employee name.

WITH running_total AS (
    SELECT department_id, employee_name, salary,
           SUM(salary) OVER (PARTITION BY department_id ORDER BY employee_name) AS total_salary
    FROM employees
)
SELECT department_id, employee_name, salary, total_salary
FROM running_total
ORDER BY department_id, employee_name;



WITH DepartmentSalaries AS (
    SELECT
        d.department_id,
        e.employee_name,
        e.salary,
        ROW_NUMBER() OVER (PARTITION BY d.department_id ORDER BY e.employee_name) AS row_num
    FROM
        departments d
    LEFT JOIN
        employees e ON d.department_id = e.department_id
)
SELECT
    d.department_name,
    ds.employee_name,
    ds.salary,
    SUM(ds.salary) OVER (PARTITION BY ds.department_id ORDER BY ds.row_num) AS running_total
FROM
    departments d
LEFT JOIN
    DepartmentSalaries ds ON d.department_id = ds.department_id
ORDER BY
    ds.department_id,
    ds.row_num;



**Query #1**

    WITH department_salary AS
    (
    SELECT 
          department_id, 
          SUM(salary) as total_salary
    FROM employees 
    GROUP BY department_id
    )
    SELECT 
           d1.department_name,
           d2.total_salary as total_salary_expenditure
    FROM departments d1
    JOIN department_salary d2
    ON d1.department_id = d2.department_id
    ORDER BY total_salary_expenditure DESC;

| department_name | total_salary_expenditure |
| --------------- | ------------------------ |
| Sales           | 15200.00                 |
| Finance         | 11500.00                 |
| IT              | 9900.00                  |
| Marketing       | 8800.00                  |
| HR              | 5000.00                  |

---
**Query #2**

    SELECT
        d.department_name,
        SUM(e.salary) AS total_salary_expenditure
    FROM
        departments d
    LEFT JOIN
        employees e ON d.department_id = e.department_id
    GROUP BY
        d.department_name
    ORDER BY
        total_salary_expenditure DESC;

| department_name | total_salary_expenditure |
| --------------- | ------------------------ |
| Sales           | 15200.00                 |
| Finance         | 11500.00                 |
| IT              | 9900.00                  |
| Marketing       | 8800.00                  |
| HR              | 5000.00                  |

---
**Query #3**

    SELECT
        e1.employee_name AS employee_with_subordinates,
        COUNT(*) AS num_subordinates
    FROM
        employees e1
    INNER JOIN
        employees e2 ON e1.employee_id = e2.manager_id
    GROUP BY
        e1.employee_name
    HAVING
        COUNT(*) >= 2;

| employee_with_subordinates | num_subordinates |
| -------------------------- | ---------------- |
| John Doe                   | 3                |
| Jane Smith                 | 3                |
| Sarah Davis                | 2                |

---
**Query #4**

    WITH subordinate_count AS (
        SELECT manager_id, COUNT(*) AS num_subordinates
        FROM employees
        GROUP BY manager_id
    )
    SELECT e.employee_name, sc.num_subordinates
    FROM employees e
    JOIN subordinate_count sc ON e.employee_id = sc.manager_id
    WHERE sc.num_subordinates >= 2;

| employee_name | num_subordinates |
| ------------- | ---------------- |
| John Doe      | 3                |
| Jane Smith    | 3                |
| Sarah Davis   | 2                |

---
**Query #5**

    SELECT
        e1.employee_name AS employee_with_subordinates,
        COUNT(*) AS num_subordinates
    FROM
        employees e1
    INNER JOIN
        employees e2 ON e1.employee_id = e2.manager_id
    GROUP BY
        e1.employee_name
    HAVING
        COUNT(*) >= 2;

| employee_with_subordinates | num_subordinates |
| -------------------------- | ---------------- |
| John Doe                   | 3                |
| Jane Smith                 | 3                |
| Sarah Davis                | 2                |

---
**Query #6**

    WITH subordinate_count AS (
        SELECT manager_id, COUNT(*) AS num_subordinates
        FROM employees
        GROUP BY manager_id
    )
    SELECT e.employee_name, sc.num_subordinates
    FROM employees e
    JOIN subordinate_count sc ON e.employee_id = sc.manager_id
    WHERE sc.num_subordinates >= 2;

| employee_name | num_subordinates |
| ------------- | ---------------- |
| John Doe      | 3                |
| Jane Smith    | 3                |
| Sarah Davis   | 2                |

---
**Query #7**

    WITH DepartmentAvgSalary AS (
        SELECT
            d.department_id,
            AVG(e.salary) AS avg_salary
        FROM
            departments d
        LEFT JOIN
            employees e ON d.department_id = e.department_id
        GROUP BY
            d.department_id
    )
    SELECT
        d.department_name,
        ROUND(AVG(e.salary),2) AS average_salary
    FROM
        departments d
    LEFT JOIN
        employees e ON d.department_id = e.department_id
    JOIN
        DepartmentAvgSalary a ON d.department_id = a.department_id
    WHERE
        e.salary > a.avg_salary
    GROUP BY
        d.department_name;

| department_name | average_salary |
| --------------- | -------------- |
| Finance         | 6000.00        |
| Sales           | 5350.00        |
| Marketing       | 4800.00        |
| IT              | 5200.00        |

---
**Query #8**

    WITH department_avg AS (
        SELECT department_id, AVG(salary) AS avg_salary
        FROM employees
        GROUP BY department_id
    )
    SELECT  d.department_name, ROUND(AVG(e.salary),2) AS avg_salary
    FROM employees e
    JOIN department_avg da ON e.department_id = da.department_id
    JOIN departments d ON e.department_id = d.department_id
    WHERE e.salary > da.avg_salary
    GROUP BY  d.department_name;

| department_name | avg_salary |
| --------------- | ---------- |
| Finance         | 6000.00    |
| Sales           | 5350.00    |
| Marketing       | 4800.00    |
| IT              | 5200.00    |

---
**Query #9**

    WITH max_salary_per_department AS
    (SELECT department_id, MAX(salary) as max_salary
    FROM employees 
    GROUP BY department_id)
    SELECT 
          employee_name,
          salary,
          department_name
    FROM employees e
    JOIN max_salary_per_department d1
    ON e.department_id = d1.department_id
    JOIN departments d2
    ON d1.department_id = d2.department_id
    WHERE e.salary = d1.max_salary;

| employee_name   | salary  | department_name |
| --------------- | ------- | --------------- |
| John Doe        | 5000.00 | HR              |
| Jane Smith      | 6000.00 | Finance         |
| Emily Brown     | 5500.00 | Sales           |
| Sarah Davis     | 4800.00 | Marketing       |
| Robert Anderson | 5200.00 | IT              |

---
**Query #10**

    SELECT
        d.department_name,
        e.employee_name,
        e.salary
    FROM
        departments d
    LEFT JOIN
        employees e ON d.department_id = e.department_id
    WHERE
        (e.department_id, e.salary) IN (
            SELECT
                department_id,
                MAX(salary)
            FROM
                employees
            GROUP BY
                department_id
        );

| department_name | employee_name   | salary  |
| --------------- | --------------- | ------- |
| HR              | John Doe        | 5000.00 |
| Finance         | Jane Smith      | 6000.00 |
| Sales           | Emily Brown     | 5500.00 |
| Marketing       | Sarah Davis     | 4800.00 |
| IT              | Robert Anderson | 5200.00 |

---
**Query #11**

    WITH running_total AS (
        SELECT department_id, employee_name, salary,
               SUM(salary) OVER (PARTITION BY department_id ORDER BY employee_name) AS total_salary
        FROM employees
    )
    SELECT department_id, employee_name, salary, total_salary
    FROM running_total
    ORDER BY department_id, employee_name;

| department_id | employee_name   | salary  | total_salary |
| ------------- | --------------- | ------- | ------------ |
| 1             | John Doe        | 5000.00 | 5000.00      |
| 2             | Jane Smith      | 6000.00 | 6000.00      |
| 2             | Olivia Harris   | 5500.00 | 11500.00     |
| 3             | Daniel Turner   | 5200.00 | 5200.00      |
| 3             | Emily Brown     | 5500.00 | 10700.00     |
| 3             | Michael Johnson | 4500.00 | 15200.00     |
| 4             | David Wilson    | 4000.00 | 4000.00      |
| 4             | Sarah Davis     | 4800.00 | 8800.00      |
| 5             | Laura Clark     | 4700.00 | 4700.00      |
| 5             | Robert Anderson | 5200.00 | 9900.00      |

---
**Query #12**

    WITH DepartmentSalaries AS (
        SELECT
            d.department_id,
            e.employee_name,
            e.salary,
            ROW_NUMBER() OVER (PARTITION BY d.department_id ORDER BY e.employee_name) AS row_num
        FROM
            departments d
        LEFT JOIN
            employees e ON d.department_id = e.department_id
    )
    SELECT
        d.department_name,
        ds.employee_name,
        ds.salary,
        SUM(ds.salary) OVER (PARTITION BY ds.department_id ORDER BY ds.row_num) AS running_total
    FROM
        departments d
    LEFT JOIN
        DepartmentSalaries ds ON d.department_id = ds.department_id
    ORDER BY
        ds.department_id,
        ds.row_num;

| department_name | employee_name   | salary  | running_total |
| --------------- | --------------- | ------- | ------------- |
| HR              | John Doe        | 5000.00 | 5000.00       |
| Finance         | Jane Smith      | 6000.00 | 6000.00       |
| Finance         | Olivia Harris   | 5500.00 | 11500.00      |
| Sales           | Daniel Turner   | 5200.00 | 5200.00       |
| Sales           | Emily Brown     | 5500.00 | 10700.00      |
| Sales           | Michael Johnson | 4500.00 | 15200.00      |
| Marketing       | David Wilson    | 4000.00 | 4000.00       |
| Marketing       | Sarah Davis     | 4800.00 | 8800.00       |
| IT              | Laura Clark     | 4700.00 | 4700.00       |
| IT              | Robert Anderson | 5200.00 | 9900.00       |

---

[View on DB Fiddle](https://www.db-fiddle.com/f/3i2ugMuWWkMDrqmbVs72Xm/5)