CREATE MATERIALIZED VIEW students_snapshot
AS SELECT std.name, std.surname, subj.subject_name, er.mark
FROM students std
INNER JOIN exam_results er ON std.student_id = er.student_id
INNER JOIN subjects subj ON subj.subject_id = er.subject_id;

UPDATE students SET name = 'name66' WHERE name = 'name6';

SELECT * FROM students_snapshot;