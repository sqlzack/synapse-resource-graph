/*!!!!!!!!!!!!!!!Run each statement by highlighting the entire statement and clicking execute*/

/*Statement 1 - Create Serverless Database if it does not already exist*/
/*Note: name the database whatever you like but just make sure to change all references to it*/
IF DB_ID('resourceGraphQueryResults') IS NULL 
BEGIN
    CREATE DATABASE resourceGraphQueryResults
END 

/*Statement 2 - Set the Query Window to your newly created database*/
USE resourceGraphQueryResults

/*Statement 3 - Create a view in the Database to point to the directory holding your JSON Files*/
CREATE OR ALTER VIEW v_threatSummary AS
SELECT ThreatName,ThreatCount
FROM
    OPENROWSET(
        BULK '<copy-path-to-json-here>',
        FORMAT = 'CSV',
        FIELDQUOTE = '0x0b',
        FIELDTERMINATOR ='0x0b',
        ROWTERMINATOR = '0x0b'
    )
    WITH (jsonContent varchar(MAX)) AS [result]
CROSS APPLY (SELECT JSON_QUERY(jsonContent, 'strict $.data.rows') as dataJSON) a
 CROSS APPLY OPENJSON(dataJSON) 
     WITH 
         (
             ThreatName varchar(max) 'strict $[0]',
             ThreatCount INT 'strict $[1]'
         )