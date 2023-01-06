class MessagesController  < ApplicationController
    
    # POST /messages
    def create
        @message = Message.new(message_params)
        if @message.save
            render json: { message: 'success' }, status: :created
        else
            render json: { errors: @message.errors.full_messages }, status: :unprocessable_entity
      end
    end

    private

    # Only allow a list of trusted parameters through.
    def message_params
      params.fetch(:message, {}).permit!
    end
end
  