class Message < ApplicationRecord
  after_create_commit { broadcast_message }

  def broadcast_message
    ActionCable.server.broadcast('MessagesChannel', {
      char_name: char_name,
      content: content,
      map: map
    })
  end

  validates :content, presence: true
end
