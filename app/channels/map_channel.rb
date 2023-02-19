class MapChannel < ApplicationCable::Channel
  def subscribed
    stream_from "map_#{params[:id]}"
    current_user.appear

    broadcast_all_players_in_map
  end

  def unsubscribed
    stop_stream_from "map_#{params[:id]}"
    broadcast_player_leave_map
  end

  def broadcast_all_players_in_map
    char = Character.find(params[:charId])
    char.update(map: params[:id])
    chars = Character.where(map: params[:id]).joins(:user).where(users: { online: true })
    npcs = Npc.where(map: params[:id]).select{|n| n.isAlive }
    ActionCable.server.broadcast("map_#{params[:id]}", {
      map: params[:id],
      players: chars.to_json,
      npcs: npcs.to_json,
      action: 'enter'
    })
  end 

  def broadcast_player_leave_map
    char = Character.find(params[:charId])
    ActionCable.server.broadcast("map_#{params[:id]}", {
      map: params[:id],
      player: char.to_json,
      action: 'leave'
    })
  end
end
