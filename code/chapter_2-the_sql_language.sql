-----------------------------
-- Creating a New Table:
--	A CREATE TABLE is used to create base tables.  PostgreSQL has
--	its own set of built-in types.  (Note that SQL is case-
--	insensitive.)
-----------------------------

CREATE TABLE weather (
  city		    varchar(80),
  temp_lo		int,		-- low temperature
  temp_hi		int,		-- high temperature
  prcp		    real,		-- precipitation
  date		    date
);

CREATE TABLE cities (
  name        varchar(80),
  location    point
);

-- If you don´t neeed a table any longer or want to recreate it
DROP TABLE tablename;

-------------------------------
-- INSERT statement is used to populate a table
INSERT INTO weather VALUES ('San Francisco', 46, 50, 0.25, '1994-11-27');

-- The point type requires a coordinate pair as input, as show here;
INSERT INTO cities VALUES ('San Francisco', '(-194.0, 53.0)');

-- An alternative syntax allows you to list the columns explicity:
INSERT INTO weather (city, temp_lo, temp_hi, prcp, date)
  VALUES ('San Francisco', 43, 57, 0.0, '1994-11-29');

-- You can list the columns in a different order if you wish or even
-- omit some columns, e.g., if the precipitation is unknown;
INSERT INTO weather (date, city, temp_hi, temp_lo)
  VALUES ('1994-11-29', 'Hayward', 54, 37);

-- You could also have usede COPY to load large amounts of data from
-- flat-text-files.
-- COPY weather FROM '/home/user/weather.txt'

-- To retrive all the rows of table weather, type:
SELECT * FROM weather;

-- So the same result would be had with:
SELECT city, temp_lo, temp_hi, prcp, date FROM weather;

-- You can do:
SELECT city, (temp_lo + temp_hi)/2 AS temp_avg, date FROM weather;

-- The WHERE statement
SELECT * FROM weather
  WHERE city = 'San Francisco' AND prcp > 0.0;

-- You can request that the result of a query be returned in sorted order:

SELECT * FROM weather
  ORDER BY city;

SELECT * FROM weather
  ORDER BY city, temp_lo;

-- You can request that duplicate rows be removed from the results of a query:
SELECT DISTINCT city FROM weather;

SELECT DISTINCT city FROM weather
	ORDER BY city;

-- Joins between tables
SELECT * FROM weather JOIN cities ON city = name;

/* In practice this is undesirable, though, so you will probably want to list the output columns explicitly rather than using *:*/
SELECT city, temp_lo, temp_hi, prcp, date, location
    FROM weather JOIN cities ON city = name;

-- If there were duplicate column names in the two tables
-- you'd need to qualify the column names to show which one you meant
SELECT weather.city, weather.temp_lo, weather.temp_hi, 
  weather.prcp, weather.date, cities.location
  FROM weather JOIN cities ON weather.city = cities.name;

-- Join queries of the kind seen thus far can also be written 
-- in this form:
SELECT * FROM weather, cities
  WHERE city = name;

-- Left outer join
SELECT * FROM weather LEFT OUTER JOIN cities ON 
  weather.city = cities.name;

-- Right outer join
SELECT * FROM weather RIGHT OUTER JOIN cities ON weather.city = cities.name

-- Full outer join
SELECT * FROM weather FULL OUTER JOIN cities ON weather.city = cities.name

-- Make a query about itself
SELECT w1.city, w1.temp_lo AS low, w1.temp_hi AS high,
  w2.city, w2.temp_lo AS low, w2.temp_hi AS high
  FROM weather w1 JOIN weather w2
  ON w1.temp_lo < w2.temp_lo AND w1.temp_hi > w2.temp_hi;

-- A typical type of relabeling is as follows:
SELECT * FROM weather w JOIN cities c ON w.city = c.name;

-- Aggregate functions
SELECT max(temp_lo) FROM weather;

-- If we want to know which city the previous record corresponds to, we do:
SELECT city FROM weather
  WHERE temp_lo = (SELECT max(temp_lo) FROM weather);

SELECT city, count(*), max(temp_lo)
  FROM weather
  GROUP BY city;

-- We cand filter grouped rows using HAVING
SELECT city, count(*), max(temp_lo)
  FROM weather
  GROUP BY city
  HAVING max(temp_lo) < 40;


