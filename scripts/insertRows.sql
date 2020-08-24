prompt "Inserting rows into database"

INSERT INTO Persons (ID, LastName, FirstName, Age, Address, City)
VALUES ('1', 'DB', 'Testing', '12', '1234 Testing Street', 'Test City');

INSERT INTO Persons (ID, LastName, FirstName, Age, Address, City)
VALUES ('2', '#2', 'Testing', '34', '567 Test Dr', 'Tests');

INSERT INTO Persons (ID, LastName, FirstName, Age, Address, City)
VALUES ('3', '#3', 'Test', '56', '89 Test Way Apt 0', 'Testing');

prompt "Exiting insertRows script"
