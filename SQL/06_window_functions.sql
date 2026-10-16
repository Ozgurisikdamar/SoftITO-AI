-- Window functions: ROW_NUMBER, RANK, DENSE_RANK, SUM OVER, LAG
CREATE TABLE IF NOT EXISTS scores_demo(student_id INTEGER PRIMARY KEY,student_name TEXT NOT NULL,class_name TEXT NOT NULL,score NUMERIC NOT NULL);
INSERT INTO scores_demo VALUES (1,'Ada','A',92),(2,'Mert','A',85),(3,'Ece','A',92),(4,'Can','B',78),(5,'Deniz','B',88) ON CONFLICT(student_id) DO NOTHING;
SELECT student_name,class_name,score,ROW_NUMBER() OVER(PARTITION BY class_name ORDER BY score DESC,student_name) AS row_num,RANK() OVER(PARTITION BY class_name ORDER BY score DESC) AS rank_in_class,DENSE_RANK() OVER(PARTITION BY class_name ORDER BY score DESC) AS dense_rank FROM scores_demo;
SELECT student_name,score,SUM(score) OVER(ORDER BY student_id ROWS BETWEEN UNBOUNDED PRECEDING AND CURRENT ROW) AS running_total FROM scores_demo;
SELECT student_name,score,LAG(score) OVER(ORDER BY student_id) AS previous_score,score-LAG(score) OVER(ORDER BY student_id) AS delta FROM scores_demo;
