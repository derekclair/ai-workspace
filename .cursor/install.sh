#!/usr/bin/env bash
# Idempotent development environment setup for the AI Workspace / RiskEngine.
#
# Runs once to build the baseline environment:
#   - system packages (Python venv tooling + PostgreSQL)
#   - Python virtual environment with dev dependencies (pytest)
#   - a local PostgreSQL "ai-workspace" database seeded from dev/init/seed.sql
#     (mirrors dev/docker-compose.yml, using a native cluster instead of Docker)
set -euo pipefail

REPO_ROOT="$(cd "$(dirname "${BASH_SOURCE[0]}")/.." && pwd)"
cd "$REPO_ROOT"

echo "==> Installing system packages (python venv + PostgreSQL)"
export DEBIAN_FRONTEND=noninteractive
sudo apt-get update -qq
sudo apt-get install -y -qq python3-venv python3-pip postgresql postgresql-client

echo "==> Creating Python virtual environment (.venv)"
if [ ! -x .venv/bin/python ]; then
	python3 -m venv .venv
fi
# shellcheck disable=SC1091
. .venv/bin/activate
python -m pip install --quiet --upgrade pip
python -m pip install --quiet -r requirements-dev.txt

PG_VER="$(pg_lsclusters -h | awk 'NR==1{print $1}')"
PG_CLUSTER="$(pg_lsclusters -h | awk 'NR==1{print $2}')"
HBA="/etc/postgresql/${PG_VER}/${PG_CLUSTER}/pg_hba.conf"

echo "==> Configuring PostgreSQL trust auth over local TCP (matches docker-compose)"
sudo sed -i -E 's#^(host[[:space:]]+all[[:space:]]+all[[:space:]]+127\.0\.0\.1/32[[:space:]]+)scram-sha-256#\1trust#' "$HBA"
sudo sed -i -E 's#^(host[[:space:]]+all[[:space:]]+all[[:space:]]+::1/128[[:space:]]+)scram-sha-256#\1trust#' "$HBA"

echo "==> Starting PostgreSQL cluster ${PG_VER}/${PG_CLUSTER}"
sudo pg_ctlcluster "$PG_VER" "$PG_CLUSTER" start || true
sudo pg_ctlcluster "$PG_VER" "$PG_CLUSTER" reload || true

echo "==> Creating and seeding the 'ai-workspace' database"
sudo -u postgres psql -tc "SELECT 1 FROM pg_database WHERE datname='ai-workspace'" | grep -q 1 \
	|| sudo -u postgres createdb "ai-workspace"
sudo -u postgres psql -c "ALTER USER postgres WITH PASSWORD 'postgres';" >/dev/null
sudo -u postgres psql -d "ai-workspace" -f dev/init/seed.sql

echo "==> Install complete"
