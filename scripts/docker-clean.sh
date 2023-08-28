#!/bin/bash

docker container prune -f # Delete all stopped containers
docker image prune -f # Remove unused images
docker volume prune -f # Remove all unused volumes