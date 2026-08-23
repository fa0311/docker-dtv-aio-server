# AmatsukazeAddTaskを取得ステージ
FROM alpine:3.20 AS fetch

RUN apk add --no-cache ca-certificates curl jq xz tar

ENV UBUNTU_VERSION=24.04
WORKDIR /work

RUN curl -fsSL https://api.github.com/repos/rigaya/Amatsukaze/releases/latest \
    | jq -r '.assets[].browser_download_url' \
    | grep "Ubuntu${UBUNTU_VERSION}.*tar.xz" \
    | head -n1 > url.txt

RUN set -eux; \
    URL="$(cat url.txt)"; \
    test -n "$URL"; \
    curl -fSL "$URL" -o amatsukaze.tar.xz

RUN mkdir -p /out \
    && xz -dc amatsukaze.tar.xz | tar -x -C /out


FROM ubuntu:24.04

RUN apt-get update \
    && apt-get install -y --no-install-recommends \
    ca-certificates \
    curl \
    libicu74 \
    tzdata \
    && rm -rf /var/lib/apt/lists/*

COPY --from=fetch /out/exe_files/AmatsukazeAddTask /usr/local/bin/AmatsukazeAddTask
RUN chmod +x /usr/local/bin/AmatsukazeAddTask

WORKDIR /app
COPY entrypoint.sh /app/entrypoint.sh
RUN chmod +x /app/entrypoint.sh

ENTRYPOINT ["/app/entrypoint.sh"]