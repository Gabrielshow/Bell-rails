# app/controllers/containers_controller.rb
class ContainersController < ApplicationController
  def show
    # This action will render the container page with the modal
  end

   def send_to_telegram
    # You can replace this with the appropriate logic to get the bot token and chat ID
    bot_token = ENV['TELEGRAM_BOT_TOKEN']  # Store the bot token securely, e.g., in environment variables
    chat_id = 'your_chat_id_here'  # Replace with your Telegram chat ID
    message = params[:message]  # This is just an example. You can extract message from params.

    # Initialize the TelegramService and send the message
    telegram_service = TelegramService.new(bot_token)
    telegram_service.send_message(chat_id, message)

    render json: { status: 'success' }
  end

  private

  def send_message_to_telegram(message)
    bot = Telegram::Bot::Client.new(Rails.application.credentials.telegram[:bot_token])
    chat_id = '1678259688'  # Replace with your Telegram chat ID

    # Send the message
    bot.api.send_message(chat_id: chat_id, text: message)
  end
end
