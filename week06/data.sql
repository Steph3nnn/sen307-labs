USE sen307_11882;
INSERT INTO Lecturer (staff_no, full_name, email, dept_id) VALUES
('VUA/ST/101', 'Dr Amaka Okafor', 'a.okafor@vua.edu.ng', 1),
('VUA/ST/102', 'Dr Musa Bello', 'm.bello@vua.edu.ng', 1),
('VUA/ST/103', 'Dr Chinedu Eze', 'c.eze@vua.edu.ng', 2),
('VUA/ST/104', 'Mrs Fatima Ibrahim', 'f.ibrahim@vua.edu.ng', 2),
('VUA/ST/105', 'Dr Tunde Adeyemi', 't.adeyemi@vua.edu.ng', 3),
('VUA/ST/106', 'Mrs Ngozi Nwosu', 'n.nwosu@vua.edu.ng', 3),
('VUA/ST/107', 'Dr Samuel Ojo', 's.ojo@vua.edu.ng', 4),
('VUA/ST/108', 'Dr Zainab Abdullahi', 'z.abdullahi@vua.edu.ng', 4),
('VUA/ST/109', 'Mr Emeka Okeke', 'e.okeke@vua.edu.ng', 5),
('VUA/ST/110', 'Dr Grace Ekanem', 'g.ekanem@vua.edu.ng', 5);


-- STEP 2: INSERT 20 STUDENTS

INSERT INTO Student
(matric_no, full_name, gender, date_of_birth, dept_id) VALUES
('11882', 'Ochai Enenche', 'M', '2005-06-12', 1),
('12023', 'Ada Obi', 'F', '2005-03-14', 1),
('87789', 'John Musa', 'M', '2004-11-02', 2),
('11111', 'Chiamaka Eze', 'F', '2006-01-19', 2),
('34523', 'David Okafor', 'M', '2003-08-25', 3),
('89564', 'Blessing Adeyemi', 'F', '2005-12-10', 3),
('92113', 'Ibrahim Sani', 'M', '2004-05-17', 4),
('12674', 'Precious Nwosu', 'F', '2006-07-22', 4),
('83527', 'Samuel Ojo', 'M', '2005-09-03', 5),
('90812', 'Esther Ekanem', 'F', '2007-02-15', 5),
('79257', 'Emmanuel Okeke', 'M', '2004-04-08', 1),
('11437', 'Maryam Yusuf', 'F', '2006-10-21', 2),
('99865', 'Daniel Chukwu', 'M', '2003-12-30', 3),
('12345', 'Ruth Adebayo', 'F', '2005-05-11', 4),
('89567', 'Peter Nnamdi', 'M', '2007-06-18', 5),
('54322', 'Aisha Mohammed', 'F', '2004-09-27', 1),
('72411', 'Kelvin Ugwu', 'M', '2006-03-06', 2),
('99000', 'Favour Olamide', 'F', '2005-11-13', 3),
('88000', 'Michael Danjuma', 'M', '2003-07-09', 4),
('77899', 'Sarah Onyekachi', 'F', '2007-04-16', 5);



SELECT student_id, matric_no, full_name FROM Student;

SELECT lecturer_id, full_name FROM Lecturer;

SELECT course_id, course_name FROM Course;




INSERT INTO Enrolment (student_id, course_id) VALUES
(1, 1),
(1, 2),
(1, 3),
(1, 4),
(1, 5),

(2, 1),
(2, 2),

(3, 1),
(3, 3),

(4, 1),
(4, 2),

(5, 1),
(5, 4),

(6, 1),
(6, 5),

(7, 1),
(7, 2),

(8, 1),
(8, 3),

(9, 1),
(9, 4),

(10, 1),
(10, 5),

(11, 2),
(11, 3),

(12, 2),
(12, 4),

(13, 2),
(13, 5),

(14, 3),
(14, 4),

(15, 3),
(15, 5),

(16, 4),
(16, 5),

(17, 2),
(17, 3),

(18, 4),
(18, 5),

(18, 3);


-- STEP 5: INSERT COURSE ALLOCATIONS
-- Course 1 has two lecturers.
-- Every course has at least one lecturer.

INSERT INTO CourseAllocation (course_id, lecturer_id) VALUES
(1, 1),
(1, 2),
(2, 3),
(2, 4),
(3, 5),
(4, 7),
(5, 9);


-- STEP 6: VERIFY THE INSERTED DATA

-- Count lecturers
SELECT COUNT(*) AS total_lecturers FROM Lecturer;

-- Count students
SELECT COUNT(*) AS total_students FROM Student;

-- Count enrolments
SELECT COUNT(*) AS total_enrolments FROM Enrolment;


SELECT s.student_id, s.full_name
FROM Student s
LEFT JOIN Enrolment e
ON s.student_id = e.student_id
WHERE e.student_id IS NULL;

SELECT course_id, COUNT(*) AS total_students
FROM Enrolment
GROUP BY course_id;

-- Courses with more than 5 students
SELECT course_id, COUNT(*) AS total_students
FROM Enrolment
GROUP BY course_id
HAVING COUNT(*) > 5;


SELECT course_id, COUNT(*) AS total_lecturers
FROM CourseAllocation
GROUP BY course_id
HAVING COUNT(*) > 1;
