require 'authorize_api_request'

class CharactersController < ApplicationController
  before_action :set_character, only: %i[update destroy get_processing_quests complete_quest killed_npc get_items]
    
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
    expToLevelUp = getCurrentLevelExp(0)
    startQuest = Quest.find_by_id(1)
    @character.status = {level: 0, exp: 0, expToLevelUp: expToLevelUp, items: [], skills: [], processingQuests: [1], completedQuests: []}

    if @character.save
      render json: @character, status: :created
    else
      render json: { errors: @character.errors.full_messages }, status: :unprocessable_entity
    end
  end

  # PATCH/PUT /characters/1
  # def update
  #   if @character.user_id != @current_user.id
  #     render json: { errors: @character.errors.full_messages }, status: :unprocessable_entity
  #     return
  #   end
    
  #   if @character.update(character_params)
  #     render json: @character
  #   else
  #     render json: { errors: @character.errors.full_messages }, status: :unprocessable_entity
  #   end
  # end

  def get_processing_quests
    if @character.user_id != @current_user.id
      render json: { errors: @character.errors.full_messages }, status: :unprocessable_entity
      return
    end

    quests = Quest.where(id: @character.status['processingQuests'])
    quests.each do |q|
      goals = q.goals
      items = goals['items']
      break if items == nil || items.empty?
      items.each do |i|
        im = Item.find_by_id(i['id'].to_i)
        i['item'] = im
      end
    end
    render json: quests
  end

  def get_items
    if @character.user_id != @current_user.id
      render json: { errors: @character.errors.full_messages }, status: :unprocessable_entity
      return
    end

    items = []
    @character.status['items'].each do |i|
      item = Item.find_by_id(i['id'])
      items.push({ 'item' => item, 'quantity' => i['quantity'] })
    end

    render json: items
  end

  def complete_quest
    if @character.user_id != @current_user.id
      render json: { errors: 'Character not yours!' }, status: :unprocessable_entity
      return
    end

    if @character.status['processingQuests'].exclude? params[:qid].to_i
      render json: { errors: 'Quest is not been accepted.' }, status: :unprocessable_entity
      return
    end

    quest = Quest.find_by_id(params[:qid])
    if quest == nil
      render json: { errors: 'No such quest.' }, status: :unprocessable_entity
      return
    end

    @character.status['processingQuests'].delete(quest.id)
    @character.status['completedQuests'].push(quest.id)
    @character.status['processingQuests'].push(quest.next) if quest.next != nil
    @character.save



    render json: @character
  end

  def killed_npc
    rewarded = {'items' => []}
    nids = params[:nids]
    nids.each do |n|
      npc = Npc.find_by_id(n)
      if npc == nil
        render json: { errors: 'No such npc.' }, status: :unprocessable_entity
        return
      end
  
      rewards = npc.info['rewards']
      if rewards != nil 
        rewards['items'].each do |i|
          odd = rand(0..1.0)
          if odd < i['probability']
            index = @character.status['items'].each_index.select {|e| @character.status['items'][e]['id'] == i['id']}
            if index != nil and index.first != nil
              @character.status['items'][index.first]['quantity'] += i['quantity'];
            else
              @character.status['items'].push({ 'id' => i['id'], 'quantity' => i['quantity'] })
            end
  
            item = Item.find_by_id(i['id'])
            rewarded['items'].push({ 'item' => item, 'quantity' => i['quantity'] })
            @character.save
          end
        end
      end

      npc.die
    end

    itemChanged =  !rewarded['items'].empty?
    render json: {char: @character, item_changed: itemChanged, reward: rewarded}
  end

  # DELETE /characters/1
  def destroy
    @character.destroy
  end

  def getCurrentLevelExp(level)
    case level
    when 0
      0
    when 1
      100
    when 2
      400
    when 3
      900
    when 4
      1400
    when 5
      2100
    when 6
      2800
    when 7
      3600
    when 8
      4500
    when 9
      5400
    when 10
      6500
    when 11
      7600
    when 12
      8800
    when 13
      10100
    when 14
      11400
    when 15
      12900
    when 16
      14400
    when 17
      16000
    when 18
      17700
    when 19
      19400
    when 20
      21300
    when 21
      23200
    when 22
      25200
    when 23
      27300
    when 24
      29400
    when 25
      31700
    when 26
      34000
    when 27
      36400
    when 28
      38900
    when 29
      41400
    when 30
      44300
    when 31
      47400
    when 32
      50800
    when 33
      54500
    when 34
      58600
    when 35
      62800
    when 36
      67100
    when 37
      71600
    when 38
      76100
    when 39
      80800
    when 40
      85700
    end
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
