# the base image - Debian/jessie with Java8
FROM java:8 

RUN apt-get update && apt-get upgrade -y && \
	apt-get install -y wget && \
	apt-get -y install supervisor && \
	mkdir -p /var/log/supervisor

WORKDIR /

RUN wget "http://orientdb.com/download.php?email=unknown@unknown.com&file=orientdb-community-2.1.5.tar.gz&os=linux" -O orientdb-community-2.1.5.tar.gz &&\
    tar -zxvf orientdb-community-2.1.5.tar.gz && \
    mv orientdb-community-2.1.5 orientdb && \
    rm -rf orientdb-community-2.1.5.tar.gz && \
    mkdir -p /orientdb/backup

# RUN rm -rf /var/lib/apt/lists/*

VOLUME ["/orientdb/backup", "/orientdb/databases", "/orientdb/config"]

EXPOSE 2424 2480 

WORKDIR /orientdb

# Supervisor Configuration
ADD supervisord.conf /etc/supervisor/conf.d/supervisord.conf
ADD orientdb-server-config.xml /orientdb/config/orientdb-server-config.xml

# Set the user to run OrientDB daemon
USER root

# Default command when starting the container
CMD ["/usr/bin/supervisord", "-c", "/etc/supervisor/conf.d/supervisord.conf"]
