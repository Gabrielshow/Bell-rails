# app/controllers/containers_controller.rb
class ContainersController < ApplicationController
  def show
    # This action will render the container page with the modal
  end

  def send_to_telegram
    # Get the message from the form submission
    message = params[:message]

    # Send the message to Telegram
    send_message_to_telegram(message)

    # Redirect to a thank you or confirmation page
    redirect_to container_path, notice: 'Your message has been sent!'
  end

  private

  def send_message_to_telegram(message)
    bot = Telegram::Bot::Client.new(Rails.application.credentials.telegram[:bot_token])
    chat_id = 'your-chat-id-here'  # Replace with your Telegram chat ID

    # Send the message
    bot.api.send_message(chat_id: chat_id, text: message)
  end
end
