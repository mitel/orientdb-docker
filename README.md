# orientdb-docker
A Dockerfile to build the latest OrientDB image

Build the image:
docker build -t mitel/orientdb .

Start a container:
docker run -d --name="orientdb" -p 2424:2424 -p 2480:2480 mitel/orientdb

Bash inside the container:
docker exec -it orientdb bash

..and run the OrientDB console.sh:
/orientdb/bin/console.sh

root password: password
