/*
THE FOLLOWING QUERIES ARE FOR [POSTGRESQL] FLAVOR
*/

/*
How many organizations have an ownership stake in a Trump related business?
 
 count 
-------
   477
*/
WITH t AS
    (SELECT *
     FROM trumpworld_public
     WHERE "Connection" in ('Ownership', 'Co-owner'))
SELECT count(DISTINCT organization)
FROM
    (SELECT "Organization A" AS organization
     FROM t
     UNION SELECT "Organization B" AS organization
     FROM t) com;

/*
What is the sum total of companies that have loaned money or own collateralized debt in a Trump affiliated company?
 count 
-------
    65
*/
WITH t AS
    (SELECT *
     FROM trumpworld_public
     WHERE "Connection" IN ('Owns collateralized debt',
                            'Loaned money') )
SELECT count(DISTINCT organization)
FROM
    (SELECT "Organization A" AS organization
     FROM t
     UNION SELECT "Organization B" AS Organization
     FROM t) com;

/*
How many organizations in our dataset are named after Trump?
 count 
-------
   268
*/

SELECT count(organization)
FROM
    (SELECT DISTINCT "Organization A" AS organization
     FROM trumpworld_public
     WHERE lower("Organization A") LIKE '%trump%'
     UNION SELECT DISTINCT "Organization B" AS organization
     FROM trumpworld_public
     WHERE lower("Organization B") LIKE '%trump%') com;