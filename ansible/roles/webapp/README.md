Deploys the web application stack via Docker Compose, managed by systemd.

The stack (`docker-compose.yml`) is three services:

- **database** — Postgres. Data lives in the `pgdata` named volume. The port is
  not published, so it is only reachable by the other containers on the compose
  network. `01-init.sql` creates the app database and user on first init.
- **flyway** — runs the DB migrations, then exits. Connects as the app user so
  migrated objects are owned by it.
- **webapp** — the application, published on `127.0.0.1:8080` for nginx to proxy.

## Operations

- The `webapp.service` systemd unit runs `docker compose up -d` / `down` for the
  whole stack on boot/shutdown.
- Ansible config changes reconcile the stack with `docker compose up -d` (see the
  `Reload_webapp` handler), which recreates only the changed services — it does
  **not** bounce the database.
- CICD deploys run `deploy-webapp.sh` (as the `webapp` user, via a scoped sudoers
  rule for the `deploy` user), which pulls and recreates only flyway + webapp.

## Logs

Containers log via the journald driver with a `docker/<name>` tag. The `journald`
and rsyslog rules route these to `/var/log/docker/<name>.log`, which nginx serves
(basic-auth) at `/logs/`.
