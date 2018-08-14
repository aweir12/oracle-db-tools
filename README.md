# oracle-db-tools
Useful tools when working in an Oracle Database.

<table><tr><td><b>Script Name</b></td><td><b>Description</b></td></tr>
  <tr><td>table-profile.sql</td><td>Creates a function that gives details about every column in a table.</td></tr></table>
  
  <h3>table-profile.sql</h3>
  This script creates a few database objects (one type object, one type table, and one function). The script does some quick profiling of each column in a given table. Once the objects in the script have been created, you can pass a table name to the function to retrieve details about each column in table.
  
<b> Example </b> ``` select * from table(data_profile('dual')); ```
