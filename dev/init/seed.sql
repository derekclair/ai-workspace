-- Init script that runs on first container startup

CREATE TABLE IF NOT EXISTS users (
  id serial PRIMARY KEY,
  name text NOT NULL,
  email text UNIQUE NOT NULL
);

INSERT INTO users (name, email) VALUES ('Alice','alice@example.com') ON CONFLICT DO NOTHING;
