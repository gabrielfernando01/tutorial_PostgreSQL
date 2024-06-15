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