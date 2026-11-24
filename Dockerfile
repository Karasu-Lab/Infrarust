FROM alpine:3 AS render
ARG MC_DOMAIN
ARG MC_BACKEND_ADDRESS
ARG MC_AUTH_DOMAIN
ARG MC_AUTH_BACKEND_ADDRESS
RUN test -n "$MC_DOMAIN" && test -n "$MC_BACKEND_ADDRESS" && test -n "$MC_AUTH_DOMAIN" && test -n "$MC_AUTH_BACKEND_ADDRESS"
COPY config /config
RUN sed -i -e "s|@MC_DOMAIN@|${MC_DOMAIN}|g" -e "s|@MC_BACKEND_ADDRESS@|${MC_BACKEND_ADDRESS}|g" /config/servers/mc.toml \
 && sed -i -e "s|@MC_AUTH_DOMAIN@|${MC_AUTH_DOMAIN}|g" -e "s|@MC_AUTH_BACKEND_ADDRESS@|${MC_AUTH_BACKEND_ADDRESS}|g" /config/servers/mc-auth.toml

FROM ghcr.io/shadowner/infrarust:latest
COPY --from=render /config /app/config
EXPOSE 25565
