#!/bin/bash

# Wait until PostgreSQL is ready
until pg_isready -h db -p 5432 -U root -d mydb
do
  echo "Waiting for PostgreSQL to start..."
  sleep 1
done

# Check if the database exists
if psql -h db -U root -lqt | cut -d \| -f 1 | grep -qw mydb; then
  echo "Database 'mydb' already exists. Skipping creation."
else
  # Create the database
  psql -h db -U root -c "CREATE DATABASE mydb;"
  echo "Database 'mydb' created."
fi
