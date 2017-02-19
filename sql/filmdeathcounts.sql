/*
THE FOLLOWING QUERIES ARE FOR [POSTGRESQL] FLAVOR
*/

/*
Which Quentin Tarantino movie has the most body counts?
Film                        bodycount 
--------------------------  ----------
Grindhouse: Double Feature  310 
*/

SELECT "Film", CAST("Body_Count" AS INT) as bodycount
FROM filmdeathcounts
WHERE "Director" LIKE '%Quentin%' ORDER BY 2 DESC LIMIT 1;

/* 
Who are the top 5 movie directors by total body count?
Director       sum(CAST(Body_Count AS INT))
-------------  ----------------------------
Peter Jackson  1517                        
John Woo       1500                        
Edward Zwick   1003                        
Wolfgang Pete  889                         
Zack Snyder    808 
*/

SELECT "Director",
       sum(CAST("Body_Count" AS INT))
FROM filmdeathcounts
GROUP BY "Director"
ORDER BY 2 DESC LIMIT 5;

/*
What are the top three most violent movies?
Film                                   Body_Count
-------------------------------------  ----------
Lord of the Rings: Return of the King  836       
Kingdom of Heaven                      610       
300                                    600
*/
SELECT "Film",
       "Body_Count"
FROM filmdeathcounts
ORDER BY CAST("Body_Count" as INT) DESC LIMIT 3;



-- Which movie director has the least violent movies?
-- Director    sum(Body_Count)
-- ----------  ---------------
-- James Gray  2
SELECT "Director",
       SUM(CAST("Body_Count" as INT))
FROM filmdeathcounts
GROUP BY "Director"
ORDER BY 2 ASC LIMIT 10;

/* 
What are the three most violent years in film?
Year        sum(Body_Count)
----------  ---------------
2007        4095           
2004        3128           
2003        2580
*/
SELECT "Year",
       SUM(CAST("Body_Count" as INT))
FROM filmdeathcounts
GROUP BY "Year"
ORDER BY 2 DESC LIMIT 3;

/*
Have movies gotten more violent over the past 30+ years? Prove it.
 year | bodycount | BodyCountIncrease 
------+-----------+-------------------
 1987 |       535 |               535
 1988 |       407 |              -128
 1989 |       815 |               344
 1990 |       577 |                -9
 1991 |       424 |              -160
 1992 |       839 |               287
 1993 |       883 |               283
 1994 |       488 |              -152
 1995 |       953 |               332
 1996 |       550 |              -108
 1997 |       989 |               342
 1998 |      1011 |               333
 1999 |       990 |               284
 2000 |       361 |              -367
 2001 |      1289 |               587
 2002 |      2532 |              1791
 2003 |      2580 |              1727
 2004 |      3128 |              2174
 2005 |      2083 |              1008
 2006 |      1563 |               435
 2007 |      4095 |              2945
 2008 |      1785 |               495
 2009 |       605 |              -708
 2010 |       519 |              -763
 2013 |       156 |             -1094  

Yes, it generally got more violent looking at the mostly positive increment from previous year
Using averaged values from all prior years
*/
WITH T AS
    (SELECT "Year" as year,
            sum(CAST("Body_Count" as INT)) AS bodycount
     FROM filmdeathcounts
     WHERE "Year" >= CAST(TO_CHAR(NOW(), 'yyyy') AS INT)-30
     GROUP BY 1
     ORDER BY 1)
SELECT year,
       bodycount,
       bodycount - COALESCE(
    (SELECT ROUND(AVG(bodycount), 0)
     FROM T t2
     WHERE t2.year < t1.year
     ORDER BY 1),
              0) AS "BodyCountIncrease"
FROM T t1
ORDER BY 1 ;

/*
Are R-rated movies more violent compared to films rated G, PG, PG-13? Prove it.

bodycount in R Movies  bodycount in G, PG and PG-13 movies
---------------------  -----------------------------------
70.0                   72.0
Not really, as 70 is less than 72 in counting bodies averagely
*/
SELECT *
FROM
    (SELECT ROUND(AVG("Body_Count")) AS "bodycount in R Movies"
     FROM filmdeathcounts
     WHERE "MPAA_Rating" = 'R') AS a,
    (SELECT ROUND(AVG("Body_Count")) AS "bodycount in G, PG and PG-13 movies"
     FROM filmdeathcounts
     WHERE "MPAA_Rating" IN ('G',
                           'PG',
                           'PG-13')) AS b;

/*
How many R-rated movies with a IMDB Rating greater than 6.5 are in our dataset? 
count(*)  
----------
347

*/
SELECT count(*)
FROM filmdeathcounts
WHERE "IMDB_Rating" > 6.5;