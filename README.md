# Docker DTV AIO Server (WIP)

Docker を使用した日本のデジタルテレビ放送受信・録画・ストリーミングのオールインワンソリューションです。

## 概要

このプロジェクトは、複数の DTV 関連ソフトウェアを Docker コンテナで統合し、簡単にセットアップ・管理できる環境を提供します。

## 設計思想

- `docker compose` で全て完結するセキュアで簡単なセットアップを目指します。
- 宣言的に環境構築を行い、手続き的に設定変更を行えます。
- コンテナ間のネットワーク分離を行い、セキュリティを強化します。
- 特権モードを使用せずに、必要なデバイスとリソースのみをコンテナに提供します。
- ホストマシンへのリソースの露出を最小限に抑えます。

## セットアップ

ホストマシンの IP アドレスが `192.168.1.1` の場合の例を示します。

### 1. 前提条件

- Docker と Docker Compose がインストールされていることを確認してください。
- NVidia GPU を使用する場合、NVIDIA Container Toolkit がインストールされていることを確認してください。
- Intel GPU を使用する場合、Intel GPU ドライバがホストにインストールされていることを確認してください。
- TV チューナーがホストマシンに接続されていることを確認してください。
- TV チューナーに対応するドライバがホストマシンにインストールされていることを確認してください。
- カードリーダーがホストマシンに接続されていることを確認してください。

### 2. セットアップ

```bash
git clone --recursive https://github.com/fa0311/docker-dtv-aio-server.git
cd docker-dtv-aio-server
docker compose build && docker compose up -d --wait && docker compose rm -f
sudo chown -R $UID:$GID .
```

初回起動はチャンネルスキャン, EPG 取得を行うため時間がかかります。
ビルドに 10 分、チャンネルスキャンに 5 分、EPG 取得に 40 分程度かかります。

### 3. 設定のカスタマイズ

- `docker-compose.yml` を編集して、設定をカスタマイズします。
- <http://192.168.70.3:5510/legacy/setting_bon.html> にアクセスして、ホストマシンに接続されている TV チューナーの設定を行います。

### アクセス方法

起動後、以下の URL でアクセスできます。

- **KonomiTV**: `https://192-168-1-1.local.konomi.tv:7000/`
- **Mirakurun**: `http://192.168.1.1:40772`
- **EDCB Material WebUI**: `http://192.168.1.1:5510`
- **Amatsukaze**: `http://192.168.1.1:32768`
- **Web Server**: `http://192.168.1.1:8080`
- **NFS**: `192.168.1.1` `nfsvers=4`
- **SMB**: `\\192.168.1.1\shares` `admin:password`

## チートシート

- 停止: `docker compose down`
- 起動: `docker compose up -d --wait`
- 再起動: `docker compose restart`
- ログ確認: `docker compose logs -f`
- 状態確認: `docker compose ps`
- 滅びの呪文: `docker compose down --rmi all --volumes --remove-orphans && git clean -xdf`
- 未使用データ一括削除: `docker system prune`
- 再スキャン: `rm config/Scanned/.done && rm config/.done`
- 設定リセット: `rm config/.done`

### 謝辞

このプロジェクトは他にも以下のプロジェクトを参考にしています：

- [nunawa/docker-dtv-server](https://github.com/nunawa/docker-dtv-server) - [LICENSE](https://github.com/nunawa/docker-dtv-server/blob/main/LICENSE)
- [tsukumijima/EDCB-Wine](https://github.com/tsukumijima/EDCB-Wine) - [LICENSE](https://github.com/tsukumijima/EDCB-Wine/blob/master/License.txt)
