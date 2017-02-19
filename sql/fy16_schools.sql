/*
THE FOLLOWING QUERIES ARE FOR [POSTGRESQL] FLAVOR
*/

/*
What is the average FY16 expenditure for rural schools?

 rural_spending 
----------------
       11,777,997
*/

SELECT ROUND(AVG(fy16_expenditures)) as rural_spending
FROM "fy16_school.districts" AS districts
JOIN "fy16_school.typologies" AS typologies ON TEXT(districts.typology) = TEXT(typologies.typology)
WHERE typologies.description LIKE 'Rural%';

/*
What are the top 5 urban school districts by FY16 expenditure?

        school_district        |  county  | fy16_expenditures 
-------------------------------+----------+-------------------
 Columbus City School District | Franklin |         811808942
 Cleveland Municipal           | Cuyahoga |         701845332
 Cincinnati City               | Hamilton |         519211546
 Toledo City                   | Lucas    |         363225824
 Akron City                    | Summit   |         320908322
*/

SELECT school_district,
       county,
       fy16_expenditures
FROM "fy16_school.districts" AS districts
JOIN "fy16_school.typologies" AS typologies ON TEXT(districts.typology) = TEXT(typologies.typology)
WHERE typologies.description LIKE 'Urban%'
ORDER BY 3 DESC LIMIT 5;

/*
Which school district has spent the most in FY16?

        school_district        |  county  | fy16_expenditures 
-------------------------------+----------+-------------------
 Columbus City School District | Franklin |         811808942
 Cleveland Municipal           | Cuyahoga |         701845332
 Cincinnati City               | Hamilton |         519211546
 Toledo City                   | Lucas    |         363225824
 Akron City                    | Summit   |         320908322
*/

SELECT school_district,
       county,
       coalesce(fy16_expenditures, 0) as fy16_expenditures
FROM "fy16_school.districts"
ORDER BY 3 DESC LIMIT 5;