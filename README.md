# Infrarust

Infrarust reverse proxy deployed on the Coolify host by GitHub Actions.

The main domain is forwarded to a Minecraft server over the Cloudflare One virtual
network. While that server is not reachable, the proxy answers with the maintenance
MOTD and rejects logins with the maintenance message. While it is reachable, the
MOTD is the one reported by the server. The auth domain is forwarded to the mc-auth
gateway on the Coolify host, which listens on port 25566.

| Server | Domain | Backend |
| --- | --- | --- |
| main | `MC_DOMAIN` | `MC_BACKEND_ADDRESS` (port 25565 on the virtual network) |
| auth | `MC_AUTH_DOMAIN` | `MC_AUTH_BACKEND_ADDRESS` (port 25566 on the Coolify host) |

## Deploy

`.github/workflows/infrarust-deploy.yml` builds the image, pushes it to GHCR on
`main`, and triggers the Coolify application tagged `infrarust` through the Coolify API.

Repository variables (build arguments): `MC_DOMAIN`, `MC_BACKEND_ADDRESS`,
`MC_AUTH_DOMAIN`, `MC_AUTH_BACKEND_ADDRESS`, `COOLIFY_HOST`.

Secret in the `production` environment: `CI_DEPLOY_TOKEN`.

The Coolify application uses the Docker image `ghcr.io/<owner>/infrarust:latest`
with the port mapping `25565:25565`.

## Layout

- `config/infrarust.toml` — global settings
- `config/servers/mc.toml` — routing and maintenance messages for the main server
- `config/servers/mc-auth.toml` — routing and maintenance messages for the auth server
