#!/bin/bash

touch portainer/logs/access.log
touch portainer/logs/traefik.log
touch portainer/logs/pritunl.log
touch portainer/traefik/acme.json #create acme file
chmod 600 portainer/traefik/acme.json
cp .env_example cp .env