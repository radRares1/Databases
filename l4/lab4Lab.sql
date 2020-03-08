USE drivingSchool
GO

if exists (select * from dbo.sysobjects where id = object_id(N'[FK_TestRunTables_Tables]') and OBJECTPROPERTY(id, N'IsForeignKey') = 1)

ALTER TABLE [TestRunTables] DROP CONSTRAINT FK_TestRunTables_Tables

GO



if exists (select * from dbo.sysobjects where id = object_id(N'[FK_TestTables_Tables]') and OBJECTPROPERTY(id, N'IsForeignKey') = 1)

ALTER TABLE [TestTables] DROP CONSTRAINT FK_TestTables_Tables

GO



if exists (select * from dbo.sysobjects where id = object_id(N'[FK_TestRunTables_TestRuns]') and OBJECTPROPERTY(id, N'IsForeignKey') = 1)

ALTER TABLE [TestRunTables] DROP CONSTRAINT FK_TestRunTables_TestRuns

GO



if exists (select * from dbo.sysobjects where id = object_id(N'[FK_TestRunViews_TestRuns]') and OBJECTPROPERTY(id, N'IsForeignKey') = 1)

ALTER TABLE [TestRunViews] DROP CONSTRAINT FK_TestRunViews_TestRuns

GO



if exists (select * from dbo.sysobjects where id = object_id(N'[FK_TestTables_Tests]') and OBJECTPROPERTY(id, N'IsForeignKey') = 1)

ALTER TABLE [TestTables] DROP CONSTRAINT FK_TestTables_Tests

GO



if exists (select * from dbo.sysobjects where id = object_id(N'[FK_TestViews_Tests]') and OBJECTPROPERTY(id, N'IsForeignKey') = 1)

ALTER TABLE [TestViews] DROP CONSTRAINT FK_TestViews_Tests

GO



if exists (select * from dbo.sysobjects where id = object_id(N'[FK_TestRunViews_Views]') and OBJECTPROPERTY(id, N'IsForeignKey') = 1)

ALTER TABLE [TestRunViews] DROP CONSTRAINT FK_TestRunViews_Views

GO



if exists (select * from dbo.sysobjects where id = object_id(N'[FK_TestViews_Views]') and OBJECTPROPERTY(id, N'IsForeignKey') = 1)

ALTER TABLE [TestViews] DROP CONSTRAINT FK_TestViews_Views

GO



if exists (select * from dbo.sysobjects where id = object_id(N'[Tables]') and OBJECTPROPERTY(id, N'IsUserTable') = 1)

drop table [Tables]

GO



if exists (select * from dbo.sysobjects where id = object_id(N'[TestRunTables]') and OBJECTPROPERTY(id, N'IsUserTable') = 1)

drop table [TestRunTables]

GO



if exists (select * from dbo.sysobjects where id = object_id(N'[TestRunViews]') and OBJECTPROPERTY(id, N'IsUserTable') = 1)

drop table [TestRunViews]

GO



if exists (select * from dbo.sysobjects where id = object_id(N'[TestRuns]') and OBJECTPROPERTY(id, N'IsUserTable') = 1)

drop table [TestRuns]

GO



if exists (select * from dbo.sysobjects where id = object_id(N'[TestTables]') and OBJECTPROPERTY(id, N'IsUserTable') = 1)

drop table [TestTables]

GO



if exists (select * from dbo.sysobjects where id = object_id(N'[TestViews]') and OBJECTPROPERTY(id, N'IsUserTable') = 1)

drop table [TestViews]

GO



if exists (select * from dbo.sysobjects where id = object_id(N'[Tests]') and OBJECTPROPERTY(id, N'IsUserTable') = 1)

drop table [Tests]

GO



if exists (select * from dbo.sysobjects where id = object_id(N'[Views]') and OBJECTPROPERTY(id, N'IsUserTable') = 1)

drop table [Views]

GO



CREATE TABLE [Tables] (

	[TableID] [int] IDENTITY (1, 1) NOT NULL ,

	[Name] [nvarchar] (50) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL 

) ON [PRIMARY]

GO



CREATE TABLE [TestRunTables] (

	[TestRunID] [int] NOT NULL ,

	[TableID] [int] NOT NULL ,

	[StartAt] [datetime] NOT NULL ,

	[EndAt] [datetime] NOT NULL 

) ON [PRIMARY]

GO



CREATE TABLE [TestRunViews] (

	[TestRunID] [int] NOT NULL ,

	[ViewID] [int] NOT NULL ,

	[StartAt] [datetime] NOT NULL ,

	[EndAt] [datetime] NOT NULL 

) ON [PRIMARY]

GO



CREATE TABLE [TestRuns] (

	[TestRunID] [int] IDENTITY (1, 1) NOT NULL ,

	[Description] [nvarchar] (2000) COLLATE SQL_Latin1_General_CP1_CI_AS NULL ,

	[StartAt] [datetime] NULL ,

	[EndAt] [datetime] NULL 

) ON [PRIMARY]

GO



CREATE TABLE [TestTables] (

	[TestID] [int] NOT NULL ,

	[TableID] [int] NOT NULL ,

	[NoOfRows] [int] NOT NULL ,

	[Position] [int] NOT NULL 

) ON [PRIMARY]

GO



CREATE TABLE [TestViews] (

	[TestID] [int] NOT NULL ,

	[ViewID] [int] NOT NULL 

) ON [PRIMARY]

GO



CREATE TABLE [Tests] (

	[TestID] [int] IDENTITY (1, 1) NOT NULL ,

	[Name] [nvarchar] (50) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL 

) ON [PRIMARY]

GO



CREATE TABLE [Views] (

	[ViewID] [int] IDENTITY (1, 1) NOT NULL ,

	[Name] [nvarchar] (50) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL 

) ON [PRIMARY]

GO



ALTER TABLE [Tables] WITH NOCHECK ADD 

	CONSTRAINT [PK_Tables] PRIMARY KEY  CLUSTERED 

	(

		[TableID]

	)  ON [PRIMARY] 

GO



ALTER TABLE [TestRunTables] WITH NOCHECK ADD 

	CONSTRAINT [PK_TestRunTables] PRIMARY KEY  CLUSTERED 

	(

		[TestRunID],

		[TableID]

	)  ON [PRIMARY] 

GO



ALTER TABLE [TestRunViews] WITH NOCHECK ADD 

	CONSTRAINT [PK_TestRunViews] PRIMARY KEY  CLUSTERED 

	(

		[TestRunID],

		[ViewID]

	)  ON [PRIMARY] 

GO



ALTER TABLE [TestRuns] WITH NOCHECK ADD 

	CONSTRAINT [PK_TestRuns] PRIMARY KEY  CLUSTERED 

	(

		[TestRunID]

	)  ON [PRIMARY] 

GO



ALTER TABLE [TestTables] WITH NOCHECK ADD 

	CONSTRAINT [PK_TestTables] PRIMARY KEY  CLUSTERED 

	(

		[TestID],

		[TableID]

	)  ON [PRIMARY] 

GO



ALTER TABLE [TestViews] WITH NOCHECK ADD 

	CONSTRAINT [PK_TestViews] PRIMARY KEY  CLUSTERED 

	(

		[TestID],

		[ViewID]

	)  ON [PRIMARY] 

GO



ALTER TABLE [Tests] WITH NOCHECK ADD 

	CONSTRAINT [PK_Tests] PRIMARY KEY  CLUSTERED 

	(

		[TestID]

	)  ON [PRIMARY] 

GO



ALTER TABLE [Views] WITH NOCHECK ADD 

	CONSTRAINT [PK_Views] PRIMARY KEY  CLUSTERED 

	(

		[ViewID]

	)  ON [PRIMARY] 

GO



ALTER TABLE [TestRunTables] ADD 

	CONSTRAINT [FK_TestRunTables_Tables] FOREIGN KEY 

	(

		[TableID]

	) REFERENCES [Tables] (

		[TableID]

	) ON DELETE CASCADE  ON UPDATE CASCADE ,

	CONSTRAINT [FK_TestRunTables_TestRuns] FOREIGN KEY 

	(

		[TestRunID]

	) REFERENCES [TestRuns] (

		[TestRunID]

	) ON DELETE CASCADE  ON UPDATE CASCADE 

GO



ALTER TABLE [TestRunViews] ADD 

	CONSTRAINT [FK_TestRunViews_TestRuns] FOREIGN KEY 

	(

		[TestRunID]

	) REFERENCES [TestRuns] (

		[TestRunID]

	) ON DELETE CASCADE  ON UPDATE CASCADE ,

	CONSTRAINT [FK_TestRunViews_Views] FOREIGN KEY 

	(

		[ViewID]

	) REFERENCES [Views] (

		[ViewID]

	) ON DELETE CASCADE  ON UPDATE CASCADE 

GO



ALTER TABLE [TestTables] ADD 

	CONSTRAINT [FK_TestTables_Tables] FOREIGN KEY 

	(

		[TableID]

	) REFERENCES [Tables] (

		[TableID]

	) ON DELETE CASCADE  ON UPDATE CASCADE ,

	CONSTRAINT [FK_TestTables_Tests] FOREIGN KEY 

	(

		[TestID]

	) REFERENCES [Tests] (

		[TestID]

	) ON DELETE CASCADE  ON UPDATE CASCADE 

GO



ALTER TABLE [TestViews] ADD 

	CONSTRAINT [FK_TestViews_Tests] FOREIGN KEY 

	(

		[TestID]

	) REFERENCES [Tests] (

		[TestID]

	),

	CONSTRAINT [FK_TestViews_Views] FOREIGN KEY 

	(

		[ViewID]

	) REFERENCES [Views] (

		[ViewID]

	)

GO

CREATE TABLE AlumniStudents(
AlumnId int NOT NULL,
AlumnName varchar(20) NOT NULL,
City varchar(10),
CONSTRAINT PK_AlumniStudents Primary Key(AlumnId,AlumnName)
)

INSERT INTO StudentFile
VALUES(1,'123456789',5)

CREATE TABLE fakeStudent(
studentId tinyint primary key,
studentName varchar(20))


CREATE TABLE StudentFile(
FileId int primary key,
CNP varchar(50),
studentId tinyint FOREIGN KEY REFERENCES fakeStudent(studentId)
)






create table Car2(
carId int primary key,
plateNumber varchar(50)
)


--insert into the tables procedure



GO
CREATE PROCEDURE insertIntoTable
	@numRows varchar(30),
	@tableName varchar(30)
AS
BEGIN
	
	IF ISNUMERIC(@numRows) != 1
	BEGIN
		print('Input a number of rows, please!')
		return 1
	END

	SET @numRows = cast(@numRows as INT)

	--initialize data to be inserted

	--Car
	DECLARE @carId varchar(4)
	DECLARE @plateNum varchar(20)
	set @carId = '1'
	set @plateNum = 'AB-99-RAD'

	--StudentFile
	DECLARE @fileId varchar(4)
	DECLARE @cnp varchar(10)
	DECLARE @studentId varchar(4)

	set @fileId = '1'
	set @cnp = '1234567890'
	set @studentId = '1'
	
	--AlumniStudents
	DECLARE @alumnId varchar(4)
	DECLARE @alumnName varchar(15)
	DECLARE @city varchar(10)


	set @alumnId = '1'
	set @alumnName = 'Rares'
	set @city = 'Blaj'

	DECLARE @stepCounter int
	set @stepCounter = 1

	while @stepCounter <= @numRows
	BEGIN

		

		if @tableName = 'Car'
		begin
			set @carId = @stepCounter
			set @plateNum = @plateNum+ cast(@stepCounter as varchar)
			
			
			INSERT INTO Car2
			Values(@carId,@plateNum)
		
		end

		if @tableName = 'StudentFile'
		begin 
			
			INSERT INTO fakeStudent
			Values(@stepCounter,cast(@stepCounter as varchar))
			--print(cast(@stepCounter as varchar))

		
			--print(cast(@getFk as varchar))
			
			set @fileId = @stepCounter
			set @cnp = @cnp + cast(@stepCounter as varchar)

			INSERT INTO StudentFile
			Values(@fileId,@cnp,(SELECT studentId FROM fakeStudent WHERE studentId=@stepCounter))

			--select * 
			--from StudentFile
		
		end

		if @tableName = 'AlumniStudents'
		begin
			set @alumnId = @stepCounter
			set @alumnName = @alumnName + cast(@stepCounter as varchar)
			set @city = @city + cast(@stepCounter as varchar)

			INSERT INTO AlumniStudents
			Values(@alumnId,@alumnName,@city)
		
		end

		set @stepCounter = @stepCounter + 1

	end

END



--delete from tables procedure

GO
CREATE PROCEDURE deleteFromTable
	@numRows varchar(30),
	@tableName varchar(30)
AS
BEGIN

	--check if the numRows is actually a number
	
	IF ISNUMERIC(@numRows) != 1
	BEGIN
		print('Input the number of rows, please!')
		return 1
	END

	SET @numRows = cast(@numRows as INT)

	DECLARE @lastRow int
	
	--check what table we have and delete from it

	IF @tableName = 'Car'
	BEGIN
		 
		set @lastRow = cast((SELECT MAX(carId) FROM Car2) as int)
		--delete all from car
		WHILE @lastRow > 0
		BEGIN

			DELETE FROM Car2
			WHERE carId = @lastRow
			set @lastRow = cast((SELECT MAX(carId) FROM Car2) as int)

		END

	END

	IF @tableName = 'AlumniStudents'
	BEGIN
		
		set @lastRow = cast((SELECT MAX(AlumnId) FROM AlumniStudents) as int)
		--delete all from alumniStudents
		WHILE @lastRow > 0
		BEGIN

			DELETE FROM AlumniStudents
			WHERE AlumnId = @lastRow
			set @lastRow = cast((SELECT MAX(AlumnId) FROM AlumniStudents) as int)
		
		END

	END

	IF @tableName = 'StudentFile'
	BEGIN

		set @lastRow = cast((SELECT MAX(FileId) FROM StudentFile) as int)
		--delete all from studentFile
		WHILE @lastRow > 0
		BEGIN

			
			DELETE FROM StudentFile
			WHERE FileId = @lastRow

			DELETE FROM fakeStudent
			WHERE studentId = @lastRow

			
			set @lastRow = cast((SELECT MAX(FileId) FROM StudentFile) as int)



		END
	END

END




--we create the views needed
GO
CREATE VIEW view1 AS
	SELECT AlumnName,City
	FROM AlumniStudents
GO

CREATE VIEW view2 AS
	SELECT CNP,studentName
	FROM StudentFile,Studentt
GO

CREATE VIEW view3 AS
	SELECT SF.CNP, S.studentName
	FROM StudentFile SF INNER JOIN Studentt S ON S.studentId=SF.studentId
GO



--view evaluation procedure


GO
CREATE PROCEDURE evaluateView
	@viewName varchar(30)
AS
BEGIN

	--we check what view we want to evaluate and then select from it

	if @viewName = 'view1'
	begin
		
		select * from view1

	end

	if @viewName = 'view2'
	begin
		
		select * from view2

	end

	if @viewName = 'view3'
	begin
		
		select * from view3

	end

END


GO
CREATE PROCEDURE main2
	@rowNumber varchar(30)
AS
BEGIN
	if ISNUMERIC(@rowNumber) != 1
	BEGIN
		print('Please input a number!')
		return 1
	END

	    set @rowNumber = cast(@rowNumber as int)

		DECLARE @startTime datetime

		set @startTime = GETDATE()


		--get the exec time for the inserts

		--for the car

		DECLARE @carStartTimeInsert datetime
		set @carStartTimeInsert = GETDATE()
		execute insertIntoTable @rowNumber,'Car'
		DECLARE @carEndTimeInsert datetime
		set @carEndTimeInsert = GETDATE()

		--for the AlumniStudents

		DECLARE @alumniStartTimeInsert datetime
		set @alumniStartTimeInsert = GETDATE()
		execute insertIntoTable @rowNumber,'AlumniStudents'
		DECLARE @alumniEndTimeInsert datetime
		set @alumniEndTimeInsert = GETDATE()

		--for the StudentFile

		DECLARE @fileStartTimeInsert dateTime
		set @fileStartTimeInsert = GETDATE()
		execute insertIntoTable @rowNumber,'StudentFile'
		DECLARE @fileEndTimeInsert datetime
		set @fileEndTimeInsert = GETDATE()

		--get exec time for the deletes

			
		--for the car

		DECLARE @carStartTimeDelete datetime
		set @carStartTimeDelete = GETDATE()
		execute deleteFromTable @rowNumber,'Car'
		DECLARE @carEndTimeDelete datetime
		set @carEndTimeDelete = GETDATE()

		--for the AlumniStudents

		DECLARE @alumniStartTimeDelete datetime
		set @alumniStartTimeDelete = GETDATE()
		execute deleteFromTable @rowNumber,'AlumniStudents'
		DECLARE @alumniEndTimeDelete datetime
		set @alumniEndTimeDelete = GETDATE()

		--for the StudentFile

		DECLARE @fileStartTimeDelete dateTime
		set @fileStartTimeDelete = GETDATE()
		execute deleteFromTable @rowNumber,'StudentFile'
		DECLARE @fileEndTimeDelete datetime
		set @fileEndTimeDelete = GETDATE()


		--get exec time for the views

		--view1

		DECLARE @view1StartTime datetime
		set @view1StartTime = GETDATE()
		execute evaluateView 'view1'
		declare @view1EndTime datetime
		set @view1EndTime = GETDATE()

		--view2

		DECLARE @view2StartTime datetime
		set @view2StartTime = GETDATE()
		execute evaluateView 'view2'
		DECLARE @view2EndTime datetime
		set @view2EndTime = GETDATE()

		--view3

		DECLARE @view3StartTime datetime
		set @view3StartTime = GETDATE()
		execute evaluateView 'view3'
		DECLARE @view3EndTime datetime
		set @view3EndTime = GETDATE()


		--get the end time of all operations

		DECLARE @endTime datetime
		set @endTime = GETDATE()

		--DECLARE @desc varchar(100)
		--set @desc = 'TestRun' + cast((SELECT MAX(TestRunID) FROM TestRuns) as varchar) + 'insert, delete, ' +cast(@rowNumber as varchar) + ' rows and views'


		INSERT INTO TestRuns
		VALUES('insertCar',@carStartTimeDelete,@carEndTimeInsert),('insertAlumni',@alumniStartTimeInsert,@alumniEndTimeInsert),('insertStudentFile',@fileStartTimeInsert,@fileEndTimeInsert)
		,('deleteCar',@carStartTimeDelete,@carStartTimeInsert),('deleteAlumni',@alumniStartTimeDelete,@alumniEndTimeDelete),('deleteStudentFile',@fileStartTimeDelete,@fileEndTimeDelete)
		,('view1',@view1StartTime,@view1EndTime),('view2',@view2StartTime,@view2EndTime),('view3',@view3StartTime,@view3EndTime)


		select *
		from TestRuns
		--DECLARE @lastTestRunID int;
		--set @lastTestRunID = (select MAX(TestRunID) FROM TestRuns)

		--insert into TestRunTables
		--values((select TestRunID from TestRuns where TestRunID = 1 ),1,@carStartTimeDelete,@carEndTimeInsert)

		--insert into TestRunTables
		--values((select  TestRunID from TestRuns where TestRunID = 2),2,@alumniStartTimeDelete,@carEndTimeInsert)

		--insert into TestRunTables
		--values((select  TestRunID from TestRuns where TestRunID =3),3,@fileStartTimeDelete,@fileEndTimeInsert)


		--insert into TestRunViews
		--values((select  TestRunID from TestRuns where TestRunID =1),1,@view1StartTime,@view1EndTime)

		--insert into TestRunViews
		--values((select  TestRunID from TestRuns where TestRunID =2),2,@view2StartTime,@view2EndTime)

		--insert into TestRunViews
		--values((select  TestRunID from TestRuns where TestRunID =3),3,@view3StartTime,@view3EndTime)

END

drop procedure main2
drop procedure insertIntoTable
drop procedure deleteFromTable
drop procedure evaluateView

delete from TestRuns
delete from TestRunTables
delete from TestRunViews

delete from Tables
delete from Views

delete from AlumniStudents
delete from Car2
delete from fakeStudent
delete from StudentFile

EXECUTE main2 '255'

