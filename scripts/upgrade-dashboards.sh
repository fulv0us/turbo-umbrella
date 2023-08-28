#!/bin/bash

# node-exporter
curl https://grafana.com/api/dashboards/1860/revisions/`curl -s 'https://grafana.com/api/dashboards/1860' | jq -r '.revision'`/download  | sed --expression='s/${DS_PROMETHEUS}/Prometheus/g' > monitoring/grafana/provisioning/dashboards/node.json

# traefik
curl https://grafana.com/api/dashboards/13713/revisions/`curl -s 'https://grafana.com/api/dashboards/13713' | jq -r '.revision'`/download | sed --expression='s/${DS_LOKI}/Loki/g' | sed --expression='s/\/var\/log\/traefik.log/traefik_access/g' > monitoring/grafana/provisioning/dashboards/traefik-via-loki.json
curl https://grafana.com/api/dashboards/4475/revisions/`curl -s 'https://grafana.com/api/dashboards/4475' | jq -r '.revision'`/download | sed --expression='s/${DS_PROMETHEUS}/Prometheus/g' > monitoring/grafana/provisioning/dashboards/traefik.json

# loki
curl https://grafana.com/api/dashboards/13639/revisions/`curl -s 'https://grafana.com/api/dashboards/13639' | jq -r '.revision'`/download | sed --expression='s/${DS_LOKI}/Loki/g' > monitoring/grafana/provisioning/dashboards/loki-logs.json

#cadvisor
curl https://grafana.com/api/dashboards/10619/revisions/`curl -s 'https://grafana.com/api/dashboards/10619' | jq -r '.revision'`/download | sed --expression='s/${DS_PROMETHEUS}/Prometheus/g' > monitoring/grafana/provisioning/dashboards/docker-cadvisor.json

#SSH logs
curl https://grafana.com/api/dashboards/17514/revisions/`curl -s 'https://grafana.com/api/dashboards/17514' | jq -r '.revision'`/download | sed --expression='s/${DS_LOKI}/Loki/g' > monitoring/grafana/provisioning/dashboards/ssh-logs.json