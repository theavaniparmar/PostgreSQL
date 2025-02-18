--subquery
CREATE TABLE employees_info (
    id SERIAL PRIMARY KEY,
    name TEXT,
    department TEXT,
    salary INT
);

INSERT INTO employees_info (name, department, salary) VALUES
('Alice', 'HR', 50000),
('Bob', 'IT', 70000),
('Charlie', 'IT', 80000),
('David', 'HR', 45000),
('Eve', 'Finance', 60000);

SELECT name, salary FROM employees_info
WHERE salary > (SELECT AVG(salary) FROM employees_info);



