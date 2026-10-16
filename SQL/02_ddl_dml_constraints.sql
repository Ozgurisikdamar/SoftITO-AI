-- DDL, DML AND CONSTRAINTS
-- SQLite/PostgreSQL ortak temelleri. Otomatik artan kimlik sözdizimi motora göre değişir.

CREATE TABLE IF NOT EXISTS departments_demo (
    department_id INTEGER PRIMARY KEY,
    department_name TEXT NOT NULL UNIQUE
);

CREATE TABLE IF NOT EXISTS employees_demo (
    employee_id INTEGER PRIMARY KEY,
    full_name TEXT NOT NULL,
    email TEXT UNIQUE,
    salary NUMERIC NOT NULL CHECK (salary >= 0),
    department_id INTEGER,
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    FOREIGN KEY (department_id) REFERENCES departments_demo(department_id)
);

INSERT INTO departments_demo (department_id, department_name)
VALUES (10, 'Engineering'), (20, 'Analytics')
ON CONFLICT (department_id) DO NOTHING;

INSERT INTO employees_demo (employee_id, full_name, email, salary, department_id)
VALUES (1, 'Ada Yılmaz', 'ada@example.com', 65000, 10)
ON CONFLICT (employee_id) DO NOTHING;

-- SELECT ile hedef kayıtları önce kontrol edin.
SELECT * FROM employees_demo WHERE employee_id = 1;

-- UPDATE: mutlaka hedefleyen WHERE koşulu kullanın.
UPDATE employees_demo SET salary = salary * 1.05 WHERE employee_id = 1;

-- INSERT: sadece gerekli sütunları belirtin.
INSERT INTO employees_demo (employee_id, full_name, email, salary, department_id)
VALUES (2, 'Mert Kaya', 'mert@example.com', 52000, 20)
ON CONFLICT (employee_id) DO NOTHING;

-- DELETE: önce aynı filtreyi SELECT ile kontrol edin.
-- SELECT * FROM employees_demo WHERE employee_id = 2;
-- DELETE FROM employees_demo WHERE employee_id = 2;

-- DDL: yeni sütun ekleme (tekrar çalıştırılabilirlik motorlara göre değişir).
-- ALTER TABLE employees_demo ADD COLUMN phone TEXT;

-- CHECK kısıtını görmek için aşağıdaki hatalı örneği yorumdan çıkarın:
-- INSERT INTO employees_demo (employee_id, full_name, salary) VALUES (99, 'Invalid', -1);

-- DROP TABLE employees_demo; -- tüm tabloyu siler; dikkatli kullanın.
