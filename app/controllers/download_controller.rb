class DownloadController < ApplicationController 

    def download_map
        send_file(
            "#{Rails.root}/lib/data/map.csv",
            filename: "mpa.csv",
            type: "text/csv; charset=utf-8"
          )
    end
end