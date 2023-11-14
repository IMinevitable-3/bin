#!/bin/bash

# Wait until PostgreSQL is ready
until pg_isready -h localhost -p 5432 -U $POSTGRES_USER -d $POSTGRES_DB
do
  echo "Waiting for PostgreSQL to start..."
  sleep 1
done

# Check if the database exists
if psql -h localhost -U $POSTGRES_USER -lqt | cut -d \| -f 1 | grep -qw $POSTGRES_DB; then
  echo "Database '$POSTGRES_DB' already exists. Skipping creation."
else
  # Create the database
  psql -h localhost -U $POSTGRES_USER -c "CREATE DATABASE $POSTGRES_DB;"
  echo "Database '$POSTGRES_DB' created."
fi
