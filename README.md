# Docker DTV AIO Server (WIP)

Docker を使用した日本のデジタルテレビ放送受信・録画・ストリーミングのオールインワンソリューションです。

## 概要

このプロジェクトは、複数の DTV 関連ソフトウェアを Docker コンテナで統合し、簡単にセットアップ・管理できる環境を提供します。

## セットアップ

ホストマシンの IP アドレスが `192.168.1.1` の場合の例を示します。

### 1. 前提条件

- Docker と Docker Compose がインストールされていることを確認してください。
- NVidia GPU を使用する場合、NVIDIA Container Toolkit がインストールされていることを確認してください。
- Intel GPU を使用する場合、Intel GPU ドライバがホストにインストールされていることを確認してください。
- TV チューナーがホストマシンに接続されていることを確認してください。
- TV チューナーに対応するドライバがホストマシンにインストールされていることを確認してください。
- カードリーダーがホストマシンに接続されていることを確認してください。

### 2. リポジトリのクローン

```bash
git clone --recursive https://github.com/fa0311/docker-dtv-aio-server.git
cd docker-dtv-aio-server
docker compose up -d --wait
```

初回起動はチャンネルスキャンを行うため時間がかかります。

### 3. 設定のカスタマイズ

- `docker-compose.yml` 内の環境変数を編集して、設定をカスタマイズできます。
- <http://192.168.70.3:5510/legacy/setting_bon.html> にアクセスして、ホストマシンに接続されている TV チューナーの設定を行います。

## アクセス方法

起動後、以下の URL でアクセスできます。

- **KonomiTV**: `https://192-168-1-1.local.konomi.tv:7000/tv/`
- **Mirakurun**: `http://192.168.1.1:40772`
- **EDCB Material WebUI**: `http://192.168.1.1:5510`

### 謝辞

このプロジェクトは他にも以下のプロジェクトを参考にしています：

- [nunawa/docker-dtv-server](https://github.com/nunawa/docker-dtv-server) - [LICENSE](https://github.com/nunawa/docker-dtv-server/blob/main/LICENSE)
- [tsukumijima/EDCB-Wine](https://github.com/tsukumijima/EDCB-Wine) - [LICENSE](https://github.com/tsukumijima/EDCB-Wine/blob/master/License.txt)
