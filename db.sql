-- Student Performance Tracking System

-- 1. Teachers Table
CREATE TABLE Teachers (
    teacher_id INT PRIMARY KEY AUTO_INCREMENT,
    first_name VARCHAR(50) NOT NULL,
    last_name VARCHAR(50) NOT NULL,
    email VARCHAR(100) UNIQUE NOT NULL,
    phone_number VARCHAR(15) NOT NULL
);

-- 2. Classes Table
CREATE TABLE Classes (
    class_id INT PRIMARY KEY AUTO_INCREMENT,
    class_name VARCHAR(50) NOT NULL,
    teacher_id INT NOT NULL,
    academic_year VARCHAR(20) NOT NULL,
    FOREIGN KEY (teacher_id) REFERENCES Teachers(teacher_id)
);

-- 3. Subjects Table
CREATE TABLE Subjects (
    subject_id INT PRIMARY KEY AUTO_INCREMENT,
    subject_name VARCHAR(100) NOT NULL,
    class_id INT NOT NULL,
    FOREIGN KEY (class_id) REFERENCES Classes(class_id)
);

-- 4. Students Table
CREATE TABLE Students (
    student_id INT PRIMARY KEY AUTO_INCREMENT,
    first_name VARCHAR(50) NOT NULL,
    last_name VARCHAR(50) NOT NULL,
    email VARCHAR(100) UNIQUE NOT NULL,
    gender VARCHAR(10) NOT NULL,
    date_of_birth DATE NOT NULL,
    class_id INT NOT NULL,
    registration_date DATE NOT NULL,
    FOREIGN KEY (class_id) REFERENCES Classes(class_id)
);

-- 5. Exams Table
CREATE TABLE Exams (
    exam_id INT PRIMARY KEY AUTO_INCREMENT,
    subject_id INT NOT NULL,
    exam_title VARCHAR(100) NOT NULL,
    total_marks INT NOT NULL,
    exam_date DATE NOT NULL,
    term VARCHAR(20) NOT NULL,
    academic_year VARCHAR(20) NOT NULL,
    FOREIGN KEY (subject_id) REFERENCES Subjects(subject_id)
);

-- 6. Grades Table
CREATE TABLE Grades (
    grade_id INT PRIMARY KEY AUTO_INCREMENT,
    student_id INT NOT NULL,
    exam_id INT NOT NULL,
    marks_obtained INT NOT NULL,
    grade CHAR(2) NOT NULL,
    remarks TEXT,
    FOREIGN KEY (student_id) REFERENCES Students(student_id),
    FOREIGN KEY (exam_id) REFERENCES Exams(exam_id)
);

-- 7. Attendance Table
CREATE TABLE Attendance (
    attendance_id INT PRIMARY KEY AUTO_INCREMENT,
    student_id INT NOT NULL,
    date DATE NOT NULL,
    status ENUM('Present', 'Absent', 'Late') NOT NULL,
    reason TEXT,
    FOREIGN KEY (student_id) REFERENCES Students(student_id)
);

-- 8. Teacher Feedback Table
CREATE TABLE Teacher_Feedback (
    feedback_id INT PRIMARY KEY AUTO_INCREMENT,
    student_id INT NOT NULL,
    teacher_id INT NOT NULL,
    date DATE NOT NULL,
    remarks TEXT,
    FOREIGN KEY (student_id) REFERENCES Students(student_id),
    FOREIGN KEY (teacher_id) REFERENCES Teachers(teacher_id)
);

-- 9. Parents Table
CREATE TABLE Parents (
    parent_id INT PRIMARY KEY AUTO_INCREMENT,
    student_id INT NOT NULL,
    name VARCHAR(100) NOT NULL,
    phone VARCHAR(15) NOT NULL,
    email VARCHAR(100) NOT NULL,
    relationship VARCHAR(50) NOT NULL,
    FOREIGN KEY (student_id) REFERENCES Students(student_id)
);

-- 10. Roles Table
CREATE TABLE Roles (
    role_id INT PRIMARY KEY AUTO_INCREMENT,
    role_name VARCHAR(50) UNIQUE NOT NULL
);

-- Insert sample roles
INSERT INTO Roles (role_name) VALUES ('Admin'), ('Teacher'), ('Parent'), ('Student');

-- 11. User Accounts Table
CREATE TABLE User_Accounts (
    user_id INT PRIMARY KEY AUTO_INCREMENT,
    username VARCHAR(50) UNIQUE NOT NULL,
    password_hash VARCHAR(255) NOT NULL,
    role_id INT NOT NULL,
    linked_id INT NOT NULL,
    FOREIGN KEY (role_id) REFERENCES Roles(role_id)
    -- NOTE: linked_id refers to student_id, teacher_id, or parent_id depending on the role
);

-- 12. Permissions Table
CREATE TABLE Permissions (
    permission_id INT PRIMARY KEY AUTO_INCREMENT,
    role_id INT NOT NULL,
    permission_name VARCHAR(100) NOT NULL,
    FOREIGN KEY (role_id) REFERENCES Roles(role_id)
);

-- Insert sample permissions
INSERT INTO Permissions (role_id, permission_name) VALUES
(1, 'manage_users'),
(1, 'view_all_students'),
(1, 'edit_students'),
(1, 'view_grades'),
(1, 'add_grades'),

(2, 'view_grades'),
(2, 'add_grades'),
(2, 'view_attendance'),
(2, 'add_attendance'),
(2, 'view_feedback'),
(2, 'add_feedback'),

(3, 'view_own_child_grades'),
(3, 'view_own_child_attendance'),
(3, 'view_own_child_feedback'),

(4, 'view_own_grades'),
(4, 'view_own_attendance'),
(4, 'view_own_feedback');
