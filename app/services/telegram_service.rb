# app/services/telegram_service.rb
class TelegramService
  require 'telegram/bot'

  def initialize(bot_token)
    @bot_token = bot_token
  end

  def send_message(chat_id, message)
    Telegram::Bot::Client.run(@bot_token) do |bot|
      bot.api.send_message(chat_id: chat_id, text: message)
    end
  end
end
