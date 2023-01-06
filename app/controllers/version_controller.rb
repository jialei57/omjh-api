class VersionController < ApplicationController 

    def mobile_app_version
        render json: { version: ENV['MOBILE_APP_VERSION'].to_i }
    end
end