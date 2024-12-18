SELECT school_id, COUNT(student_id) AS num_students
FROM students
GROUP BY school_id;
