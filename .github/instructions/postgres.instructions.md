---
description: "PostgreSQL MCP Server usage and setup"
applyTo: '**/*.sql'
---

# PostgreSQL MCP Server

This instruction file documents how to configure and use the PostgreSQL MCP server in this workspace. It provides setup steps, recommended security practices, and example usage for local development and CI.

## MCP server configuration

Add the following entry to `.vscode/mcp.json` (example). Note the DB name is `ai-workspace` in this repo:

```json
"inputs": [
  ...
  {
    "type": "promptString",
    "id": "db-url",
    "description": "Database connection URL",
    "password": true
  }
],
"servers": {
  ...
  "postgres": {
    "type": "stdio",
    "command": "npx",
    "args": ["-y", "@modelcontextprotocol/server-postgres"],
    "env": {
      "DATABASE_URL": "${input:db-url}"
    }
  }
}
```

Notes:
- The third argument is the default connection string the server will use. Override it with environment variables if needed.
- Do not commit real passwords or production connection strings into the repository.

## Local development setup

Recommended approach: run a local PostgreSQL container for development and testing.

We provide a reproducible development compose stack under `dev/docker-compose.yml` which will initialize a Postgres 15.4 container and run initialization scripts located in `dev/init/`.

Usage (exact commands used in this repo):

```bash
# Start the local compose stack (detached)
docker compose -f dev/docker-compose.yml up -d

# Tail logs for the postgres service
docker compose -f dev/docker-compose.yml logs -f postgres

# Verify seeded data (run inside the container)
docker exec -i ai-workspace-postgres psql -U postgres -d "ai-workspace" -c "SELECT count(*) FROM users;"

# Stop and remove the stack (preserves images by default)
docker compose -f dev/docker-compose.yml down
```

The `dev/init/seed.sql` file is executed automatically on first startup. It creates a `users` table and inserts a sample user.

Environment variables (to avoid committing secrets):
- POSTGRES_URL or DATABASE_URL — e.g. postgresql://postgres:example@localhost:5432/ai-workspace

Load these into your shell when working locally, or use a `.env` file that is ignored by git.

## Security and best practices

- Never hardcode credentials or production connection strings in repo files.
- Use environment variables or secret managers (AWS Secrets Manager, SSM) in CI and production.
- Restrict network access to your DB instances (VPC, security groups).
- Use TLS for connections to production databases where available.
- For ephemeral local databases, use short-lived credentials and avoid exposing them publicly.

## Usage examples

- To inspect the database from the workspace terminal:

```bash
psql "$DATABASE_URL"
```

- To run database migrations locally, use your project's migration tooling (e.g., `migrate`, `sqitch`, `diesel`, `alembic`) and point it to `$DATABASE_URL`.

## Integration with tests and CI

- Use a test container or managed test database for CI jobs.
- Seed minimal test data during CI setup, and tear down after tests run.
- Use CI secrets to store DB credentials; never print secrets in CI logs.

## Troubleshooting

- If the MCP server fails to connect, verify the connection string and that the Postgres instance is reachable on the configured host/port.
- Confirm `psql` or your DB client can connect using the same credentials.
- Check container logs: `docker logs ai-workspace-postgres`.

## Maintenance

- Keep the Postgres Docker image version pinned in local dev scripts (e.g., postgres:15.4).
- Periodically rotate local and CI credentials and update documentation.

