# frozen_string_literal: true

require 'open3'

# Minecraftサーバを操作するモジュール
module MinecraftController
  # Minecraftサーバの起動/停止を実行するクラス
  class Service
    # minecraftサービスに対してsystemctlコマンドを実行する
    # @param state [String] サービス起動状態(start, stop, restart etc...)
    # @return [Array(String, Process::Status)] Discord用に整形済みの出力と実行結果
    def self.exec_systemctl(state)
      # @type sts [Prcess::Status]
      out, err, sts = Open3.capture3('/usr/bin/systemctl', state, 'minecraft')

      message = if sts.success?
                  ''
                else
                  error_message(out, err)
                end

      [message, sts]
    end

    # Discord用のエラーメッセージを生成する
    # @param out [String] 標準出力
    # @param err [String] 標準エラー出力
    # @return [String] Discord用に整形した出力
    def self.error_message(out, err)
      <<~MESSAGE
        あれ…？ エラーっぽい…？

        ```
        # stdtout
        #{out}

        # stderr
        #{err}
        ```
      MESSAGE
    end

    # Minecraftサーバを起動する
    # @return [Array(String, Process::Status)] Discord用に整形された出力と実行結果
    def self.start
      exec_systemctl('start')
    end

    # Minecraftサーバを停止する
    # @return [Array(String, Process::Status)] Discord用に整形された出力と実行結果
    def self.stop
      exec_systemctl('stop')
    end

    # Minecraftサーバの起動状態を確認する
    # @return [Boolean] 起動状態
    def self.active?
      out, sts = Open3.capture2('systemctl', 'is-active', 'minecraft')

      out.chomp == 'active' && sts.success?
    end
  end
end
