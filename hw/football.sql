-- PlayerStats by Kaloyan Doychinov
-- MySQL
-- 1. Създайте база данни "PlayerStats" за статистики на футболисти от един отбор.
DROP DATABASE IF EXISTS PlayerStats;

CREATE DATABASE PlayerStats;

USE PlayerStats;

-- 2. Създайте таблица "StatTypes" за следените статистики със следната структура и данни:
CREATE TABLE
    StatTypes (
        StatCode VARCHAR(3) NOT NULL PRIMARY KEY,
        StatName VARCHAR(20) NOT NULL
    );

INSERT INTO
    StatTypes (StatCode, StatName)
VALUES
    ('G', 'Гол'),
    ('A', 'Асистенция'),
    ('R', 'Червен картон'),
    ('Y', 'Жълт картон'),
    ('OG', 'Автогол'),
    ('IN', 'Смяна влиза'),
    ('OUT', 'Смяна излиза');

-- 3. Създайте таблица "Positions" с позициите на играчите със следната структура и данни:
/*

GK Вратар
RB Десен защитник
LB Ляв защитник
CB Централен защитник
RM Десен полузащитник
LM Ляв полузащитник
CM Полузащитник
CF Централен нападател

 */
CREATE TABLE
    Positions (
        PositionCode VARCHAR(2) NOT NULL PRIMARY KEY,
        PositionName VARCHAR(20) NOT NULL
    );

INSERT INTO
    Positions (PositionCode, PositionName)
VALUES
    ('GK', 'Вратар'),
    ('RB', 'Десен защитник'),
    ('LB', 'Ляв защитник'),
    ('CB', 'Централен защитник'),
    ('RM', 'Десен полузащитник'),
    ('LM', 'Ляв полузащитник'),
    ('CM', 'Полузащитник'),
    ('CF', 'Централен нападател');

/* 4. Създайте таблица "Players" с играчите в отбора със следната структура и данни, включително връзки към други таблици:
Id Name Num PositionCode
1 Ivaylo Trifonov 1 GK
2 Valko Trifonov 2 RB
3 Ognyan Yanev 3 CB
4 Zahari Dragomirov 4 CB
5 Bozhidar Chilikov 5 LB
6 Timotei Zahariev 6 CM
7 Marin Valentinov 7 CM
8 Mitre Cvetkov 99 CF
9 Zlatko Genov 9 CF
10 Matey Goranov 10 RM
11 Sergei Zhivkov 11 LM
 */
CREATE TABLE
    Players (
        Id INT NOT NULL PRIMARY KEY AUTO_INCREMENT,
        Name VARCHAR(50) NOT NULL,
        Num INT NOT NULL,
        PositionCode VARCHAR(2) NOT NULL,
        FOREIGN KEY (PositionCode) REFERENCES Positions (PositionCode)
    );

INSERT INTO
    Players (Name, Num, PositionCode)
VALUES
    ('Ivaylo Trifonov', 1, 'GK'),
    ('Valko Trifonov', 2, 'RB'),
    ('Ognyan Yanev', 3, 'CB'),
    ('Zahari Dragomirov', 4, 'CB'),
    ('Bozhidar Chilikov', 5, 'LB'),
    ('Timotei Zahariev', 6, 'CM'),
    ('Marin Valentinov', 7, 'CM'),
    ('Mitre Cvetkov', 99, 'CF'),
    ('Zlatko Genov', 9, 'CF'),
    ('Matey Goranov', 10, 'RM'),
    ('Sergei Zhivkov', 11, 'LM');

/* 5. Създайте таблица "Tournaments" с турнири, в които участва отбора, със следната структура и данни:
Id Name
1 Шампионска лига
2 Първа лига
3 Купа на България
4 Суперкупа на България
 */
CREATE TABLE
    Tournaments (
        Id INT NOT NULL PRIMARY KEY AUTO_INCREMENT,
        Name VARCHAR(50) NOT NULL
    );

INSERT INTO
    Tournaments (Name)
VALUES
    ('Шампионска лига'),
    ('Първа лига'),
    ('Купа на България'),
    ('Суперкупа на България');

/* 6. Създайте таблица "Matches" с планираните и изиграни мачове на отбора със следната структура и данни, включително връзки към други таблици:
Id MatchDate TournamentId
1 2018-04-08 2
2 2018-04-13 2
3 2018-04-21 2
4 2018-04-28 2
5 2018-05-06 2
6 2018-05-11 2
7 2017-09-21 3
8 2017-10-26 3
 */
CREATE TABLE
    Matches (
        Id INT NOT NULL PRIMARY KEY AUTO_INCREMENT,
        MatchDate DATE NOT NULL,
        TournamentId INT NOT NULL,
        FOREIGN KEY (TournamentId) REFERENCES Tournaments (Id)
    );

INSERT INTO
    Matches (MatchDate, TournamentId)
VALUES
    ('2018-04-08', 2),
    ('2018-04-13', 2),
    ('2018-04-21', 2),
    ('2018-04-28', 2),
    ('2018-05-06', 2),
    ('2018-05-11', 2),
    ('2017-09-21', 3),
    ('2017-10-26', 3);

/* 7. Създайте таблица "MatchStats" с настъпилите събития в мача със следната структура и данни, включително връзки към други таблици:
Id MatchId PlayerId EventMinute StatCode
1 8 9 14 G
2 8 8 14 A
3 8 3 43 Y
4 7 2 28 Y
5 7 10 45 Y
6 7 10 65 R
7 1 10 23 G
8 1 9 23 A
9 1 9 43 G
10 2 4 33 OG
11 2 9 68 G
12 2 1 68 A
13 3 3 35 G
14 3 4 35 A
15 3 8 55 G
16 3 11 55 A
17 4 3 9 G
18 4 8 9 G
19 4 8 56 OG
20 5 8 67 G
 */
CREATE TABLE
    MatchStats (
        Id INT NOT NULL PRIMARY KEY AUTO_INCREMENT,
        MatchId INT NOT NULL,
        PlayerId INT NOT NULL,
        EventMinute INT NOT NULL,
        StatCode VARCHAR(3) NOT NULL,
        FOREIGN KEY (MatchId) REFERENCES Matches (Id),
        FOREIGN KEY (PlayerId) REFERENCES Players (Id),
        FOREIGN KEY (StatCode) REFERENCES StatTypes (StatCode)
    );

INSERT INTO
    MatchStats (MatchId, PlayerId, EventMinute, StatCode)
VALUES
    (8, 9, 14, 'G'),
    (8, 8, 14, 'A'),
    (8, 3, 43, 'Y'),
    (7, 2, 28, 'Y'),
    (7, 10, 45, 'Y'),
    (7, 10, 65, 'R'),
    (1, 10, 23, 'G'),
    (1, 9, 23, 'A'),
    (1, 9, 43, 'G'),
    (2, 4, 33, 'OG'),
    (2, 9, 68, 'G'),
    (2, 1, 68, 'A'),
    (3, 3, 35, 'G'),
    (3, 4, 35, 'A'),
    (3, 8, 55, 'G'),
    (3, 11, 55, 'A'),
    (4, 3, 9, 'G'),
    (4, 8, 9, 'G'),
    (4, 8, 56, 'OG'),
    (5, 8, 67, 'G');

-- Заявки 
-- 8. Направете заявка за името и номера на фланелката на всички защитници от отбора (независимо дали са десни, леви или централни защитници).
SELECT
    Name,
    Num
FROM
    Players
WHERE
    PositionCode LIKE '_B';

-- 9. Направете заявка за мачовете на отбора през месец април 2018 г. с две колони: дата на мача и име на турнира, от който е мача.
SELECT
    m.MatchDate,
    t.Name
FROM
    Matches AS m
    INNER JOIN Tournaments AS t ON m.TournamentId = t.Id
WHERE
    m.MatchDate BETWEEN '2018-04-01' AND '2018-04-30';

/* 10. Направете заявка за статистиките на играч с номер на фланелката 99 със следните
колони:
1. Дата на мача
2. Име на играча
3. Номер на фланелката на играча
4. Минута на събитието
5. Четимият текст за събитието в мача
 */
SELECT
    m.MatchDate,
    p.Name,
    p.Num,
    ms.EventMinute,
    st.StatName
FROM
    MatchStats AS ms
    INNER JOIN Matches AS m ON ms.MatchId = m.Id
    INNER JOIN Players AS p ON ms.PlayerId = p.Id
    INNER JOIN StatTypes AS st ON ms.StatCode = st.StatCode
WHERE
    p.Num = 99;

-- 11. Направете заявка за общия брой автоголове на отбора
SELECT
    COUNT(*) AS 'Own Goal'
FROM
    MatchStats
WHERE
    StatCode = 'OG';

/* 12. Направете заявка за броя на вкараните голове във всеки един мач преди 2018-05-01,
в който е вкаран поне 1 гол, със следните колони:
1. Дата на мача
2. Брой вкарани голове в този мач
 */
SELECT
    m.MatchDate,
    COUNT(*) AS 'Goals'
FROM
    MatchStats AS ms
    INNER JOIN Matches AS m ON ms.MatchId = m.Id
WHERE
    ms.StatCode = 'G'
    AND m.MatchDate < '2018-05-01'
GROUP BY
    m.Id,
    m.MatchDate;

/* 13. Направете заявка за броя на головете според позицията на играчите със следните
колони:
1. Позиция в отбора като четим текст
2. Брой вкарани голове от играчи на тази позиция
Забележка: включете всички позиции в резултата, дори да няма вкарани
голове от играчи на тези позиции.
 */
SELECT
    pt.PositionName,
    COUNT(ms.StatCode) AS 'Goals'
FROM
    Players AS p
    LEFT JOIN MatchStats AS ms ON p.Id = ms.PlayerId
    AND ms.StatCode = 'G'
    INNER JOIN Positions AS pt ON p.PositionCode = pt.PositionCode
GROUP BY
    pt.PositionCode,
    pt.PositionName;


SELECT
    pt.PositionName,
    COUNT(ms.StatCode) AS 'Goals'
FROM
    Positions AS pt
    LEFT JOIN Players AS p ON pt.PositionCode = p.PositionCode
    LEFT JOIN MatchStats AS ms ON p.Id = ms.PlayerId
    AND ms.StatCode = 'G'
GROUP BY
    pt.PositionCode,
    pt.PositionName;


/* 14. Направете заявка за общия брой на картоните (жълти и червени) за всеки играч,
който има такива, сортирана по брой картони в низходящ ред, със следните колони:
1. Име на играча
2. Номер на фланелката на играча
3. Позиция в отбора като четим текст
4. Брой получени картони
 */
SELECT
    p.Name,
    p.Num,
    pt.PositionName,
    COUNT(ms.StatCode) AS 'Cards'
FROM
    MatchStats AS ms
    INNER JOIN Players AS p ON ms.PlayerId = p.Id
    INNER JOIN Positions AS pt ON p.PositionCode = pt.PositionCode
    INNER JOIN StatTypes ST on ms.StatCode = ST.StatCode
    AND (
        ms.StatCode = 'R'
        OR ms.StatCode = 'Y'
    )
GROUP BY
    p.Id,
    p.Name,
    p.Num,
    pt.PositionCode,
    pt.PositionName
ORDER BY
    COUNT(ms.StatCode) DESC;