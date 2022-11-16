CREATE DATABASE school;

USE school;

CREATE TABLE
    students (
        Id INT NOT NULL AUTO_INCREMENT PRIMARY KEY,
        FirstName VARCHAR(28),
        LastName VARCHAR(28),
        Number SMALLINT,
        Class VARCHAR(3),
        SSN VARCHAR(10),
        Birthday DATE,
        EntranceExam NUMERIC(3, 2)
    );

CREATE TABLE
    subjects (
        Id INT NOT NULL AUTO_INCREMENT PRIMARY KEY,
        Name VARCHAR(28)
    );

CREATE TABLE
    marks (
        Id INT NOT NULL AUTO_INCREMENT PRIMARY KEY,
        Mark NUMERIC(3, 2),
        Created DATE,
        StudentId INTEGER NOT NULL,
        SubjectId INTEGER NOT NULL,
        FOREIGN KEY (StudentId) REFERENCES students (Id),
        FOREIGN KEY (SubjectId) REFERENCES subjects (Id)
    );

CREATE TABLE
    word_marks (
        Id INT NOT NULL AUTO_INCREMENT PRIMARY KEY,
        Start NUMERIC(3, 2),
        End NUMERIC(3, 2),
        Word VARCHAR(18)
    );


-- inserts

INSERT INTO word_marks
VALUES (NULL, 2.00, 2.50, 'Слаб'),
       (NULL, 2.50, 3.50, 'Среден'),
       (NULL, 3.50, 4.50, 'Добър'),
       (NULL, 4.50, 5.50, 'Мн. Добър'),
       (NULL, 5.50, 6.00, 'Отличен');

INSERT INTO students
VALUES (NULL, 'Алеко', 'Георгиев', 1, '11А', '0000000000', NULL, 5.50),
       (NULL, 'Александра', 'Стойчева', 2, '11А', '1000000000', NULL, 5.00),
       (NULL, 'Александър', 'Иванов', 3, '11А', '2000000000', NULL, 3.50);


INSERT INTO subjects
VALUES (NULL, 'Математика'),
       (NULL, 'АЕ'),
       (NULL, 'БЕЛ'),
       (NULL, 'БД');


INSERT INTO marks
VALUES (NULL, 6.00, '2022-11-16', 1, 1),
       (NULL, 5.00, '2022-11-10', 2, 2),
       (NULL, 2.00, '2022-11-16', 1, 3),
       (NULL, 3.6, '2022-11-16', 3, 4);

-- Направете заявка за всички оценки над 3.50 със следните колони:
-- Име на ученика, номер в класа, клас, предмет по който е оценката, оценката с думи, оценката с цифри
SELECT
    s.FirstName,
    s.Number,
    s.Class,
    su.Name,
    wm.Word,
    m.Mark
FROM
    students s
    JOIN marks m ON s.Id = m.StudentId
    JOIN subjects su ON m.SubjectId = su.Id
    JOIN word_marks wm ON m.Mark BETWEEN wm.Start AND wm.End
WHERE
    m.Mark > 3.50;

-- аправете заявка за всички ученици, които нямат оценки по предмета БД със следните колони:
-- Име на ученика, номер в класа, клас
SELECT DISTINCT
    s.FirstName,
    s.Number,
    s.Class
FROM
    students s
    LEFT JOIN marks m ON s.Id = m.StudentId
    LEFT JOIN subjects su ON m.SubjectId = su.Id
WHERE
    su.Name NOT LIKE 'БД';