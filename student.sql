-- Active: 1729773559427@@127.0.0.1@5432@university_db

-- create student table
 CREATE TABLE students (
    student_id SERIAL PRIMARY KEY,
    student_name VARCHAR(50),
    age INTEGER,
    email VARCHAR(100),
    frontend_marks INTEGER,
    backend_marks INTEGER,
    status VARCHAR(50)
 );

--  create course
CREATE TABLE courses (
    course_id SERIAL PRIMARY KEY,
    course_name VARCHAR(255),
    credits INTEGER
);

-- create enrollment table
-- CREATE TABLE enrollments (
--     enrollment_id SERIAL PRIMARY KEY,
--     student_id INTEGER REFERENCES students(student_id),
-- )

CREATE TABLE enrollments (
   enrollment_id SERIAL PRIMARY KEY,
   student_id INTEGER REFERENCES students(student_id),
   course_id INTEGER REFERENCES courses(course_id)
);

-- Insert sample data into "students" table
INSERT INTO students (student_id,student_name, age, email, frontend_mark, backend_mark, status)
VALUES 
(1, 'Sameer', 21, 'sameer@example.com', 48, 60, NULL),
(2, 'Zoya', 23, 'zoya@example.com', 52, 58, NULL),
(3, 'Nabil', 22, 'nabil@example.com', 37, 46, NULL),
(4, 'Rafi', 24, 'rafi@example.com', 41, 40, NULL),
(5, 'Sophia', 22, 'sophia@example.com', 50, 52, NULL),
(6, 'Hasan', 23, 'hasan@gmail.com', 43, 39, NULL);



-- Insert sample data into "courses" table
INSERT INTO courses ( course_id,course_name,credits)
VALUES
(1, 'Next.js', 3),
(2, 'React.js', 4),
(3, 'Databases', 3),
(4, 'Prisma', 3);


-- Insert sample data into "enrollment" table
INSERT INTO enrollment (student_id, course_id)
VALUES 
(1, 1),
(1, 2),
(2, 1),
(3, 2);

-- Insert a new student record
INSERT INTO students (student_id,student_name, age, email, frontend_mark, backend_mark, status)
VALUES (7,'sam', 20, 'sam@gmail.com', 12, 13, NULL);

-- Retrieve the names of students enrolled in 'Next.js'
SELECT student_name
FROM students
INNER JOIN enrollment ON students.student_id = enrollment.student_id
INNER JOIN courses ON courses.course_id = enrollment.course_id
WHERE courses.course_name = 'Next.js';

-- Update the status of the student with the highest total mark
UPDATE students
SET status = 'Awarded'
WHERE(frontend_mark + backend_mark) = (
    SELECT max(frontend_mark + backend_mark)
    FROM students
)


-- Delete the course with the highest number of enrollments
DELETE FROM courses
WHERE course_id NOT IN (
    SELECT DISTINCT course_id FROM enrollment
);

-- Retrieve names of students with LIMIT and OFFSET

SELECT student_name
FROM students
ORDER BY age ASC
LIMIT 3 OFFSET 2;

-- Retrieve course names and the number of students enrolled
SELECT course_name, COUNT(enrollment.student_id) AS students_enrolled
FROM courses
LEFT JOIN enrollment ON courses.course_id = enrollment.course_id
GROUP BY course_name;

-- Calculate and display the average age of students
SELECT AVG(age) AS average_age
FROM students;

-- Retrieve names of students with 'example.com' in their email

SELECT student_name 
FROM students 
WHERE email LIKE '%example.com%';