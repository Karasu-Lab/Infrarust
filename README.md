# Infrarust

Infrarust reverse proxy deployed on the Coolify host.

The configured domain is forwarded to a Minecraft server over the Cloudflare One
virtual network. While that server is not reachable, the proxy answers with the
maintenance MOTD and rejects logins with the maintenance message. While it is
reachable, the MOTD is the one reported by the server.

## Deploy on Coolify

- Build pack: Dockerfile
- Build arguments:
  - `MC_DOMAIN` — domain players connect to
  - `MC_BACKEND_ADDRESS` — `<virtual network IP>:25565` of the machine running the server
- Port mapping: `25565:25565`

## Layout

- `config/infrarust.toml` — global settings
- `config/servers/mc.toml` — routing and maintenance messages
