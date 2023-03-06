This repository contains the commands to create and push the docker image for the creation of docker container to execute [Ikarus](https://ikarus-project.github.io/)

`docker build --squash -t ikarusproject/ikarus-dev:latest . &> build.log`
`docker build --squash -t ikarusproject/ikarus:latest . &> build.log`

Rename image tag

`docker commit [CONTAINER_ID]  [REPOSITORY]/[TAG]`


To create an Ikarus container where a specific branch of Ikarus is installed you can use

`docker build --build-arg branch=<branch-name> --squash -t ikarusproject/<branch-name-must-be-lowercase> . &> build.log`

inside the InstalledContainer directory.



docker build --build-arg UID=$(id -u) --squash -t rath3t/ikarus-dev:latest . &> build.log

docker build --build-arg UID=$(id -u) --build-arg branch=pythonBindings --squash -t rath3t/ikarus-dev:pythonBindings .
docker build --build-arg UID=$(id -u) --build-arg branch=pythonBindings --squash -t rath3t/ikarus:pythonBindings .

docker build --squash -t rath3t/ikarus-dev:pythonBindings . &> build.log