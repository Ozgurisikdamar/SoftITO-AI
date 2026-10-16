-- VIEW, INDEX and query plan concepts
CREATE TABLE IF NOT EXISTS orders_demo(order_id INTEGER PRIMARY KEY,customer_id INTEGER NOT NULL,order_date DATE NOT NULL,total_amount NUMERIC NOT NULL CHECK(total_amount>=0),status TEXT NOT NULL);
CREATE INDEX IF NOT EXISTS idx_orders_customer_date ON orders_demo(customer_id,order_date);
CREATE VIEW IF NOT EXISTS completed_orders_demo AS SELECT order_id,customer_id,order_date,total_amount FROM orders_demo WHERE status='completed';
SELECT * FROM completed_orders_demo;
-- Indexes help selective WHERE/JOIN/ORDER BY predicates but consume space and slow writes.
-- SQLite: EXPLAIN QUERY PLAN SELECT * FROM orders_demo WHERE customer_id=10 ORDER BY order_date;
-- PostgreSQL: EXPLAIN (ANALYZE, BUFFERS) SELECT * FROM orders_demo WHERE customer_id=10 ORDER BY order_date;
-- EXPLAIN ANALYZE executes the statement. Be careful with expensive or mutating queries.
