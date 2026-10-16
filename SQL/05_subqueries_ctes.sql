-- Alt sorgular, EXISTS ve CTE
CREATE TABLE IF NOT EXISTS products_demo(product_id INTEGER PRIMARY KEY,product_name TEXT NOT NULL,category TEXT NOT NULL,price NUMERIC NOT NULL CHECK(price>=0));
INSERT INTO products_demo VALUES (1,'Keyboard','Accessories',50),(2,'Mouse','Accessories',25),(3,'Monitor','Displays',220),(4,'Webcam','Accessories',80) ON CONFLICT(product_id) DO NOTHING;
-- Genel ortalamanın üzerindeki ürünler
SELECT product_name,price FROM products_demo WHERE price>(SELECT AVG(price) FROM products_demo);
-- EXISTS: aynı kategoride daha pahalı ürün var mı?
SELECT p.product_name FROM products_demo p WHERE EXISTS(SELECT 1 FROM products_demo p2 WHERE p2.category=p.category AND p2.price>p.price);
-- CTE sorguyu okunabilir alt parçalara ayırır
WITH category_stats AS (SELECT category,AVG(price) AS avg_price,COUNT(*) AS product_count FROM products_demo GROUP BY category)
SELECT p.product_name,p.category,p.price,s.avg_price,s.product_count FROM products_demo p JOIN category_stats s ON s.category=p.category WHERE p.price>s.avg_price;
-- NOT EXISTS, NULL içerebilen NOT IN alt sorgularına güvenli bir alternatiftir.
SELECT p.product_name FROM products_demo p WHERE NOT EXISTS(SELECT 1 FROM products_demo cheaper WHERE cheaper.category=p.category AND cheaper.price<p.price);
