prompt "Upserting rows into database"

BEGIN
  INSERT INTO Persons (ID, LastName, FirstName, Age, Address, City)
    VALUES ('1', 'UPSERT', 'Testing', '123', '1234 Testing Street Unit A', 'Testing City');
EXCEPTION
  WHEN dup_val_on_index THEN
    UPDATE Persons
    SET LastName = 'UPSERT',
        Age = '123',
        Address = '1234 Testing Street Unit A',
        City = 'Testing City'
    WHERE ID = '1';
END;

prompt "Exiting upsertRows script"
