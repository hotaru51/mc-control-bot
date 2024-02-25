# mc-control-bot

マイクラサーバの起動/停止をDiscordからやりたいやつ

## requirements

* Ruby 3.0.2

## installation

### 事前準備

* [Minecraftサーバ](https://github.com/hotaru51/home-server-playbook)を構築する
    * `build-essential` もnative extentionのビルドに必須
* [Discord Developer Portal](https://discord.com/developers/applications)でアプリを作成し、tokenを取得しておく
* 操作用に使用するテキストチャンネルを作成し、チャンネルIDを控えておく

### 手順

1. `/opt` 配下でリポジトリをcloneする
    ```sh
    cd /opt
    git clone git@github.com:hotaru51/mc-control-bot.git
    ```
1. `env_sample` を `.env` としてコピーし、tokenとチャンネルIDを設定
1. `unit_file/mc-control-bot.service` を `/etc/systemd/system` 配下にコピー
1. 下記コマンドを実行する
    ```sh
    # unit file反映
    systemctl daemon-reload

    # 自動起動有効化
    systemctl enable mc-control-bot.service

    # 起動
    systemctl start mc-control-bot.service
    ```
