#!/usr/bin/env bash
set -euo pipefail
echo "Starting app ..."

# (Re)create PostgreSQL container with persistent volume
docker rm -f my-postgres >/dev/null 2>&1 || true
docker run -d       --name my-postgres       --network myapp-net       --restart=on-failure:5       -e POSTGRES_USER=admin       -e POSTGRES_PASSWORD=admin123       -e POSTGRES_DB=mydb       -v myapp-db:/var/lib/postgresql/data       postgres:15

echo "Waiting for PostgreSQL to be ready ..."
# Wait for Postgres to accept connections
for i in {1..30}; do
  if docker exec my-postgres pg_isready -U admin -d mydb -h 127.0.0.1 >/dev/null 2>&1; then
    echo "PostgreSQL is ready."
    break
  fi
  sleep 2
  if [ "$i" -eq 30 ]; then
    echo "PostgreSQL did not become ready in time." >&2
    exit 1
  fi
done

# (Re)create Flask web container
docker rm -f my-flask >/dev/null 2>&1 || true
docker run -d       --name my-flask       --network myapp-net       --restart=on-failure:5       -p 5000:5000       -e DB_HOST=my-postgres       -e DB_USER=admin       -e DB_PASSWORD=admin123       -e DB_NAME=mydb       my-flask-app

echo "The app is available at http://localhost:5000"
