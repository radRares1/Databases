Create table Puppies(
pid int primary key,
numberOfPuppies  int unique,
race varchar(10)
)

CREATE TABLE Customer(
cid INT PRIMARY KEY,
numberOfAquisitions int)

CREATE TABLE PetShop(
psid int primary key,
cid int foreign key references Customer(cid),
pid int foreign key references Puppies(pid)
)



--a)evaluate the indexes created on some WHERE/ORDERBY/JOIN QUERIES

--non-clustered index scan+key lookup

SELECT *
FROM Puppies
ORDER BY numberOfPuppies

--non-clustered index seek + key lookup

SELECT race
FROM Puppies
WHERE numberOfPuppies = 5

--clustered index seek

SELECT *
FROM PetShop
WHERE psid=30

--clustered index scan
SELECT *
FROM Puppies
WHERE race='bulldog'


--b)

SELECT *
FROM Customer
WHERE numberOfAquisitions=10

--clustered index scan
--estimated subtree cost 0.0032831

--we create a non-clustered index to speed up the exec plan

GO
CREATE NONCLUSTERED INDEX NCL_INDEX_CUSTOMER_AQ ON Customer(numberOfAquisitions)

DROP INDEX NCL_INDEX_CUSTOMER_AQ ON Customer



DELETE FROM Customer

GO
CREATE PROCEDURE addIntoCustomer
AS
BEGIN
DECLARE @VAL int
SET @VAL = 0
	while @VAL < 200
	BEGIN
		INSERT INTO Customer
		Values(@VAL,@VAL)

		INSERT INTO Puppies
		VALUES(@VAL,@VAL,CAST(@VAL AS VARCHAR))

		INSERT INTO PetShop
		VALUES(@VAL,(SELECT cid FROM Customer WHERE cid=@VAL),(SELECT pid FROM Puppies WHERE pid=@VAL))

		SET @VAL = @VAL + 1
	END
end

drop procedure addIntoCustomer

execute addIntoCustomer

SELECT cid
FROM Customer
WHERE numberOfAquisitions=10

--non-clustered index scan
--estimated subtree cost 0.0032831
--idk why but it's the same cost, even tho I added records to the table :(

GO
CREATE VIEW view3 AS
SELECT Customer.numberOfAquisitions, Customer.cid
FROM Customer
INNER JOIN PetShop ON PetShop.cid=Customer.cid
WHERE Customer.numberOfAquisitions=3

go
SELECT * from view3


--we can see the difference between the cluestered index scan and the non-clustered index(that we created) scan
--clustered subtree cost -> 0.0033227 
--vs.
--non-clustered subtree cost ->0.0089747
