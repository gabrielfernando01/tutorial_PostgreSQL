-----------------------------
-- Creating a New Table:
--	A CREATE TABLE is used to create base tables.  PostgreSQL has
--	its own set of built-in types.  (Note that SQL is case-
--	insensitive.)
-----------------------------

CREATE TABLE weather (
	city		varchar(80),
	temp_lo		int,		-- low temperature
	temp_hi		int,		-- high temperature
	prcp		real,		-- precipitation
	date		date
);

CRETE TABLE cities (
    name        varchar(80),
    location    point
);

-- If you don´t neeed a table any longer or want to recreate it
DROP TABLE tablename;

-------------------------------
-- INSERT statement is used to populate a table
INSERT INTO weather VALUES ('San Francisco', 46, 50, 0.25,
'1994-11-27');

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

-- So the same result result would be had with:
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


