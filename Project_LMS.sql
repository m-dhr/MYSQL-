CREATE DATABASE lms_db;
USE lms_db;

CREATE TABLE Students (
    student_id INT PRIMARY KEY,
    student_name VARCHAR(50),
    email VARCHAR(50),
    phone VARCHAR(15),
    city VARCHAR(50)
);

CREATE TABLE Mentors (
    mentor_id INT PRIMARY KEY,
    mentor_name VARCHAR(50),
    expertise VARCHAR(50)
);

CREATE TABLE Courses (
    course_id INT PRIMARY KEY,
    mentor_id INT,
    course_name VARCHAR(50),
    category VARCHAR(50),
    duration INT,
    FOREIGN KEY(mentor_id) REFERENCES Mentors(mentor_id)
);

CREATE TABLE Enrollment (
    enrollment_id INT PRIMARY KEY,
    student_id INT,
    course_id INT,
    enroll_date DATE,
    status VARCHAR(20),
    FOREIGN KEY (student_id) REFERENCES Students(student_id),
    FOREIGN KEY (course_id) REFERENCES Courses(course_id)
);

CREATE TABLE Assessments (
    assessment_id INT PRIMARY KEY,
    student_id INT,
    course_id INT,
    assessment_name VARCHAR(50),
    score DECIMAL(5,2),
    assessment_date DATE,
    FOREIGN KEY (student_id) REFERENCES Students(student_id),
    FOREIGN KEY (course_id) REFERENCES Courses(course_id)
);

INSERT INTO Students VALUES
(101,'Aarav Sharma', 'aarav@gmail.com','9876500001','Hyderabad'),
(102,'Bhavya Reddy', 'bhavya@gmail.com','9876500002','Vijayawada'),
(103,'Charan Kumar', 'charan@gmail.com','9876500003','Visakhapatnam'),
(104,'Divya Patel', 'divya@gmail.com','9876500004','Bengaluru'),
(105,'Esha Gupta', 'esha@gmail.com','9876500005','Chennai'),
(106,'Farhan Ali', 'farhan@gmail.com','9876500006','Mumbai'),
(107,'Gopi Krishna', 'gopi@gmail.com','9876500007','Warangal'),
(108,'Harini Rao', 'harini@gmail.com','9876500008','Guntur'),
(109,'Ishaan Verma', 'ishaan@gmail.com','9876500009','Pune'),
(110,'John Mathew', 'john@gmail.com','9876500010','Kochi');

INSERT INTO Mentors VALUES
(201,'Dr. Santhosh Kumar', 'Machine Learning'),
(202,'Priya Nair', 'Data Analytics'),
(203,'Rahul Mehta', 'Web Development'),
(204,'Sneha Reddy', 'Cloud Computing'),
(205,'Arjun Singh', 'Cyber Security');

INSERT INTO Courses VALUES
(301,201,'Machine Learning','AI',60),
(302,202,'Data Analytics','Analytics',45),
(303,203,'Python Full Stack', 'Web Development',75),
(304,204,'AWS Cloud','Cloud',40),
(305,205,'Cyber Security Basics','Security',35),
(306,202,'Power BI', 'Business Intelligence',30);

INSERT INTO Enrollment VALUES
(501,101,301,'2026-07-01','Active'),
(502,102,302,'2026-07-02','Completed'),
(503,103,303,'2026-07-03','Active'),
(504,104,304,'2026-07-04','Completed'),
(505,105,305,'2026-07-05','Active'),
(506,106,306,'2026-07-06','Completed'),
(507,107,301,'2026-07-07','Active'),
(508,108,302,'2026-07-08','Completed'),
(509,109,303,'2026-07-09','Dropped'),
(510,110,304,'2026-07-10','Active'),
(511,101,306,'2026-07-11','Completed'),
(512,103,305,'2026-07-12','Active');

INSERT INTO Assessments VALUES
(601,101,301,'Quiz 1',85.50,'2026-07-05'),
(602,101,301,'Final Assessment',91.00,'2026-07-15'),
(603,102,302,'Assignment 1',78.00,'2026-07-06'),
(604,102,302,'Final Assessment',88.50,'2026-07-16'),
(605,103,303,'Quiz 1',81.00,'2026-07-07'),
(606,103,303,'Project Evaluation',75.50,'2026-07-17'),
(607,104,304,'Quiz 1',92.00,'2026-07-08'),
(608,104,304,'Final Assessment',89.00,'2026-07-18'),
(609,105,305,'Assignment 1',84.00,'2026-07-09'),
(610,106,306,'Quiz 1',91.50,'2026-07-10'),
(611,107,301,'Assignment 1',80.00,'2026-07-11'),
(612,108,302,'Quiz 2',87.00,'2026-07-12'),
(613,109,303,'Final Assessment',83.50,'2026-07-13'),
(614,110,304,'Project Evaluation',86.00,'2026-07-14'),
(615,101,306,'Dashboard Project',95.00,'2026-07-20');

SELECT * FROM Students;
SELECT * FROM Mentors;
SELECT * FROM Courses;
SELECT * FROM Enrollment;
SELECT * FROM Assessments;

#SQL Practice Questions  

#List all students. 
SELECT * FROM Students;

#Delete an inactive enrollment. 
DELETE FROM Enrollment WHERE status = 'Dropped';

#Update the enrollment status of a student from 'Active' to 'Completed'.
UPDATE Enrollment SET status = 'Completed' WHERE student_id = 101 AND course_id = 301 AND status = 'Active';

#Display all mentor names in uppercase and course names in lowercase. 
SELECT UPPER(m.mentor_name) AS mentor_name_upper, LOWER(c.course_name) AS course_name_lower FROM Mentors m JOIN Courses c ON m.mentor_id = c.mentor_id;

#Show first 5 characters of course names.
SELECT course_name, SUBSTRING(course_name, 1, 5) AS short_name FROM Courses;
 
#Concatenate student name and city. 
SELECT CONCAT(student_name, ' (', city, ')') AS student_city FROM Students;

#Display the last four digits of each student's phone number 
SELECT student_name, RIGHT(phone, 4) AS last_four_digits FROM Students;

#Replace 'Python' with 'Advanced Python' in output. 
SELECT course_id, REPLACE(course_name, 'Python', 'Advanced Python') AS modified_course_name FROM Courses;

#Find courses containing 'Data'.
SELECT * 
FROM Courses 
WHERE course_name LIKE '%Data%';
 
#Display today's assessments. 
SELECT * FROM Assessments WHERE assessment_date = CURDATE();

#Find the number of days since each student enrolled. 
SELECT e.enrollment_id, s.student_name, e.enroll_date, DATEDIFF(CURDATE(), e.enroll_date) AS days_since_enrolled FROM Enrollment e JOIN Students s ON e.student_id = s.student_id;

#Display the assessment date in the format DD-Mon-YYYY. 
SELECT assessment_id, assessment_name, DATE_FORMAT(assessment_date, '%d-%b-%Y') AS formatted_assessment_date FROM Assessments;

#Show all enrollments made in July 2026.
SELECT * FROM Enrollment WHERE enroll_date BETWEEN '2026-07-01' AND '2026-07-31';

#Count the number of students enrolled in each course. 
SELECT c.course_id, c.course_name, COUNT(e.student_id) AS total_enrolled FROM Courses c 
LEFT JOIN Enrollment e ON c.course_id=e.course_id GROUP BY c.course_id, c.course_name;

#Display the average assessment score for each course. 
SELECT * 
FROM Assessments 
WHERE assessment_date = CURDATE();

#Find the highest and lowest assessment score. 
SELECT MAX(score) AS highest_score, MIN(score) AS lowest_score FROM Assessments;

#Display courses having more than 5 students. 
SELECT c.course_id, c.course_name, COUNT(e.student_id) AS student_count FROM Courses c 
JOIN Enrollment e ON c.course_id = e.course_id GROUP BY c.course_id, c.course_name HAVING COUNT(e.student_id) > 5;

#Display student names along with their enrolled course names. 
SELECT s.student_name, c.course_name FROM Students s JOIN Enrollment e 
ON s.student_id = e.student_id JOIN Courses c ON e.course_id = c.course_id;

#Display course names with their mentor names. 
SELECT c.course_name, m.mentor_name FROM Courses c JOIN Mentors m ON c.mentor_id = m.mentor_id;

#Display student names, course names, and enrollment status. 
SELECT s.student_name, c.course_name, e.status AS enrollment_status FROM Students s 
JOIN Enrollment e ON s.student_id = e.student_id JOIN Courses c ON e.course_id = c.course_id;

#Display assessment details along with student and course names. 
SELECT a.assessment_id, s.student_name, c.course_name, a.assessment_name, a.score, a.assessment_date FROM Assessments a 
JOIN Students s ON a.student_id = s.student_id JOIN Courses c ON a.course_id = c.course_id;

#Display mentor names along with the courses they teach. 
SELECT m.mentor_name, c.course_name FROM Mentors m LEFT JOIN Courses c ON m.mentor_id = c.mentor_id;

#Students without enrollments. 
SELECT s.student_id, s.student_name, s.email FROM Students s 
LEFT JOIN Enrollment e ON s.student_id = e.student_id WHERE e.enrollment_id IS NULL;

#Courses without modules
SELECT c.course_id, c.course_name FROM Courses c LEFT JOIN Modules m ON c.course_id = m.course_id WHERE m.module_id IS NULL;

#Modules not yet completed. 
SELECT * FROM Modules WHERE status != 'Completed';

#Find students who scored higher than the average assessment score. 
SELECT DISTINCT s.student_id, s.student_name, a.score FROM Students s JOIN Assessments a ON s.student_id = a.student_id
WHERE a.score > (SELECT AVG(score) FROM Assessments);

#Display the course having the maximum duration. 
SELECT * FROM Courses 
WHERE duration = (SELECT MAX(duration) FROM Courses);

#Correlated subquery for top scorer per course. 
SELECT 
    a1.course_id,
    c.course_name,
    a1.student_id,
    s.student_name,
    a1.score
FROM Assessments a1
JOIN Courses c ON a1.course_id = c.course_id
JOIN Students s ON a1.student_id = s.student_id
WHERE a1.score = (
    SELECT MAX(a2.score)
    FROM Assessments a2
    WHERE a2.course_id = a1.course_id
);

#Create a view to display student names, course names, and enrollment status. 
CREATE OR REPLACE VIEW View_Student_Enrollment AS
SELECT 
    s.student_name,
    c.course_name,
    e.status AS enrollment_status
FROM Students s
JOIN Enrollment e ON s.student_id = e.student_id
JOIN Courses c ON e.course_id = c.course_id;

#Create a view to display assessment results with student and course details. 
CREATE OR REPLACE VIEW View_Assessment_Results AS
SELECT 
    a.assessment_id,
    s.student_name,
    c.course_name,
    a.assessment_name,
    a.score,
    a.assessment_date
FROM Assessments a
JOIN Students s ON a.student_id = s.student_id
JOIN Courses c ON a.course_id = c.course_id;

#Retrieve all records from both created views. 
SELECT * FROM View_Student_Enrollment;
SELECT * FROM View_Assessment_Results;

#Start a transaction and update the enrollment status of a student.  
START TRANSACTION;
UPDATE Enrollment 
SET status = 'Completed' 
WHERE student_id = 101 AND course_id = 301;

#Create a SAVEPOINT after updating assessment scores.  
UPDATE Assessments 
SET score = score + 2.00 
WHERE assessment_id = 601;

SAVEPOINT sp_assessment_updated;

#Roll back to the SAVEPOINT.  
ROLLBACK TO SAVEPOINT sp_assessment_updated;

#Commit the transaction.  
COMMIT;

#Delete an assessment record and roll back the transaction.
START TRANSACTION;

DELETE FROM Assessments 
WHERE assessment_id = 615;

ROLLBACK;

 
#Create a stored procedure to display all courses belonging to a particular category. Input: category  
DELIMITER //
CREATE PROCEDURE GetCoursesByCategory(IN p_category VARCHAR(50))
BEGIN
    SELECT 
        course_id,
        course_name,
        category,
        duration,
        mentor_id
    FROM Courses
    WHERE category = p_category;
END //
DELIMITER ;

#Create a stored procedure to find the average assessment score of a particular student. Input: student_id 
DELIMITER //

CREATE PROCEDURE GetStudentAverageScore(IN p_student_id INT)
BEGIN
    SELECT 
        s.student_id,
        s.student_name,
        ROUND(AVG(a.score), 2) AS average_score
    FROM Students s
    JOIN Assessments a ON s.student_id = a.student_id
    WHERE s.student_id = p_student_id
    GROUP BY s.student_id, s.student_name;
END //

DELIMITER ;

#Create a trigger on Assessments to store newly added assessment details in an Assessment_Log table.  
CREATE TABLE IF NOT EXISTS Assessment_Log (
    log_id INT AUTO_INCREMENT PRIMARY KEY,
    assessment_id INT,
    student_id INT,
    course_id INT,
    assessment_name VARCHAR(100),
    score DECIMAL(5,2),
    assessment_date DATE,
    action_type VARCHAR(20) DEFAULT 'INSERT',
    logged_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP
);

DELIMITER //

CREATE TRIGGER trg_after_assessment_insert
AFTER INSERT ON Assessments
FOR EACH ROW
BEGIN
    INSERT INTO Assessment_Log (
        assessment_id,
        student_id,
        course_id,
        assessment_name,
        score,
        assessment_date,
        action_type
    )
    VALUES (
        NEW.assessment_id,
        NEW.student_id,
        NEW.course_id,
        NEW.assessment_name,
        NEW.score,
        NEW.assessment_date,
        'INSERT'
    );
END //

DELIMITER ;

#Create an AFTER UPDATE trigger on Enrollment to store the old and new enrollment status in an Enrollment_Status_History table. 
CREATE TABLE IF NOT EXISTS Enrollment_Status_History (
    history_id INT AUTO_INCREMENT PRIMARY KEY,
    enrollment_id INT,
    student_id INT,
    course_id INT,
    old_status VARCHAR(20),
    new_status VARCHAR(20),
    changed_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP
);

DELIMITER //

CREATE TRIGGER trg_after_enrollment_status_update
AFTER UPDATE ON Enrollment
FOR EACH ROW
BEGIN
    IF OLD.status <> NEW.status THEN
        INSERT INTO Enrollment_Status_History (
            enrollment_id,
            student_id,
            course_id,
            old_status,
            new_status
        )
        VALUES (
            OLD.enrollment_id,
            OLD.student_id,
            OLD.course_id,
            OLD.status,
            NEW.status
        );
    END IF;
END //

DELIMITER ;
