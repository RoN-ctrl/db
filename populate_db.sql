-- Populate students

INSERT INTO students(name, surname, date_of_birth, phone_number, primary_skill)
VALUES ('name1', 'surname1', '2000-01-01', 1111111, 'skill 1'),
	   ('name2', 'surname2', '2000-02-02', 2222222, 'skill 2'),
       ('name3', 'surname3', '2000-03-03', 3333333, 'skill 3'),
       ('name4', 'surname4', '2000-04-04', 4444444, 'skill 4'),
       ('name5', 'surname5', '2000-05-05', 5555555, 'skill 5'),
       ('name6', 'surname6', '2000-06-06', 6666666, 'skill 6'),
       ('name7', 'surname7', '2000-07-07', 7777777, 'skill 7'),
       ('name8', 'surname8', '2000-08-08', 8888888, 'skill 8'),
       ('name9', 'surname9', '2000-09-09', 9999999, 'skill 9');

INSERT INTO students(name, surname, date_of_birth, phone_number, primary_skill)
SELECT 
	LEFT(md5(RANDOM()::TEXT), 7), 
	LEFT(md5(RANDOM()::TEXT), 10),
	DATE '2000-01-01' + (random() * 2000):: integer,
	(RANDOM() * 100000000)::INTEGER,
	LEFT(md5(RANDOM()::TEXT), 15)
FROM generate_series(1, 100000);

-- Populate subjects

INSERT INTO subjects (subject_name, tutor)
VALUES ('subject1', 'tutor1'),
       ('subject2', 'tutor2'),
       ('subject3', 'tutor3'),
       ('subject4', 'tutor4'),
       ('subject5', 'tutor5');

INSERT INTO subjects(subject_name, tutor)
SELECT 
	LEFT(md5(RANDOM()::TEXT), 10), 
	LEFT(md5(RANDOM()::TEXT), 10)
FROM generate_series(1, 10000);

-- Populate exam_results

INSERT INTO exam_results (student_id, subject_id, mark)
VALUES (1, 1, 2), (1, 2, 5), (1, 3, 4), (1, 4, 1), (1, 5, 4),
       (2, 1, 3), (2, 2, 5), (2, 3, 1), (2, 4, 4), (2, 5, 4),
       (3, 1, 4), (3, 2, 5), (3, 3, 4), (3, 4, 5), (3, 5, 5),
       (4, 1, 2), (4, 2, 1), (4, 3, 1), (4, 4, 1), (4, 5, 1),
       (5, 1, 4), (5, 2, 4), (5, 3, 4), (5, 4, 4), (5, 5, 4),
       (6, 1, 4), (6, 2, 5), (6, 3, 1), (6, 4, 4), (6, 5, 4),
       (7, 1, 4), (7, 2, 3), (7, 3, 2), (7, 4, 3), (7, 5, 4),
       (8, 1, 4), (8, 2, 4), (8, 3, 4), (8, 4, 5), (8, 5, 4),
       (9, 1, 4), (9, 2, 2), (9, 3, 3), (9, 4, 2), (9, 5, 1);

-- INSERT INTO exam_results(student_id, subject_id, mark)
-- WITH expanded AS (
--     SELECT random(), seq, stu.student_id AS student_id, sub.subject_id AS subject_id
--     FROM GENERATE_SERIES(1, 10000000) seq,
--          students stu,
--          subjects sub
-- ),
--      shuffled AS (
--          SELECT e.*
--          FROM expanded e
--                   INNER JOIN (
--              SELECT ei.seq, MIN(ei.random)
--              FROM expanded ei
--              GROUP BY ei.seq
--          ) em ON (e.seq = em.seq AND e.random = em.min)
--          ORDER BY e.seq
--      )
-- SELECT exam_results.student_id, exam_results.subject_id, (random() * (5 - 1) + 1)::integer
-- FROM shuffled exam_results;