class VersionController < ApplicationController 

    def mobile_app_version
        render json: { version: ENV['MOBILE_APP_VERSION'].to_i }
    end

    def map_version
        csv_path = "#{Rails.root}/lib/data/map.csv"
        version = read_csv_version(csv_path)
      
        render json: { version: version}.to_json
    end

    def read_csv_version(csv_path)
        require "csv"
        return 0 unless File.exist?(csv_path)
        csv_text = File.read(csv_path)
        csv = CSV.parse(csv_text, :headers => true, :encoding => "UTF-8")
        csv.headers.first.to_i
    end
end