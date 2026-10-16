-- JOIN türleri: INNER, LEFT ve SELF JOIN
CREATE TABLE IF NOT EXISTS departments_demo (department_id INTEGER PRIMARY KEY, department_name TEXT NOT NULL);
CREATE TABLE IF NOT EXISTS employees_demo (employee_id INTEGER PRIMARY KEY, full_name TEXT NOT NULL, manager_id INTEGER, department_id INTEGER,
 FOREIGN KEY(manager_id) REFERENCES employees_demo(employee_id), FOREIGN KEY(department_id) REFERENCES departments_demo(department_id));
INSERT INTO departments_demo VALUES (1,'Engineering'),(2,'Data'),(3,'HR') ON CONFLICT(department_id) DO NOTHING;
INSERT INTO employees_demo VALUES (1,'Özge',NULL,1),(2,'Ali',1,1),(3,'Deniz',1,2),(4,'Ece',NULL,NULL) ON CONFLICT(employee_id) DO NOTHING;
-- INNER JOIN: yalnız eşleşen kayıtlar
SELECT e.full_name,d.department_name FROM employees_demo e JOIN departments_demo d ON d.department_id=e.department_id;
-- LEFT JOIN: departmanı olmayan çalışanlar da görünür
SELECT e.full_name,d.department_name FROM employees_demo e LEFT JOIN departments_demo d ON d.department_id=e.department_id;
-- SELF JOIN: çalışan ve yöneticisi
SELECT e.full_name AS employee,m.full_name AS manager FROM employees_demo e LEFT JOIN employees_demo m ON m.employee_id=e.manager_id;
-- Departman başına çalışan sayısı, boş departmanlar dahil
SELECT d.department_name,COUNT(e.employee_id) AS employee_count FROM departments_demo d LEFT JOIN employees_demo e ON e.department_id=d.department_id GROUP BY d.department_id,d.department_name;
