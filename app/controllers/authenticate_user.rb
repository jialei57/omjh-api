require 'json_web_token'

class AuthenticateUser
    prepend SimpleCommand
  
    def initialize(username, password)
      @username = username
      @password = password
    end
  
    def call
      # JsonWebToken.encode(user_id: user.id) if user
      if user
        token = JsonWebToken.encode(user_id: @user.id)
        @user.token = token
        @user.save(validate: false)
        return {'token' => token, 'user_id' =>  @user.id}
        # return {'token' => 'test', 'user_id' => user.id}
      end
      nil
    end
  
    private
  
    attr_accessor :username, :password
  
    def user
      @user = User.find_by_username(username)
      return @user if @user && @user.authenticate(password)
  
      errors.add :user_authentication, 'invalid credentials'
      nil
    end
  end