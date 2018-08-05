# Docker file for cardano sl with aphine
**Based on [cardano-sl-alpine](https://github.com/sharkspeed/cardano-sl-alpine)**

## Prerequisites
- Docker
  - [windows](https://docs.docker.com/docker-for-windows/install/)
  - [mac](https://docs.docker.com/docker-for-mac/install/)
- [Docker Compose](https://docs.docker.com/compose/install/#install-compose)

## Build docker image (optional - not required to run the node)
```bash
git clone git@github.com:gvsmraju/cardano-sl-docker.git
cd cardano-sl-docker
docker build . -t cardano:1.2.1
```

## Start cardano explorer
```bash
# for windows use docker-compose.exe instead of docker-compose
docker-compose -f ./docker-compose.yml up -d
```
## Stop and remove all images
```bash
# for windows use docker-compose.exe instead of docker-compose
docker-compose -f ./docker-compose.yml down
```

## Stop cardano explorer (will retain the blockchain data for windows)
```bash
# for windows use docker-compose.exe instead of docker-compose
docker-compose -f ./docker-compose.yml stop
```

## Cardano explorer api
- API Documentation [here](https://cardanodocs.com/technical/explorer/api/)
- Base url `http://localhost:8100/`

## Known issues
- Volume mounting will not work with [docker for windows](https://github.com/docker/docker.github.io/blob/master/docker-for-windows/troubleshoot.md#permissions-errors-on-data-directories-for-shared-volumes)
