namespace :slurp do
  desc "TODO"
  task loadmap: :environment do
    require "csv"
    csv_text = File.read(Rails.root.join("lib", "data", "map.csv"))
    csv = CSV.parse(csv_text, :headers => true, :encoding => "UTF-8")
    csv.each do |row|
      # puts row.to_hash
      m = Map.new
      m.x = row["x"]
      m.y = row["y"]
      m.name = row["name"]
      m.group = row["group"]
      m.description = row["description"]
      if row["npcs"] != nil 
        m.npcs = row["npcs"].split(';').map(&:to_i)
      end
      m.save
    end
    puts "There are now #{Map.count} rows in the map table"
  end

end
