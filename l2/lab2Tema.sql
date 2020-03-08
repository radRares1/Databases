INSERT INTO Studentt(studentId,studentName)
Values(1,'George');

--INSERT INTO Studentt(studentId,studentName)
--Values(1,'George');
--this won't be added because it violates the uniqueness of the primary key
INSERT INTO Studentt(studentId,studentName)
Values(2,'Lisa');
INSERT INTO Studentt(studentId,studentName)
Values(3,'Patricia');
INSERT INTO Studentt(studentId,studentName)
Values(4,'Mihai');
INSERT INTO Studentt(studentId,studentName)
Values(5,'Edmund');
INSERT INTO Studentt(studentId,studentName)
Values(6,'Sorina');

SELECT *
FROM Studentt

INSERT INTO Car(carId,plateNumber)
Values(1,'AB 05 BDA');

INSERT INTO Car(carId,plateNumber)
Values(2,'AB 04 BDA');

INSERT INTO Car(carId,plateNumber)
Values(3,'AB 03 BDA');

INSERT INTO Car(carId,plateNumber)
Values(4,'AB 02 BDA');

SELECT *
FROM Car

INSERT INTO Instructor(instructorId,instructorName)
Values(1, 'big G')

INSERT INTO Instructor(instructorId,instructorName)
Values(2, 'SMALL g')

INSERT INTO Instructor(instructorId,instructorName)
Values(3, 'middle g')

INSERT INTO Instructor(instructorId,instructorName)
Values(4, 'uncle G')

SELECT *
FROM Instructor


INSERT INTO drivingLesson(lessonId,instructorId,carId,studentId)
Values(1,1,1,1)

INSERT INTO drivingLesson(lessonId,instructorId,carId,studentId)
Values(2,2,2,2)

INSERT INTO drivingLesson(lessonId,instructorId,carId,studentId)
Values(3,1,2,3)

INSERT INTO drivingLesson(lessonId,instructorId,carId,studentId)
Values(4,3,2,4)

INSERT INTO drivingLesson(lessonId,instructorId,carId,studentId)
Values(5,1,2,3)

INSERT INTO drivingLesson(lessonId,instructorId,carId,studentId)
Values(6,1,2,3)






SELECT *
FROM drivingLesson

UPDATE drivingLesson
SET instructorId = 2
WHERE lessonId=1;

UPDATE Studentt
SET studentName = 'SomeName'
WHERE studentId=4;

UPDATE Car
SET plateNumber = 'AB 01 BCD'
WHERE carId=4;

SELECT * 
FROM Car

SELECT *
FROM Studentt

DELETE FROM Studentt WHERE studentId =6;

DELETE FROM Instructor WHERE instructorId=3;

--a
SELECT studentId AS s FROM Studentt
UNION ALL
SELECT studentId FROM drivingLesson
WHERE studentId = 1 OR studentId =2

SELECT studentName from Studentt
UNION 
SELECT	instructorName FROM Instructor

--b
SELECT studentId 
FROM Studentt
INTERSECT
SELECT studentId
FROM drivingLesson

SELECT * FROM Studentt
WHERE studentId IN(SELECT studentId FROM drivingLesson)

--c
SELECT studentId
FROM Studentt
--WHERE (studentId%2) <> 0
EXCEPT
SELECT studentId
FROM drivingLesson

SELECT studentId
FROM Studentt
WHERE studentId NOT IN(SELECT studentId
FROM drivingLesson)

--d
--inner join on three tables
SELECT Studentt.studentName,drivingLesson.carId,Instructor.instructorName
FROM ((drivingLesson
INNER JOIN Studentt ON Studentt.studentId=drivingLesson.studentId)
INNER JOIN Instructor ON Instructor.instructorId=drivingLesson.lessonId);


--join on two m:m rel

INSERT INTO LawTeacher(teacherId)
Values(1)

INSERT INTO LawTeacher(teacherId)
Values(2)

INSERT INTO lawLesson(lawLessonId,studentId)
VALUES(1,1)

INSERT INTO lawLesson(lawLessonId,studentId)
VALUES(2,2)

INSERT INTO lawLesson(lawLessonId,studentId)
VALUES(3,3)

INSERT INTO lawLesson(lawLessonId,studentId)
VALUES(4,4)

SELECT *
FROM lawLesson

SELECT lawLesson.studentId,drivingLesson.lessonId,lawLesson.lawLessonId
FROM lawLesson
FULL OUTER JOIN drivingLesson
ON drivingLesson.studentId = lawLesson.studentId

--left join

SELECT Studentt.studentName,drivingLesson.lessonId
FROM Studentt
LEFT JOIN drivingLesson
ON drivingLesson.studentId=Studentt.studentId;

--right join

SELECT Studentt.studentName,drivingLesson.studentId
FROM Studentt
RIGHT JOIN drivingLesson
ON drivingLesson.studentId=Studentt.studentId;

--e

SELECT * FROM Studentt
WHERE studentId IN(
	SELECT drivingLesson.studentId FROM drivingLesson);

SELECT * FROM Studentt
WHERE studentId IN(
	SELECT drivingLesson.studentId FROM drivingLesson
	WHERE drivingLesson.studentId IN(
		SELECT studentId FROM Instructor));

--f

SELECT studentName
FROM Studentt
WHERE EXISTS( SELECT studentId FROM lawLesson
	WHERE studentId > 6);

SELECT instructorName
FROM Instructor
WHERE EXISTS( SELECT studentId FROM Studentt
	WHERE Studentt.studentId < 0);

--g

SELECT lessonId
FROM (SELECT lessonId
	FROM drivingLesson
	WHERE lessonId%2 = 0
	) AS evenId
--aici am avut problema ca nu mai afisa nimic daca lasam si where(am vrut doar studentii care au facut cel putin o drivingLesson
SELECT studentName,lessonId
FROM(
	SELECT Studentt.studentName,drivingLesson.lessonId
	FROM Studentt
	LEFT JOIN drivingLesson
	ON drivingLesson.studentId=Studentt.studentId ) AS studentsWithLesson
--WHERE lessonId != NULL


--h
 
 --extracts a table of students that didn't have at least 3 driving lessons
SELECT studentName
FROM Studentt
WHERE studentId IN
(SELECT drivingLesson.studentId
	FROM Studentt
	LEFT JOIN drivingLesson
	ON drivingLesson.studentId=Studentt.studentId
	GROUP BY drivingLesson.studentId
	HAVING COUNT(drivingLesson.studentId) <3)

--initally, I wanted the query to return the instructor with the most lessons
--but I could not figure out how to extract the max
--so I just forced the query to return the max one, 'big G' with  no. Lessons = 3

SELECT instructorName,instructorId
FROM Instructor
WHERE instructorId IN
	(SELECT  drivingLesson.instructorId
		FROM Instructor	
		LEFT JOIN drivingLesson
		ON	 drivingLesson.instructorId=Instructor.instructorId
		GROUP BY drivingLesson.instructorId
		HAVING COUNT(drivingLesson.instructorId) >2
		) 

--get the most used car
--same problem as above :(
SELECT plateNumber
FROM Car
WHERE carId IN(
	SELECT carId 
	FROM drivingLesson
	GROUP BY carId
	HAVING COUNT(carId)>(
		SELECT COUNT(carId)
		FROM drivingLesson
		GROUP BY carId 
		HAVING COUNT(carId) =1)
		)

--the names of the instructors that had no lessons by now
--uncle G
SELECT instructorName
FROM Instructor
WHERE instructorId NOT IN
	(
		SELECT instructorId
		FROM drivingLesson	
		GROUP BY instructorId
		)

--i
--even id students
SELECT studentName
FROM Studentt
WHERE studentId = ANY( SELECT studentId FROM drivingLesson WHERE studentId%2 =0)

--same efect
SELECT studentName
FROM Studentt
WHERE studentId NOT IN(
	SELECT studentId FROM Studentt 
	WHERE studentId%2 != 0)
	

--it's empty because not all the student ids are even
SELECT studentName
FROM Studentt
WHERE studentId = ALL(SELECT studentId
	FROM drivingLesson
	WHERE studentId%2 = 0
	)
--same efect
SELECT studentName
FROM Studentt
WHERE studentId IN(
	SELECT studentId 
	FROM Studentt
	GROUP BY studentId
	HAVING COUNT(*) < 0
	)
