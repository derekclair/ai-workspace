#!/usr/bin/env bash
# Per-boot startup: ensure PostgreSQL is running and the dev database is seeded.
# Safe to run repeatedly; reaches readiness and then returns.
set -euo pipefail

REPO_ROOT="$(cd "$(dirname "${BASH_SOURCE[0]}")/.." && pwd)"
cd "$REPO_ROOT"

PG_VER="$(pg_lsclusters -h | awk 'NR==1{print $1}')"
PG_CLUSTER="$(pg_lsclusters -h | awk 'NR==1{print $2}')"

echo "==> Starting PostgreSQL cluster ${PG_VER}/${PG_CLUSTER}"
sudo pg_ctlcluster "$PG_VER" "$PG_CLUSTER" start || true

echo "==> Waiting for PostgreSQL to accept connections"
for _ in $(seq 1 30); do
	if pg_isready -h 127.0.0.1 -p 5432 -q; then
		break
	fi
	sleep 1
done
pg_isready -h 127.0.0.1 -p 5432

echo "==> Ensuring 'ai-workspace' database exists and is seeded"
sudo -u postgres psql -tc "SELECT 1 FROM pg_database WHERE datname='ai-workspace'" | grep -q 1 \
	|| sudo -u postgres createdb "ai-workspace"
sudo -u postgres psql -d "ai-workspace" -f dev/init/seed.sql >/dev/null

echo "==> PostgreSQL ready on 127.0.0.1:5432 (db: ai-workspace)"
