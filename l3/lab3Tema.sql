CREATE TABLE Versions(
versionId int PRIMARY KEY,
versionNo int DEFAULT 0
)




DROP PROCEDURE doProc1,doProc2,doProc3,doProc4,doProc5,doProc6
DROP PROCEDURE undoProc1,undoProc2,undoProc3,undoProc4,undoProc5


--a)ALTERING THE COLUMN OF A TABLE

GO
CREATE PROCEDURE doProc1
AS
BEGIN
	ALTER TABLE Studentt
	ALTER COLUMN studentName varchar(300)
	PRINT('procedure A was completed')
END

--REVERSE
GO
CREATE PROCEDURE undoProc1
AS
BEGIN 
	ALTER TABLE Studentt
	ALTER COLUMN studentName varchar(20);
	PRINT('procedure A was undone')
END


--b)ADD A COLUMN TO A TABLE

GO
CREATE PROCEDURE doProc2
AS
BEGIN
ALTER TABLE Studentt
ADD City varchar(20)
PRINT('procedure B was completed')
END


--reverse

GO
CREATE PROCEDURE undoProc2
AS
BEGIN
	ALTER TABLE Studentt
	DROP COLUMN City
	PRINT('procedure B was undone')
END

--c)ADD A DEFAULT CONSTRAINT

GO
CREATE PROCEDURE doProc3
AS
BEGIN
	ALTER TABLE Studentt
	ADD CONSTRAINT nameStudent DEFAULT 'Nume Prenume' FOR studentName
	PRINT('procedure C was completed')
END

--REVERSE
GO
CREATE PROCEDURE undoProc3
AS
BEGIN 
	ALTER TABLE Studentt
	DROP CONSTRAINT nameStudent
	PRINT('procedure C was undone')
END

--d)ADD PRIMARY KEY

GO
CREATE PROCEDURE doProc4
AS
BEGIN
	CREATE TABLE Payment(
	paymentId int,
	amount int,
	CONSTRAINT pk_Payment PRIMARY KEY(paymentId))
	PRINT('procedure D was completed')
END

--REVERSE

GO
CREATE PROCEDURE undoProc4
AS
BEGIN
	ALTER TABLE Payment
	DROP CONSTRAINT pk_Payment
	DROP TABLE Payment
	PRINT('procedure D was undone')
END

--e)ADD CANDIDATE KEY

GO
CREATE PROCEDURE doProc5
AS
BEGIN
	ALTER TABLE Studentt
	ADD CONSTRAINT nk_City UNIQUE(City)
	PRINT('procedure E was completed')
END

--REVERSE

GO
CREATE PROCEDURE undoProc5
AS
BEGIN
	ALTER TABLE Studentt
	DROP CONSTRAINT nk_City
	PRINT('procedure E was undone')
END;

--f)ADD A FOREIGN KEY

GO
CREATE PROCEDURE doProc6
AS
BEGIN
	ALTER TABLE Payment
	ADD studentId INT NOT NULL
	
	ALTER TABLE Payment
	ADD CONSTRAINT fk_Payment FOREIGN KEY(studentId) REFERENCES Studentt(studentId)
	PRINT('procedure F was completed')
END

--REVERSE

GO
CREATE PROCEDURE undoProc6
AS
BEGIN
	ALTER TABLE Payment
	DROP CONSTRAINT fk_Payment

	ALTER TABLE Payment
	DROP COLUMN studentId
	PRINT('procedure F was undone')
END


--g)CREATE A TABLE

GO
CREATE PROCEDURE doProc7
AS 
BEGIN
	CREATE TABLE StudentFile(
		fileID int,
		dateOfCreation date)
		PRINT('procedure G was completed')
END

--REVERESE

GO
CREATE PROCEDURE undoProc7
AS
BEGIN
	DROP TABLE StudentFile
	PRINT('procedure G was undone')
END



--main


GO 
CREATE PROCEDURE main
	@version1 varchar(20),
	@procedureToExecute varchar(30),
	@currentVersion int 
AS
BEGIN
	--variable declarations
	
	--we take the current version from the version table
	set @currentVersion = (SELECT versionNo FROM Versions)
	--print('currentVersion ' +@currentVersion)

	--print(@version1)
	
	--check if the version is a number in the first place
		
		
		IF ISNUMERIC(@version1) != 1
		BEGIN 
			PRINT( ' Please input a number')
			RETURN 1;
		END

		SET @version1 = cast(@version1 AS INT)
		--check if the version is valid
		IF @version1 < 0 or @version1 > 7
		BEGIN
			PRINT('Invalid version!')
			RETURN 2;
		END



		--print('version1' + @version1)
		--print('currentVersion is ' +@currentVersion)

		--go up on the version scale
		SET @currentVersion = cast(@currentVersion as int) 
		WHILE @currentVersion < @version1
		BEGIN
			SET @currentVersion = @currentVersion +1
			SET @procedureToExecute = 'doProc' + cast(@currentVersion as varchar(4))
			--print(@procedureToExecute)
			EXEC @procedureToExecute
		END
		--print(@currentVersion)


		--print(@version1)
		--down on the version scale
		WHILE @currentVersion > @version1
		BEGIN
			SET @procedureToExecute = 'undoProc' + cast(@currentVersion as varchar(4))
			SET @currentVersion = @currentVersion -1
			EXEC @procedureToExecute
		END

		UPDATE Versions
		SET versionNo=@currentVersion
		WHERE versionId = 1;
END

drop procedure main

EXEC main @version1 = 'dasd',@procedureToExecute='',@currentVersion=0;
EXEC main @version1 = '2',@procedureToExecute='',@currentVersion=0;
EXEC main @version1 = '0',@procedureToExecute='',@currentVersion=0;

SELECT *
FROM Versions

INSERT INTO Versions
values(1,0)

SELECT *
FROM Studentt

DELETE FROM Versions





