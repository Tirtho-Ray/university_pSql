-- Active: 1730349381062@@127.0.0.1@5432@university_db


-- Create the "students" table
CREATE TABLE students (
    student_id SERIAL PRIMARY KEY,
    student_name VARCHAR(50),
    age INTEGER,
    email VARCHAR(100),
    frontend_mark INTEGER,
    backend_mark INTEGER,
    status VARCHAR(50)
);

-- Create the "courses" table
CREATE TABLE courses (
    course_id SERIAL PRIMARY KEY,
    course_name VARCHAR(255),
    credits INTEGER
);

-- Create the "enrollment" table
CREATE TABLE enrollment (
    enrollment_id SERIAL PRIMARY KEY,
    student_id INTEGER REFERENCES students(student_id),
    course_id INTEGER REFERENCES courses(course_id)
);



-- Insert sample data into the "students" table
INSERT INTO students (student_name, age, email, frontend_mark, backend_mark, status)
VALUES 
('Sameer', 21, 'sameer@example.com', 48, 60, NULL),
('Zoya', 23, 'zoya@example.com', 52, 58, NULL),
('Nabil', 22, 'nabil@example.com', 37, 46, NULL),
('Rafi', 24, 'rafi@example.com', 41, 40, NULL),
('Sophia', 22, 'sophia@example.com', 50, 52, NULL),
('Hasan', 23, 'hasan@gmail.com', 43, 39, NULL);

-- SELECT * FROM students

-- Insert sample data into the "courses" table
INSERT INTO courses (course_name, credits)
VALUES
('Next.js', 3),
('React.js', 4),
('Databases', 3),
('Prisma', 3);

-- SELECT * FROM courses

-- Insert sample data into the "enrollment" table
INSERT INTO enrollment (student_id, course_id)
VALUES 
(1, 1),
(1, 2),
(2, 1),
(3, 2);

-- SELECT * FROM enrollment


-- Insert a new student record
INSERT INTO students (student_name, age, email, frontend_mark, backend_mark, status)
VALUES ('YourName', YourAge, 'YourEmail', YourFrontendMark, YourBackendMark, NULL);

-- SELECT * FROM students

--Retrieve the names of all students enrolled in the course titled 'Next.js'
SELECT student_name
FROM students
INNER JOIN enrollment ON students.student_id = enrollment.student_id
INNER JOIN courses ON courses.course_id = enrollment.course_id
WHERE courses.course_name = 'Next.js';

--Update the status of the student with the highest total (frontend_mark + backend_mark) to 'Awarded'
UPDATE students
SET status = 'Awarded'
WHERE (frontend_mark + backend_mark) = (
    SELECT MAX(frontend_mark + backend_mark) FROM students
);

-- SELECT  * FROM students WHERE status = 'Awarded'

--Delete all courses that have no students enrolled
DELETE FROM courses
WHERE course_id NOT IN (
    SELECT DISTINCT course_id FROM enrollment
);

-- SELECT * FROM courses 

--  Retrieve the names of students using a limit of 2, starting from the 3rd student
SELECT student_name
FROM students
ORDER BY student_id
LIMIT 2 OFFSET 2;

-- Retrieve the course names and the number of students enrolled in each course
SELECT course_name, COUNT(enrollment.student_id) AS students_enrolled
FROM courses
LEFT JOIN enrollment ON courses.course_id = enrollment.course_id
GROUP BY course_name;

-- Calculate and display the average age of all students
SELECT AVG(age) AS average_age
FROM students;

-- Retrieve the names of students whose email addresses contain 'example.com'
SELECT student_name 
FROM students 
WHERE email LIKE '%example.com%';
