class TextsController < ApplicationController
  
  def initialize
    sid = Rails.configuration.x.twilio.auth['account_sid']
    token = Rails.configuration.x.twilio.auth['auth_token']
    @client = Twilio::REST::Client.new(sid, token)
    @from_number = Rails.configuration.x.twilio.auth['from_number']
    @messages = []
  end
  
  def create
    params = text_params
    post_message(params[:to], params[:body])
  end
  
  def set_from_number(new_from_number)
    @from_number = new_from_number
  end
  
  def clear_message_history
    @messages = []
  end
  
  def post_message(to_number, body)
    message = @client.account.messages.create(
        :body => body,
        :to => to_number,
        :from => @from_number
        )
    @messages.push(message)
  end
  
  def check_error_code(message_index)
    @messages[message_index].ErrorCode
  end

  def check_error_message(message_index)
    @messages[message_index].error_message
  end
  
  private
  
  def text_params
    params.permit(:to, :body)
  end
end
