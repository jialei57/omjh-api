class MapsController  < ApplicationController

    def index
        render json: Map.all
    end

    def show
        @map = Map.find_by_id(params[:id])
        render json: @map
    end
end