#! /bin/bash
# Set up Postgres
TEMP_FILE=.postgres.sql
cat <<'EOF' > $TEMP_FILE
ALTER USER postgres WITH PASSWORD 'petclinic';
CREATE DATABASE petclinic WITH OWNER = postgres ENCODING = 'UTF8' CONNECTION LIMIT = -1;
EOF
sudo -u postgres psql -f $TEMP_FILE
rm $TEMP_FILE