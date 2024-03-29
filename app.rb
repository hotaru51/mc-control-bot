# frozen_string_literal: true

require 'discordrb'
require 'dotenv'

require_relative 'lib/minecraft_controller'

# .envから設定を読み込む
Dotenv.load
TOKEN = ENV['MC_CTL_BOT_TOKEN']
CHANNLE_ID = ENV['MC_CTL_BOT_CHANNEL_ID']

TMP_DIR = "#{__dir__}/tmp".freeze
PID_FILE = "#{TMP_DIR}/pid".freeze
File.open(PID_FILE, 'w') do |f|
  f.write($PID)
end

bot_attributes = {
  token: TOKEN,
  channels: [CHANNLE_ID],
  prefix: 'うい、',
  help_command: false,
  ignore_bots: true
}

bot = Discordrb::Commands::CommandBot.new(**bot_attributes)

# @type event [Discordrb::Commands::CommandEvent]
bot.command :起動 do |event|
  event.send_message 'あいよぉ～'
  # @type out [String]
  # @type sts [Process::Status]
  err_message, sts = MinecraftController::Service.start

  if sts.success?
    '起動したよーん'
  else
    err_message
  end
end

# @type event [Discordrb::Commands::CommandEvent]
bot.command :停止 do |event|
  event.send_message 'あいよぉ～'
  # @type out [String]
  # @type sts [Process::Status]
  err_message, sts = MinecraftController::Service.stop

  if sts.success?
    '止めたよーん'
  else
    err_message
  end
end

# @type event [Discordrb::Commands::CommandEvent]
bot.command :状態 do |event|
  if MinecraftController::Service.active?
    '上がってるよぉ～'
  else
    '止まってるかコケてるかも？'
  end
end

at_exit do
  File.delete(PID_FILE) if File.exist?(PID_FILE)
  bot.stop
end

bot.run
