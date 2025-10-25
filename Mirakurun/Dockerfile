FROM chinachu/mirakurun

RUN apt-get update && apt-get install -y --no-install-recommends \
    wget \
    && rm -rf /var/lib/apt/lists/*

RUN wget https://github.com/kazuki0824/recisdb-rs/releases/download/1.2.3/recisdb_1.2.3-1_amd64.deb 
RUN apt install ./recisdb_1.2.3-1_amd64.deb
RUN rm ./recisdb_1.2.3-1_amd64.deb

WORKDIR /app