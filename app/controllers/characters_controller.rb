require 'authorize_api_request'

class CharactersController < ApplicationController
  before_action :set_character, only: %i[update destroy ]
    
  # GET /characters
  def index
    @characters = Character.where(user_id: @current_user.id)
    render json: @characters
  end

  # POST /characters
  def create
    @count = Character.where(user_id: @current_user.id).count
    if @count >= ENV['CHARACTER_LIMI'].to_i
      render json: { errors: 'Character list is full' }, status: :unprocessable_entity
      return
    end

    @character = Character.new(character_params)

    if @character.save
      render json: @character, status: :created
    else
      render json: { errors: @character.errors.full_messages }, status: :unprocessable_entity
    end
  end

  # PATCH/PUT /characters/1
  def update
    if @character.update(character_params)
      render json: @character
    else
      render json: { errors: @character.errors.full_messages }, status: :unprocessable_entity
    end
  end

  # DELETE /characters/1
  def destroy
    @character.destroy
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_character
      @character = Character.find(params[:id])
    end

    # Only allow a list of trusted parameters through.
    def character_params
      params.fetch(:character, {}).merge(user_id: @current_user.id).permit!
    end
end
