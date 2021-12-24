SELECT std.name, std.surname, COUNT(er.mark) AS failed_subjects
FROM students std
INNER JOIN exam_results er ON std.student_id = er.student_id
WHERE er.mark != 5 AND er.mark !=4
GROUP BY std.name, std.surname
HAVING (COUNT(er.mark)) >= 2
ORDER BY std.name, std.surname;