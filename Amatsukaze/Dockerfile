FROM ubuntu:22.04 AS builder

RUN apt-get update && apt-get install -y \
    wget \
    && rm -rf /var/lib/apt/lists/* \
    && apt-get clean \
    && apt-get autoremove -y

COPY ./Amatsukaze /app
COPY ./entrypoint.sh /app/docker/entrypoint.sh

WORKDIR /app/docker/

RUN /bin/bash ./setup.sh > /dev/null

ENTRYPOINT ["/bin/bash", "/app/docker/entrypoint.sh"]