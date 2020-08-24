--Controls whether to display output of stored procedures or PL/SQL blocks in SQL*Plus
set serveroutput on size 1000000

--Sets whether or not the response from insert/delete/update command shows
--the X number of lines affected
set feedback on

--Controls whether or not to echo commands in a script that
--is executed with @, @@ or START. ON displays the commands on screen
set echo off

--Controls whether to list the text of a SQL statement or PL/SQL
--command before and after replacing substitution variables with values.
--ON lists the text; OFF suppresses the listing.
set verify off

prompt "Defining variables"

--Turns on error logging at specified error location
spool errorLogs/masterErrors.log append

prompt "Start of master script"

@@connect.sql
@@second.sql "Passing to script"
@@createTable.sql
@@dropTable.sql

spool off

prompt "End of master script"
prompt "Deleting variables"
UNDEFINE LOCATION
