prompt "Starting connect to AWS RDS"

CONNECT adminDBA/passQWEword123@(DESCRIPTION=(ADDRESS=(PROTOCOL=TCP)(HOST=database-1.c7ajhvbzxjvi.us-east-1.rds.amazonaws.com)(PORT=1521))(CONNECT_DATA=(SID=ORCL)))

prompt "End of connect"
