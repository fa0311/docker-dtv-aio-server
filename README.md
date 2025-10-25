# Docker DTV AIO Server

Docker を使用した日本のデジタルテレビ放送受信・録画・ストリーミングのオールインワンソリューションです。

## 概要

このプロジェクトは、複数のDTV関連ソフトウェアをDockerコンテナで統合し、簡単にセットアップ・管理できる環境を提供します。

## セットアップ

### 1. リポジトリのクローン

```bash
git clone --recursive https://github.com/fa0311/docker-dtv-aio-server.git
cd docker-dtv-aio-server
docker compose up -d
```

初回起動はチャンネルスキャンを行うため時間がかかります。


## アクセス方法

起動後、以下のURLでアクセスできます。以下はホストマシンのIPアドレスが `192.168.1.1` の場合の例を示しています。

- **KonomiTV**: `https://192-168-1-1.local.konomi.tv:7000/tv/`
- **Mirakurun**: `http://192.168.1.1:40772`
- **EDCB Material WebUI**: `http://192.168.1.1:5510`


### 謝辞

このプロジェクトは他にも以下のプロジェクトを参考にしています：

- [nunawa/docker-dtv-server](https://github.com/nunawa/docker-dtv-server) - [LICENSE](https://github.com/nunawa/docker-dtv-server/blob/main/LICENSE)
- [tsukumijima/EDCB-Wine](https://github.com/tsukumijima/EDCB-Wine) - [LICENSE](https://github.com/tsukumijima/EDCB-Wine/blob/main/LICENSE)

