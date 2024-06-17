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


