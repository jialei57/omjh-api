class AuthenticationController < ApplicationController
    skip_before_action :authenticate_request
   
    def authenticate
      command = AuthenticateUser.call(params[:username], params[:password])
   
      if command.success?
        # puts '========================='
        # puts command.result
        # puts command.result['user_id']
        # puts '========================='
        ActionCable.server.broadcast("message_user-#{command.result['user_id']}", {
          online: true
        })
        render json: { auth_token: command.result['token'] }
      else
        render json: { error: command.errors }, status: :unauthorized
      end
    end
end