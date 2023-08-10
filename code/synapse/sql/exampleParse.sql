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
order by ThreatCount DESC