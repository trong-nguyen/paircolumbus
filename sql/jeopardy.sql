/*
THE FOLLOWING QUERIES ARE FOR [POSTGRESQL] FLAVOR
*/

/*
How many Jeopardy questions have been asked about cheese?
count(*)  
----------
404
*/
SELECT count(*)
FROM jeopardy
WHERE question ~ '\mcheese(\M|s\M)';
-- '\mcheese(\M|s\M)' for either cheese or cheeses
-- '\mcheese\M' for anything about cheese (cheesemaking, cheeseburgers, cheesecake, cheesesteak, etc.)

-- This query to see other questions about cheese-related and not pure cheese/cheeses
SELECT question
FROM jeopardy
WHERE question like '%cheese%'
    AND NOT question IN
        (SELECT question
         FROM jeopardy
         WHERE question ~ '\mcheese(\M|s\M)');


/*
How many Jeopardy questions have been asked about the years 1800 - 1965 (use their category titles)? 
 count 
-------
 742
*/
SELECT count(DISTINCT question)
FROM jeopardy
WHERE (category ~ '\m18\d\d\D'
       OR category ~ '\m19[0-5]\d\D'
       OR category ~ '\m196[0-5]\D');
/*
According to Jeopardy which category of questions have more value - those relating to Ohio or Michigan? 

 ohio_related | michigan_related 
--------------+------------------
          288 |              212

Apparently, Ohio
*/
SELECT *
FROM
    (SELECT count(DISTINCT category) as ohio_related
     FROM jeopardy
     WHERE question LIKE '%Ohio%') a,
    (SELECT count(DISTINCT category) as michigan_related
     FROM jeopardy
     WHERE question LIKE '%Michigan%') b;

/*
How many times has the same answer been used on Jeopardy?
 same_answer | total  
-------------+--------
       88269 | 216930
*/
SELECT count(DISTINCT answer) same_answer, count(*) as Total
FROM jeopardy;

/*
In what months have questions with the answer 'Dr. Seuss' or 'The Bible' been asked? 
 month 
-------
     1
     2
     3
     4
     5
     6
     7
     9
    10
    11
    12

Except August!
*/
SELECT DISTINCT DATE_PART('month', air_date) AS Month
FROM jeopardy
WHERE answer LIKE '%Dr. Seuss%' or answer LIKE '%The Bible%'
Order by 1;
