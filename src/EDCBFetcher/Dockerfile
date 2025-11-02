FROM ubuntu:22.04

# タイムゾーンの設定（対話を避けるため）
ENV DEBIAN_FRONTEND=noninteractive
ENV TZ=Asia/Tokyo

# 基本パッケージとPython 3.11のインストール
RUN apt-get update && \
    apt-get install -y \
    software-properties-common \
    wget \
    curl \
    ca-certificates \
    && add-apt-repository ppa:deadsnakes/ppa \
    && apt-get update \
    && apt-get install -y \
    python3.11 \
    python3.11-dev \
    python3.11-venv \
    python3-pip \
    && update-alternatives --install /usr/bin/python3 python3 /usr/bin/python3.11 1 \
    && rm -rf /var/lib/apt/lists/*


RUN python3 -m pip install --upgrade pip setuptools wheel

# 作業ディレクトリの設定
WORKDIR /app/EDCBFetcher

# プロジェクトファイルのコピー
COPY EDCBFetcher/pyproject.toml ./

# アプリケーションコードのコピー
COPY EDCBFetcher/edcb_fetcher ./edcb_fetcher
COPY EDCBFetcher/README.md ./

# インストール
RUN python3 -m pip install ./

WORKDIR /app

ENTRYPOINT ["python3", "-m", "edcb_fetcher"]
