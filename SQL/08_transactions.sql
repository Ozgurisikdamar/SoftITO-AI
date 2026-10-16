-- TRANSACTIONS AND ACID. Practice only in a disposable database.
CREATE TABLE IF NOT EXISTS accounts_demo(account_id INTEGER PRIMARY KEY,owner TEXT NOT NULL,balance NUMERIC NOT NULL CHECK(balance>=0));
INSERT INTO accounts_demo VALUES(1,'Aylin',1000),(2,'Burak',500) ON CONFLICT(account_id) DO NOTHING;
BEGIN;
UPDATE accounts_demo SET balance=balance-100 WHERE account_id=1 AND balance>=100;
UPDATE accounts_demo SET balance=balance+100 WHERE account_id=2;
SELECT * FROM accounts_demo WHERE account_id IN(1,2);
COMMIT;
-- To test rollback, run a separate transaction and replace COMMIT with ROLLBACK.
-- ACID = Atomicity, Consistency, Isolation, Durability.
-- Production code must check affected row counts and handle concurrent updates safely.
