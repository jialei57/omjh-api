class MapChannel < ApplicationCable::Channel
  def subscribed
    stream_from "map_#{params[:id]}"
  end

  def unsubscribed
    # Any cleanup needed when channel is unsubscribed
  end
end
