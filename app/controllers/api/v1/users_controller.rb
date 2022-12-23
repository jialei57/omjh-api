class Api::V1::UsersController  < ApplicationController
    
    skip_before_action :authenticate_request, only: [:create]

    def show
        @user = User.find(params[:id]) 
        render json: {status: @user.status}
    end

    # POST /users
    def create
        @user = User.new(user_params)
        if @user.save
            render json: { message: 'success' }, status: :created
        else
            render json: { errors: @user.errors.full_messages }, status: :unprocessable_entity
      end
    end
  
    private 
        def user_params
            params.require(:user).permit(:username, :password)
        end
  end
  