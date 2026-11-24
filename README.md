# Infrarust

Infrarust reverse proxy deployed on the Coolify host.

Each configured domain is forwarded to a Minecraft server over the Cloudflare One
virtual network. While a server is not reachable, the proxy answers with the
maintenance MOTD and rejects logins with the maintenance message. While it is
reachable, the MOTD is the one reported by the server.

| Server | Domain | Backend port |
| --- | --- | --- |
| main | `MC_DOMAIN` | 25565 |
| auth | `MC_AUTH_DOMAIN` | 25566 |

## Deploy on Coolify

- Build pack: Dockerfile
- Build arguments:
  - `MC_DOMAIN` — domain players connect to for the main server
  - `MC_BACKEND_ADDRESS` — `<virtual network IP>:25565` of the machine running the main server
  - `MC_AUTH_DOMAIN` — domain players connect to for the auth server
  - `MC_AUTH_BACKEND_ADDRESS` — `<virtual network IP>:25566` of the machine running the auth server
- Port mapping: `25565:25565`

## Layout

- `config/infrarust.toml` — global settings
- `config/servers/mc.toml` — routing and maintenance messages for the main server
- `config/servers/mc-auth.toml` — routing and maintenance messages for the auth server
