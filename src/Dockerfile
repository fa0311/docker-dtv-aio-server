FROM ubuntu:22.04

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

# pipとpoetryのインストール
RUN python3 -m pip install --upgrade pip setuptools wheel && \
    python3 -m pip install poetry==1.8.0

# recisdbのインストール（x86_64版）
RUN wget https://github.com/kazuki0824/recisdb-rs/releases/download/1.2.3/recisdb_1.2.3-1_amd64.deb && \
    apt-get update && \
    apt-get install -y ./recisdb_1.2.3-1_amd64.deb && \
    rm recisdb_1.2.3-1_amd64.deb && \
    rm -rf /var/lib/apt/lists/*

# 作業ディレクトリの設定
WORKDIR /app/ISDBScanner

# poetryの設定（仮想環境を作成しない）
ENV POETRY_VIRTUALENVS_CREATE=false

# プロジェクトファイルのコピー
COPY ISDBScanner/ISDBScanner/pyproject.toml ISDBScanner/ISDBScanner/poetry.lock ISDBScanner/ISDBScanner/poetry.toml ./

# 依存関係のインストール
RUN poetry install --no-root --only main

# アプリケーションコードのコピー
COPY ISDBScanner/ISDBScanner/isdb_scanner ./isdb_scanner
COPY ISDBScanner/ISDBScanner/Readme.md ISDBScanner/ISDBScanner/License.txt ./

# poetryでプロジェクトをインストール
RUN poetry build
RUN pip install dist/*.whl

# 作業ディレクトリの設定
WORKDIR /app

# コピー
COPY ConfigSetup ./ConfigSetup
COPY Amatsukaze/Amatsukaze ./Amatsukaze
COPY ConfigSetup/main.py ./main.py

ENTRYPOINT ["/bin/bash", "/app/ConfigSetup/entrypoint.sh"]
