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

初回起動はビルドに 10 分、チャンネルスキャンに 5 分、EPG 取得に 40 分程度かかります。

#### アクセス方法

起動後、以下の URL でアクセスできます。

ホストマシンの IP アドレスが `192.168.1.1` の場合の例を示します。

- **KonomiTV**: `https://192-168-1-1.local.konomi.tv:7000/`
- **Mirakurun**: `http://192.168.1.1:40772`
- **EDCB Material WebUI**: `http://192.168.1.1:5510`
- **Amatsukaze**: `http://192.168.1.1:32768`
- **Web Server**: `http://192.168.1.1:8080`
- **NFS**: `192.168.1.1` `nfsvers=4`
- **SMB**: `\\192.168.1.1\shares` `admin:password`

### 3. 設定のカスタマイズ

あなたがもし以下に該当する場合は、`src/*` を編集します。該当しない場合は `config/*` を編集します。

- カスタマイズした設定を GitHub などで再共有したい場合
- 宣言的に環境を構築したい場合

`src/*` には `config/*` のデフォルト設定が含まれています。`config/*` は初回起動時に `src/*` からコピーされます。
`config/.done` ファイルが存在しない場合に、`config/*` が `src/*` からコピーされます。
一般的に、`src/*` の編集は高度なユーザー向けです。

#### NVidia GPU を使用する場合

デフォルトでは Intel GPU 用の設定になっています。NVidia GPU を使用する場合、`docker-compose.yml` を 2 箇所修正してください。

```diff yaml
- devices:
-   - /dev/dri/:/dev/dri/
+  deploy:
+    resources:
+      reservations:
+        devices:
+          - driver: nvidia
+            count: all
+            capabilities: [compute, utility, video]
```

`src/ConfigSetup/KonomiTV/config.yaml` を開き、`encoder` の値を `NVEncC` に変更してください。

```diff
- encoder: "QSVEncC"
+ encoder: "NVEncC"
```

#### セキュリティを強化する

デフォルトでは、一部のコンテナが特権モードで起動します。セキュリティを強化したい場合、`docker-compose.yml` を 3 箇所修正してください。
お使いのチューナーやカードリーダーに応じて、必要なデバイスのみをマッピングしてください。

```diff yaml
- privileged: true
+ devices:
+   - /dev/bus:/dev/bus
+   - /dev/px4video0:/dev/px4video0
+   - /dev/px4video1:/dev/px4video1
+   - /dev/px4video2:/dev/px4video2
+   - /dev/px4video3:/dev/px4video3
```

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
