USE sen307_11882;

SELECT
    c.course_title,
    COUNT(e.student_id) AS total_students
FROM Course c
LEFT JOIN Enrolment e
    ON c.course_id = e.course_id
GROUP BY c.course_id, c.course_title
ORDER BY total_students DESC;

-- TASK 1: Count the number of students enrolled in each course.
-- LEFT JOIN is used so that courses with no enrolled students are included.
-- COUNT(e.student_id) counts only actual student enrolments.
-- GROUP BY groups the results by course.
-- ORDER BY displays courses with the highest enrolment first.


SELECT
    c.course_title,
    COUNT(e.student_id) AS total_students
FROM Course c
LEFT JOIN Enrolment e
    ON c.course_id = e.course_id
GROUP BY c.course_id, c.course_title
HAVING COUNT(e.student_id) > 3
ORDER BY total_students DESC;

-- TASK 2: Find courses with more than a specified number of students.
-- GROUP BY groups students according to their courses.
-- HAVING filters the grouped results based on the number of students.
-- Change the threshold (3, 5, or 7) to test different results.


SELECT ROUND(AVG(course_count), 2) AS average_courses
FROM (
    SELECT
        s.student_id,
        COUNT(e.course_id) AS course_count
    FROM Student s
    LEFT JOIN Enrolment e
        ON s.student_id = e.student_id
    GROUP BY s.student_id
) AS per_student;

-- TASK 3: Calculate the average number of courses taken per student.
-- The inner query counts the courses taken by each student.
-- LEFT JOIN includes students who have not enrolled in any course.
-- The outer query calculates the average of those individual course counts.
-- ROUND displays the average to two decimal places.


SELECT
    student_id,
    full_name
FROM Student
WHERE student_id NOT IN (
    SELECT student_id
    FROM Enrolment
);

-- TASK 4: Find students who are not enrolled in any course.
-- The subquery retrieves student IDs from the Enrolment table.
-- NOT IN selects students whose IDs do not appear in that list.
-- This demonstrates the use of a non-correlated subquery.


SELECT
    d.dept_name,
    s.full_name,
    (
        SELECT COUNT(*)
        FROM Enrolment e
        WHERE e.student_id = s.student_id
    ) AS courses
FROM Student s
JOIN Department d
    ON s.dept_id = d.dept_id
WHERE (
    SELECT COUNT(*)
    FROM Enrolment e
    WHERE e.student_id = s.student_id
) = (
    SELECT MAX(student_courses)
    FROM (
        SELECT
            st.student_id,
            COUNT(en.course_id) AS student_courses
        FROM Student st
        LEFT JOIN Enrolment en
            ON st.student_id = en.student_id
        WHERE st.dept_id = s.dept_id
        GROUP BY st.student_id
    ) AS department_counts
)
ORDER BY d.dept_name;

-- TASK 5: Find the student(s) with the highest number of enrolments in each department.
-- The correlated subquery counts the enrolments of each student.
-- The department condition ensures comparisons are made within
-- the same department.
-- Students tied for the highest number of enrolments are included.