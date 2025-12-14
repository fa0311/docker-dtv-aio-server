FROM alpine:3.20
RUN apk add --no-cache openssl
WORKDIR /certs
COPY san.cnf .
COPY gen-cert.sh /usr/local/bin/gen-cert.sh
RUN chmod +x /usr/local/bin/gen-cert.sh
ENTRYPOINT ["gen-cert.sh"]
