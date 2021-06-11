-- hypothetical tables and code to illustrate techincal prowess

CREATE DATABASE school;
USE school;

CREATE TABLE classes(
id INT AUTO_INCREMENT PRIMARY KEY,
teacher VARCHAR(50),
subject VARCHAR(50),
class_size INT);

CREATE TABLE students(
id INT AUTO_INCREMENT PRIMARY KEY,
first_name VARCHAR(50),
last_name VARCHAR(50),
grade DECIMAL(3,1),
age INT,
classes_id INT,
FOREIGN KEY (classes_id) REFERENCES classes(id));

INSERT INTO classes(teacher, subject, class_size) VALUES ('Ken','Math', 23), ('Matt','Physics', 12), ('Karla','ELA', 21), ('Danny','Social', 19), ('Moe','Chemistry', 12);

INSERT INTO students(first_name,last_name,grade,age,classes_id) VALUES ('Michael', 'West',87.1, 16, 3), ('Paul', 'Lennon',  90.2,17, 4), ('Cindy', 'Moore', 65.3,16 , 5), ('Mike', 'West',54.2,19, 2), ('Jim', 'Free', 43.3,18, 1), ('Michael', 'West',83.2, 16, 1), ('Mike', 'West',57.2,19, 4),('Cindy', 'Moore', 63.2,16 , 3), ('Paul', 'Lennon',  96.3,17, 2) ;
    
SELECT * FROM students;
SELECT * FROM classes;

SELECT first_name, last_name, grade, subject FROM classes
JOIN students ON classes.id = students.classes_id;

SELECT teacher, AVG(grade), subject FROM classes
JOIN students ON classes.id = students.classes_id
GROUP BY subject
ORDER BY AVG(grade) DESC;

SELECT teacher, first_name, last_name, grade, subject,
CASE
WHEN grade >= 90 THEN 'EXCELLENT'
WHEN grade <= 89.9 AND grade >= 70.0 THEN 'SUPERIOR'
WHEN grade <= 69.9 AND grade >= 50.0 THEN 'AVERAGE'
ELSE 'FAILED'
END AS 'lEVELS'
FROM classes
JOIN students ON classes.id = students.classes_id
ORDER BY grade DESC;

SELECT first_name, last_name, AVG(grade), count(subject) AS 'total_classes' FROM classes
JOIN students ON classes.id = students.classes_id
GROUP BY subject
ORDER BY AVG(grade) DESC;


