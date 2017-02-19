/*
THE FOLLOWING QUERIES ARE FOR [POSTGRESQL] FLAVOR
*/

/*
What is the sum total of Marvel characters with white or blond hair?

 characters 
------------
       2336
*/

SELECT count(DISTINCT name) AS characters
FROM "marvel-wikia-data"
WHERE hair in ('White Hair', 'Blond Hair');

/*
How many Marvel characters do not have a secret identity?

 count 
-------
  6331
*/

SELECT count(name)
FROM "marvel-wikia-data"
WHERE id <> 'Secret Identity';

/*
How many female characters are from Earth-616?

 count 
-------
  3825
*/

SELECT count(name)
FROM "marvel-wikia-data"
WHERE name LIKE '%Earth-616%'
    AND sex = 'Female Characters';

/*
List the top character by number of appearances created between 1980-2005

             name             | appearances 
------------------------------+-------------
 Katherine Pryde (Earth-616)  |         886
 Jennifer Walters (Earth-616) |         881
 Emma Frost (Earth-616)       |         880
 Samuel Guthrie (Earth-616)   |         657
 Remy LeBeau (Earth-616)      |         636
 Nathan Summers (Earth-616)   |         612
 Deadpool (Wade Wilson)       |         500
 Roberto da Costa (Earth-616) |         464
 Rahne Sinclair (Earth-616)   |         448
 Jubilation Lee (Earth-616)   |         408
*/
SELECT name,
       cast(appearances AS int)
FROM "marvel-wikia-data"
WHERE appearances IS NOT NULL
    AND YEAR BETWEEN '1980-01-01'::date AND '2005-01-01'::date
ORDER BY 2 DESC LIMIT 10;

/*
How many bad characters have more appearances than Bullseye but less than Wilson Fisk?

             name              | appearances 
-------------------------------+-------------
 Wilson Fisk (Earth-616)       |         503
 Sabretooth (Victor Creed)     |         382
 Johann Shmidt (Earth-616)     |         376
 Raven Darkholme (Earth-616)   |         371
 Felicia Hardy (Earth-616)     |         332
 MacDonald Gargan (Earth-616)  |         317
 Mephisto (Earth-616)          |         316
 Thanos (Earth-616)            |         306
 Bullseye (Lester) (Earth-616) |         277

9 characters
*/
WITH T AS
    (SELECT *
     FROM "marvel-wikia-data"
     WHERE align = 'Bad Characters'
     )
SELECT name,
       appearances
FROM T
WHERE appearances BETWEEN
        (SELECT appearances
         FROM T
         WHERE lower(name) LIKE '%bullseye%') AND
        (SELECT appearances
         FROM T
         WHERE lower(name) LIKE '%wilson fisk%' );