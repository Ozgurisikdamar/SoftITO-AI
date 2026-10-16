-- Örnek çözümler; ilgili konu dosyasındaki tabloları kullanın.
SELECT customer_id,full_name FROM customers_demo WHERE is_active=1;
SELECT customer_id,full_name FROM customers_demo WHERE email IS NULL;
SELECT city,COUNT(*) AS customer_count FROM customers_demo GROUP BY city ORDER BY customer_count DESC;
SELECT product_name,price FROM products_demo ORDER BY price DESC LIMIT 3;
SELECT p.product_name,p.category,p.price FROM products_demo p
WHERE p.price>(SELECT AVG(p2.price) FROM products_demo p2 WHERE p2.category=p.category);
SELECT * FROM (
 SELECT student_name,class_name,score,ROW_NUMBER() OVER(PARTITION BY class_name ORDER BY score DESC) AS rn
 FROM scores_demo
) ranked WHERE rn<=2;
-- Müşteri/sipariş tabloları varsa:
-- SELECT c.customer_id FROM customers c
-- WHERE NOT EXISTS(SELECT 1 FROM orders o WHERE o.customer_id=c.customer_id);
