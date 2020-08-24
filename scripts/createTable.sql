prompt "Starting createTable script"

CREATE TABLE Persons (
    ID int NOT NULL PRIMARY KEY,
    LastName varchar(255) NOT NULL,
    FirstName varchar(255),
    Age int,
    Address varchar(255),
    City varchar(255)
);

prompt "Ending createTable script"
