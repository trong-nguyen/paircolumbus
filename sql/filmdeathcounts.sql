/*
Which Quentin Tarantino movie has the most body counts?
Film                        BodyCount 
--------------------------  ----------
Grindhouse: Double Feature  310 
*/

SELECT Film, max(CAST(Body_Count AS INT)) as BodyCount
FROM fdc
WHERE Director LIKE '%Quentin%';

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

SELECT Director,
       sum(CAST(Body_Count AS INT))
FROM fdc
GROUP BY Director
ORDER BY 2 DESC LIMIT 5;

/*
What are the top three most violent movies?
Film                                   Body_Count
-------------------------------------  ----------
Lord of the Rings: Return of the King  836       
Kingdom of Heaven                      610       
300                                    600
*/
SELECT Film,
       Body_Count
FROM fdc
ORDER BY CAST(Body_Count as INT) DESC LIMIT 3;



-- Which movie director has the least violent movies?
-- Director    sum(Body_Count)
-- ----------  ---------------
-- James Gray  2
SELECT Director,
       CAST(Body_Count as INT)
FROM fdc
GROUP BY Director
ORDER BY 2 ASC LIMIT 10;

/* 
What are the three most violent years in film?
Year        sum(Body_Count)
----------  ---------------
2007        4095           
2004        3128           
2003        2580
*/
SELECT Year,
       CAST(Body_Count as INT)
FROM fdc
GROUP BY Year
ORDER BY 2 DESC LIMIT 3;

/*
Have movies gotten more violent over the past 30+ years? Prove it.
Year        BodyCount   BodyCountIncrease
----------  ----------  -----------------
1987        535         535              
1988        407         -128.0           
1989        815         344.0            
1990        577         -9.0             
1991        424         -160.0           
1992        839         287.0            
1993        883         283.0            
1994        488         -152.0           
1995        953         332.0            
1996        550         -108.0           
1997        989         342.0            
1998        1011        333.0            
1999        990         284.0            
2000        361         -367.0           
2001        1289        587.0            
2002        2532        1791.0           
2003        2580        1727.0           
2004        3128        2174.0           
2005        2083        1008.0           
2006        1563        435.0            
2007        4095        2945.0           
2008        1785        495.0            
2009        605         -708.0           
2010        519         -763.0           
2013        156         -1094.0    

Yes, it generally got more violent looking at the mostly positive increment from previous year
Using averaged values from all prior years
*/
WITH T AS
    (SELECT Year,
            sum(CAST(Body_Count as INT)) AS BodyCount
     FROM fdc
     WHERE Year >= strftime('%Y', 'now')-30
     GROUP BY Year
     ORDER BY 1)
SELECT Year,
       BodyCount,
       BodyCount - COALESCE(
    (SELECT ROUND(AVG(BodyCount), 0)
     FROM T T2
     WHERE T2.Year < T1.Year
     ORDER BY Year),
              0) AS 'BodyCountIncrease'
FROM T T1
ORDER BY Year ;

/*
Are R-rated movies more violent compared to films rated G, PG, PG-13? Prove it.

BodyCount in R Movies  BodyCount in G, PG and PG-13 movies
---------------------  -----------------------------------
70.0                   72.0
Not really, as 70 is less than 72 in counting bodies averagely
*/
SELECT *
FROM
    (SELECT ROUND(AVG(Body_Count)) AS 'BodyCount in R Movies'
     FROM fdc
     WHERE MPAA_Rating = 'R') AS a,
    (SELECT ROUND(AVG(Body_Count)) AS 'BodyCount in G, PG and PG-13 movies'
     FROM fdc
     WHERE MPAA_Rating IN ('G',
                           'PG',
                           'PG-13'));

/*
How many R-rated movies with a IMDB Rating greater than 6.5 are in our dataset? 
count(*)  
----------
347

*/
SELECT count(*)
FROM fdc
WHERE IMDB_Rating > 6.5;