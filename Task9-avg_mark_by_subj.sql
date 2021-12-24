SELECT subj.subject_name, AVG(er.mark)
FROM subjects subj
INNER JOIN exam_results er ON subj.subject_id = er.subject_id
WHERE subj.subject_name = 'subject2'
GROUP BY subj.subject_name;