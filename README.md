![](https://raw.githubusercontent.com/gabrielfernando01/tutorial_PostgreSQL/main/images/cover.png)

# Tutorial PostgreSQL

### What is PostgreSQL?

PostgreSQL is an object-relational database management system (ORDBMS) based on POSTGRES, Version 4.2, developed at the University of California at Berkeley Computer Science Departament. POSTGRES pioneered many concepts that only became avaible in some commercial database system much later.

PostgreSQL is an open-source descendant of this original Berkeley code. It support a large part of the SQL standard and offers many modern features:

- complex queries
- foreign keys
- triggers
- updatable views
- transactional integrity
- multiversion concurrency control

Also, PostgreSQL can be extended by the user in many ways, for example by adding new

- data types
- functions
- operators
- aggregate functions
- index methods
- procedural languages

And because of the liberal license, PostgreSQL can be used, modifed, and distributed by anyone free of charge for any purpose, be it private, commercial, or academic.

## Part I. Tutorial

### Chapter 1. Getting Started

**1.1 Installation**

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
$ systemclt status postgresql

# Show version of PostgreSQL
$ sudo -u postgres psql -c "SELECT version();"
```

**1.2 Architecture Fundamentals**

Before we proceed, you should understand the basic PostgreSQL system architecture. Understandig how the parts of PostgreSQL, interact will make this chapter somewhat clearer.

In database jargon, PostgreSQL, use a client/server model. A PostgreSQL session consists of the following cooperating processes (programs):

- A server process, which manages the database files, accepts connections to the database from client application, and performs database actions on behalf of clients. The database server program is called <code>postgres</code>.

- The user's client (frontend) application that wants to perform database operation. Client applications can be very diverse in nature: a client could be a text-oriented tool, a graphical application, a web server that accesses the database to display web pages, or a specialized database maintenance tool. Some client application are supplied with the PostgreSQL distrubution; most are developed by users.