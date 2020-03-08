CREATE TABLE version0(
versionId int,
versionNo int
)

CREATE TABLE Students(
studentId int PRIMARY KEY,
studentName varchar(20),
groupId INT,
age int)


ALTER TABLE Students
ALTER COLUMN age SMALLINT

--reverse
ALTER TABLE Students
ALTER COLUMN age INT

--ADD COLUMN

ALTER TABLE Students
ADD phoneNumber varchar(20)

--reverse

ALTER TABLE Students
DROP COLUMN phoneNumber

--add default constraint

ALTER TABLE Students
ADD CONSTRAINT of_Students DEFAULT 926 FOR groupId

--reverse
ALTER TABLE Students
DROP CONSTRAINT of_Students

--ADD PK

CREATE TABLE Grades(
gradeId int,
grade int,
CONSTRAINT pk_Grades PRIMARY KEY(gradeId))

--reverse
ALTER TABLE Grades
DROP CONSTRAINT pk_Grades
DROP TABLE Grades

--ADD CANDIDATE KEY
ALTER TABLE Students
ADD CONSTRAINT nk_Students UNIQUE(PhoneNumber)

--reverse
ALTER TABLE Students
DROP CONSTRAINT nk_Students

--6
ALTER TABLE Grades
ADD StId INT NOT NULL

ALTER TABLE Grades
ADD CONSTRAINT fk_Grades FOREIGN KEY(StId) REFERENCES Students(StId)

--reverse
ALTER TABLE Grades
DROP CONSTRAINT fk_Grades

ALTER TABLE Grade
DROP COLUMN StId

--7 just create a table man, then drop it wtf




