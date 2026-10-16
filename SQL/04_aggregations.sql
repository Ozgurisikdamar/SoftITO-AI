-- Aggregate fonksiyonlar, GROUP BY, HAVING, CASE
CREATE TABLE IF NOT EXISTS sales_demo (sale_id INTEGER PRIMARY KEY,salesperson TEXT NOT NULL,region TEXT NOT NULL,amount NUMERIC NOT NULL CHECK(amount>=0),sale_date DATE NOT NULL);
INSERT INTO sales_demo VALUES (1,'Aylin','Marmara',1200,'2026-01-10'),(2,'Aylin','Marmara',800,'2026-01-12'),(3,'Burak','Ege',1500,'2026-01-15'),(4,'Cem','Marmara',400,'2026-02-02'),(5,'Burak','Ege',700,'2026-02-05') ON CONFLICT(sale_id) DO NOTHING;
SELECT COUNT(*) AS row_count,SUM(amount) AS revenue,ROUND(AVG(amount),2) AS average_sale,MIN(amount),MAX(amount) FROM sales_demo;
SELECT region,COUNT(*) AS sales_count,SUM(amount) AS revenue FROM sales_demo GROUP BY region HAVING SUM(amount)>=1000 ORDER BY revenue DESC;
SELECT salesperson,SUM(CASE WHEN sale_date<'2026-02-01' THEN amount ELSE 0 END) AS january_revenue,SUM(CASE WHEN sale_date>='2026-02-01' THEN amount ELSE 0 END) AS february_revenue FROM sales_demo GROUP BY salesperson;
-- COUNT(column) NULL değerleri saymaz; COUNT(*) her satırı sayar.
