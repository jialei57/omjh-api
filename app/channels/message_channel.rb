class MessageChannel < ApplicationCable::Channel
  def subscribed
    stream_from "message_#{params[:id]}"
  end

  def unsubscribed
    if params[:id] == 0
      current_user.disappear
    end
  end

  def send_message(data) 
    message = Message.new
    message.char_name = data['char_name']
    message.map = data['map']
    message.content = data['content']
    message.save
  end
end
