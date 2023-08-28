# Turbo-umbrella

The configuration makes it easy to deploy a docker host that includes monitoring tools, https settings, and portainer for better manageability.

![turbo-umprella docker diagram](/diagram.png)

This is perfect for a personal server, lab or small project.

- cloudflare cdn connection
- traefik + metriks + logs
- ip white list wich uses X-Forwarded-For labels
- configured grafana with dashboards for cadvisor, traefik, node-exporter and loki
- scripts for setup, updating grafana dashboards and docker cleaning
- pritunlVpn for secure connection

#### Pre-requisites

- Docker
- Сonfigured firewall
- Сonfigured user policy
- Domain name and cloudflare account

## Discription

**Portainer** folder for container managment and security:

- [Traefik](https://github.com/traefik/traefik)
- [Portainer](https://github.com/portainer/portainer)
- [Pritunl VPN](https://docs.pritunl.com/docs)

**Monitoring** folder:

- [Prometheus](https://prometheus.io/docs/introduction/overview/)
- [Grafana](https://grafana.com/docs/grafana/latest/)
- [Node Exporter](https://github.com/prometheus/node_exporter)
- [Alert Manager](https://prometheus.io/docs/alerting/latest/configuration/)
- [Cadvisor](https://github.com/google/cadvisor)
- [Loki](https://grafana.com/docs/loki/latest/)
- [Promtail](https://grafana.com/docs/loki/latest/clients/promtail/)

### Network

List of open ports:

| Port   | Protocol | Description    |
| ------ | -------- | -------------- |
| :443   | tcp      | Traefik        |
| :80    | tcp      | Traefik        |
| :16285 | udp      | OpenVpn server |

### List of portainer/.env variables:

| Name           | Description                                                                                                                |
| -------------- | -------------------------------------------------------------------------------------------------------------------------- |
| ACME_EMAIL     | email for traefic certificates resolvers                                                                                   |
| CF_API_KEY     | [cloudflare api key](https://developers.cloudflare.com/analytics/graphql-api/getting-started/authentication/api-key-auth/) |
| CF_API_EMAIL   | cloudflare api email                                                                                                       |
| DOMAIN         | main domain                                                                                                                |
| SUB_PORTAINER  | subdomain for portainer                                                                                                    |
| SUB_PRITUNL    | subdomain for pritunl VPN                                                                                                  |
| IP_WHITE_LIST  | ip for secure access to internal services (grafana, vpn panel and traefik)                                                 |
| LOCAL_IPS      | local ips list                                                                                                             |
| CLOUDFLARE_IPS | [cloudflare ip ranges](https://www.cloudflare.com/ips/)                                                                    |
| TZ             | time zone                                                                                                                  |

### List of monitoring/.env variables:

| Name                            | Description                        |
| ------------------------------- | ---------------------------------- |
| DOMAIN                          | main domain                        |
| SUB_PROMETHEUS                  | subdomain for prometheus           |
| SUB_GRAFANA                     | subdomain for grafana              |
| GRAFANA_SECURITY_ADMIN_PASSWORD | default admin password for grafana |
| TZ                              | time zone                          |

## Setup portainer stack

```
git clone git@github.com:fulv0us/turbo-umbrella.git
cd turbo-umbrella
chmod +x scripts/*
./scripts/setup.sh

cd portainer/
nano .env #configure the necessary parameters

# generate .htpasswd for access to traefik dashboard
# replace username and mystrongpassword
echo $(htpasswd -nb username mystrongpassword) | sed -e s/\$/\$\$/g > traefik/.htpasswd

docker-compose up -d
```

## Setup monitoring stack

```
cd ../monitoring
cp .env_example cp .env
nano .env #configure the necessary parameters
docker-compose up -d

```

### Useful Resources

- https://doc.traefik.io/traefik/
- https://www.smarthomebeginner.com/traefik-docker-compose-guide-2022/
- https://hub.docker.com/r/crowdsecurity/crowdsec
