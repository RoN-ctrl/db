SELECT std.name, std.surname, AVG(er.mark)
FROM students std
INNER JOIN exam_results er ON er.student_id = std.student_id
WHERE std.surname = 'surname1'
GROUP BY std.name, std.surname;