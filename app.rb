# frozen_string_literal: true

require 'discordrb'
require 'dotenv'

require_relative 'lib/minecraft_controller'

# .envから設定を読み込む
Dotenv.load
TOKEN = ENV['MC_CTL_BOT_TOKEN']
CHANNLE_ID = ENV['MC_CTL_BOT_CHANNEL_ID']

bot = Discordrb::Commands::CommandBot.new(token: TOKEN, channels: [CHANNLE_ID], prefix: 'うい、')

# @type event [Discordrb::Commands::CommandEvent]
bot.command :起動 do |event|
  <<~MESSAGE
    テストだよ～ん

    channel: #{event.channel.id}
    user: #{event.author.id}
  MESSAGE
end

at_exit { bot.stop }
bot.run
