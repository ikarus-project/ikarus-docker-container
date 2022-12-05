This repository contains the commands to create and push the docker image for the creation of docker container to execute [Ikarus](https://ikarusrepo.github.io/)

`docker build --squash -t rath3t/ikarus-dev:latest . &> build.log`
`docker build --squash -t rath3t/ikarus:latest . &> build.log`
`docker push rath3t/ikarus-debian-bookworm:latest`

Rename image tag

`docker commit [CONTAINER_ID]  [REPOSITORY]/[TAG]`


To create an Ikarus container where a specific branch of Ikarus is installed you can use

`docker build --build-arg branch=<branch-name> --squash -t ikarus/<branch-name-must-be-lowercase> . &> build.log`
