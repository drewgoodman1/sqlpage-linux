 ## Disc Golf Bag and flight chart using SQL Page🥏🥏🥏


This repository provides everything you need to run SQLPage locally, including a Docker configuration for PostgreSQL and pgAdmin, environment-based configuration for sensitive data, and automatic database migrations.

## 1. Set Up Environment Variables

Create a file named `.env` in the project root (next to `docker-compose.yml` and with your own credentials) with the following content:

~~~bash
POSTGRES_USER=kirkgibson
POSTGRES_PASSWORD=dodgers
PGADMIN_DEFAULT_EMAIL=vinscully@greatest.com
PGADMIN_DEFAULT_PASSWORD=homerun
DATABASE_URL=postgres://kirkgibson:dodgers@localhost:5432/postgres
~~~

> **Important:** Add `.env` to your `.gitignore` so that these sensitive credentials are not committed.

Before running Docker, load the environment variables into your shell by running:

~~~bash
set -o allexport; source .env; set +o allexport
~~~

## 2. Docker Setup for PostgreSQL and pgAdmin

The repository includes a `docker-compose.yml` configuration file.

### Starting the Docker Containers

From the project root (where your `docker-compose.yml` is located), run:

~~~bash
docker-compose up -d
~~~

Verify the containers are running with:

~~~bash
docker-compose ps
~~~

### Access pgAdmin

Open your browser and go to [http://localhost:5050](http://localhost:5050). Log in using the credentials from your `.env` file:

- **Email:** `vinscully@greatest.com`
- **Password:** `homerun`

## 3. SQLPage Configuration and Running Migrations

SQLPage uses a configuration file (`sqlpage.json`) to connect to your database.

Make sure `sqlpage.json` is in the repository root with the following content:

~~~json
{
  "database_url": "postgres://${POSTGRES_USER}:${POSTGRES_PASSWORD}@localhost:5432/postgres"
}

*** I'm not exactly sure how SQL page is using this file - we are currently using the .env variable DATABASE_URL when SQL Page launches
~~~

### Running SQLPage

Ensure the SQLPage binary is executable:

~~~bash
chmod +x sqlpage.bin
~~~

Then start SQLPage by running:

~~~bash
./sqlpage.bin
~~~

SQLPage will load environment variables from your `.env` file, read the configuration from `sqlpage.json`, and automatically scan the `sqlpage/migrations` directory for migration files. Any new migrations will be applied at startup.

Once SQLPage starts, it will print a message with the URL (by default, [http://localhost:8080](http://localhost:8080)) where you can view your site.

---

By following these steps, you'll have a complete local development environment for SQLPage with PostgreSQL and pgAdmin managed via Docker, secure configuration through a `.env` file, and automatic migration management.


