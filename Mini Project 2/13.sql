SELECT s1.student_id, s1.student_name, s1.school_id, s1.GPA
FROM students s1
WHERE (
    SELECT COUNT(*) 
    FROM students s2
    WHERE s2.school_id = s1.school_id AND s2.GPA > s1.GPA
) < 3
ORDER BY s1.school_id, s1.GPA DESC;
