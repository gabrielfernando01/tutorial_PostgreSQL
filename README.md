![](https://raw.githubusercontent.com/gabrielfernando01/tutorial_PostgreSQL/main/images/cover.png)

# Tutorial PostgreSQL 🐘

### What is PostgreSQL 🐘?

PostgreSQL is an object-relational database management system (ORDBMS) based on POSTGRES, Version 4.2, developed at the University of California at Berkeley Computer Science Departament. POSTGRES pioneered many concepts that only became avaible in some commercial database system much later.

PostgreSQL is an open-source descendant of this original Berkeley code. It support a large part of the SQL standard and offers many modern features:

- complex queries
- foreign keys
- triggers
- updatable views
- transactional integrity
- multiversion concurrency control

Also, PostgreSQL can be extended by the user in many ways, for example by adding new:

- data types
- functions
- operators
- aggregate functions
- index methods
- procedural languages

And because of the liberal license, PostgreSQL can be used, modifed, and distributed by anyone free of charge for any purpose, be it private, commercial, or academic.

## Part I. Tutorial

### Chapter 1. Getting Started

**1.1. Installation**

For my case, I use OS Ubuntu 22.04 and I followed the steps of official documantation that you can find here 👉🏼 [download PostgreSQL](https://www.postgresql.org/download/linux/ubuntu/).

You can follow the steps described below 👇🏼 from the command line:

```
# Import the repository signing key:
$ sudo apt install curl ca-certificates
$ sudo install -d /usr/share/postgresql-common/pgdg
$ sudo curl -o /usr/share/postgresql-common/pgdg/apt.postgresql.org.asc --fail https://www.postgresql.org/media/keys/ACCC4CF8.asc

# Create the repository configuration file
$ sudo sh -c 'echo "deb [arch=amd64] https://apt.postgresql.org/pub/repos/apt $(lsb_release -cs)-pgdg main" > /etc/apt/sources.list.d/pgdg.list'

# Update the package lists:
$ sudo apt update

# Install the lastest version of PostgreSQL:
# If you want a specific version, use 'postgresql-16' or similar instead of 'postgresql'
$ sudo apt -y install postgresql

# Load in start system
$ systemctl enable postgresql

# Show status of postgresql
$ systemctl status postgresql

# Show version of PostgreSQL
$ sudo -u postgres psql -c "SELECT version();"
```

**1.2. Architecture Fundamentals 📐**

Before we proceed, you should understand the basic PostgreSQL system architecture. Understandig how the parts of PostgreSQL, interact will make this chapter somewhat clearer.

In database jargon, PostgreSQL, use a client/server model. A PostgreSQL session consists of the following cooperating processes (programs):

- A server process, which manages the database files, accepts connections to the database from client application, and performs database actions on behalf of clients. The database server program is called <code>postgres</code>.

- The user's client (frontend) application that wants to perform database operation. Client applications can be very diverse in nature: a client could be a text-oriented tool, a graphical application, a web server that accesses the database to display web pages, or a specialized database maintenance tool. Some client application are supplied with the PostgreSQL distrubution; most are developed by users.

As a typical of client/server application, the client and the server can be on different host. In that case they communicate over a TCP/IP network connection. You should keep this in mind, because the files that can be accessed on a client machine might not be accessible (or might only be accessible using a difrent file name) on the database server machine.

**1.3. Creating a Database 🛢**

The first to see whether you can access the database server is to try to create a database. A running PostgreSQL server can manage many database. Typically, a separate database is used for each project of for each user.

```
# Switch defect user
$ sudo -i -u postgres
$ psql

# Or access from terminal
$ sudo -u postgres psql

# Create role
postgres=# CREATE ROLE name WITH LOGIN SUPERUSER CREATEDB CREATEROLE;
postgres=# \exit		

```

To create a new database, in this example named <code>mydb</code>, you use the following command:

<code>$ createdb mydb</code>

If you do not want to use your database anymore you can remove it. For example, if you are the owner (creator) of the database <code>mydb</code>, you can destroy it using the following command:

<code>$ dropdb mydb</code>

**1.4. Accessing a Database 🛢**

Once you have created a database, you can access it by:

- Running the PostgreSQL, interactive terminal program, called _psql_, which allows you to interactively enter, edit, and excecute SQL commands.
- Using an existing graphical frontend tool like pgAdmin or an office suite with ODBC or JDBC support to create and manipulate a database. These possibilities are not covered in this tutorial.
- Writting a custom application, using one of the several avaible language bindings.

You can be activated <code>mydb</code> by typing the command:

<code>$ psql mydb</code>

You should see something like:

<code>mydb=#</code>

These line printed out by <code>psql</code> is the prompt, and it indicates that <code>psql</code> is listening to you and that you can type SQL queries into a work space maintained by <psql>. Try out these commands:  

mydb=# **SELECT version();**

mydb=# **SELECT current_date**

```
# You can get help on the syntax of various PostgreSQL SQL commands by typing:
mydb=# \h

# To getout of psql, type:
mydb=# \q
```
For more internal commands, type <code>\?</code> at the <code>psql</code> prompt.

### Chapter 2. The SQL Language 🛢️

**2.1. Introduction**

To start the tutorial, do the following:

<code>$ psql -s mydb</code>

**2.2. Concepts**

Each table is named collection of _rows_. Each row of a given table has the same set of named _columns_, and each column is of a specific data type. Whereas columns have a fixed order in each row, it is important to remember that SQL does not guarantee the order of the rows within the table in any way (although they can be explicity sorted for display).

Tables are grouped into databases, and a collection of databases managed by a single PostgreSQL server instance sonstitutes a database _cluster_.

**2.3 Creating a New Table**

You can create a new table by specifying the table name, along with all column names and their types:

```
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
```

The second example will store cities and their associate geographical location:

```
CREATE TABLE cities (
	name			varchar(80),
	location		point
);
```

The point type is an example of a PostgreSQL specific data type.

If you don't need a table any longer or want to recreate it differently you can remove it using the following command:

```
DROP TABLE tablename;
```

**2.4. Population a Table with Rows**

The <code>INSERT</code> statment is used to populate a table with rows:

```
INSERT INTO weather VALUES ('San Francisco', 46, 50, 0.25, '1994-11-27');
```

More examples of how insert register inside the table, view the code folder.

**2.5. Querying a Table**

To retrive all the row of table <code>weather</code>, type:

```
SELECT * FROM weather;
```

So the same result result would be had with:

```
SELECT city, temp_lo, temp_hi, prcp, date FROM weather;
```

You can write expresion, no just simple column references, in the select list. For example, you can do:

```
SELECT city, (temp_lo + temp_hi)/2 AS temp_avg, date FROM weather;

SELECT * FROM weather
  WHERE city = 'San Francisco' AND prcp > 0.0;
```

You can request that the result of a query be returned in sorted order:

```
SELECT * FROM weather
  ORDER BY city;

SELECT * FROM weather
  ORDER BY city, temp_lo;
```

You can request that duplicate rows be removed from the results of a query:
```
SELECT DISTINCT city FROM weather;

SELECT DISTINCT city FROM weather
  ORDER BY city;
```

**2.6. Joins Between Tables**

Queries that access multiple tables (or multiple instance of the same table) at one time are called _join_ queries. They combine rows from one table with rows from a second table, with an expression specifying which rows are to be paired. For example, to return all the weather records together with the location of the associated city the database needs to compare the <code>city</code> column of each row of the <code>weather</code> table with the <code>name</code> column of all rows in the <code>cities</code> table, and select the pairs of rows where the values match.

So far we have declared a couple of tables: weather and cities 👇🏼:

![](https://raw.githubusercontent.com/gabrielfernando01/tutorial_PostgreSQL/main/images/weather_cities.png)

This would be accomplished by the following 👇🏼 query:

```
SELECT * FROM weather JOIN cities ON city = name;
```

![](https://raw.githubusercontent.com/gabrielfernando01/tutorial_PostgreSQL/main/images/inner_join.png)

```
SELECT city, temp_lo, temp_hi, prcp, date, location
  FROM weather JOIN cities ON city = name;
```

If there were duplicate column names in the two tables you'd need to _qualify_ the column names to show which one you meant, as in:

```
SELECT weather.city, weather.temp_lo, weather.temp_hi,
  weather.prcp, weather.date, cities.location
  FROM weather JOIN cities ON weather.city = cities.name;
```

Join queries of the kind seen thus far can also be written in this form 👇🏼:

```
SELECT * FROM weather, cities
  WHERE city = name;
```

Now we will figure out how we can get the Hayward records back in. What we want the query to do is to scan the <code>weather</code> table and for each row to find the matching <code>cities</code> row(s). If no matching row is found we want some "empty values" to be substituted for the <code>cities</code> tables's column. This kind of query is called an _outer join_. (The joins we have seen so far are _inner joins_.) The command look like this:

```
SELECT * FROM weather LEFT OUTER JOIN cities ON weather.city = cities.name;
```

This query is called a **LEFT OUTER JOIN** because the table mentioned on the left of the join operator will have each of its rows in the output at least once, whereas the table on the right will only have those rows output that match some row of the left table. When outputting a left-table row for which there is no right-table match, empty (null) values are substituted for the right-table columns.

Let's see the query below 👇🏼:

![](https://raw.githubusercontent.com/gabrielfernando01/tutorial_PostgreSQL/main/images/left_outer_join.png)

In the case of **RIGHT OUTER JOIN** the aspect is the follow 👇🏼:

```
SELECT * FROM weather RIGHT OUTER JOIN cities ON weather.city = cities.name
```

![](https://raw.githubusercontent.com/gabrielfernando01/tutorial_PostgreSQL/main/images/right_outer_join.png)

In the case of **FULL OUTER JOIN** make this👇🏼:

```
SELECT * FROM weather FULL OUTER JOIN cities ON weather.city = cities.name
```

![](https://raw.githubusercontent.com/gabrielfernando01/tutorial_PostgreSQL/main/images/full_outer_join.png)

If we want to query a table with respect to itself, let's say query what the temperature range of each city is for the weather table, we can write the following:

```
SELECT w1.city, w1.temp_lo AS low, w1.temp_hi AS high, w2.city, w2.temp_lo AS low,  
  w2.temp_hi AS high FROM weather w1 JOIN weather w2 ON w1.temp_lo < w2.temp_lo AND  
  w1.temp_hi > w2.temp_hi;
```

![](https://raw.githubusercontent.com/gabrielfernando01/tutorial_PostgreSQL/main/images/self_join.png)

Here we have relabeled the weather table as w1 and w2 to be able to distinguish the left and right side
of the join. You can also use these kinds of aliases in other queries to save some typing, e.g.:

```
SELECT * FROM weather w JOIN cities c ON w.city = c.name;
```

You will encounter this 👆🏼 style of abbreviating quite frequently.

**2.7 Aggregate Function**

Like most other relational database products, PostgreSQL supports aggregate functions. An aggregate function computes a single result from multiple input rows. For example, there are aggregates to compute the count, sum, avg (average), max (maximum) and min (minimum) over a set of rows.

As an example, we can find the highest low-temperature reading anywhere with:

```
SELECT max(temp_lo) FROM weather;
```

Also if we wish know what cities have this register (max(tem_lo), we have typing:

```
SELECT city FROM weather
  WHERE temp_lo = (SELECT max(temp_lo) FROM weather);
```

Aggregates are also very useful in combination with GROUP BY clauses. For example, we can get the number of readings and the maximum low temperature observed in each city with:

```
SELECT city, count(*),  max(temp_lo)
  FROM weather
  GROUP BY city;
```

![](https://raw.githubusercontent.com/gabrielfernando01/tutorial_PostgreSQL/main/images/agg_comb_groupby.png)

which gives us one output row per city. Each aggregate result is computed over the table rows matching that city. We can filter these grouped rows using HAVING:

```
SELECT city, count(*), max(temp_lo)
  FROM weather
  GROUP BY city
  HAVING max(temp_lo) < 40;
```

![](https://raw.githubusercontent.com/gabrielfernando01/tutorial_PostgreSQL/main/images/agg_having.png)

