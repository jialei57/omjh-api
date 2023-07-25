namespace :slurp do
  desc "TODO"
  # task loadmap: :environment do
  #   require "csv"
  #   csv_text = File.read(Rails.root.join("lib", "data", "map.csv"))
  #   csv = CSV.parse(csv_text, :headers => true, :encoding => "UTF-8")
  #   csv.each do |row|
  #     # puts row.to_hash
  #     m = Map.new
  #     m.id = row['id']
  #     m.x = row["x"]
  #     m.y = row["y"]
  #     m.name = row["name"]
  #     m.city = row["city"]
  #     m.description = row["description"]
  #     m.save
  #   end
  #   puts "There are now #{Map.count} rows in the map table"
  # end

  task loadNpcs: :environment do
    require "csv"
    csv_text = File.read(Rails.root.join("lib", "data", "npcs.csv"))
    csv = CSV.parse(csv_text, :headers => true, :encoding => "UTF-8", )
    csv.each do |row|
      # # puts row.to_hash
      m = Npc.new
      m.id = row['id']
      m.name = row["name"]
      m.map = row["map"]
      m.npc_type = row["npc_type"]
      m.last_die_time = row["last_die_time"]
      m.status = JSON.parse(row['status'].gsub('\'', '"'))
      m.info = JSON.parse(row["info"].gsub('\'', '"'))
      m.save
    end
    puts "There are now #{Npc.count} rows in the Npc table"
  end

  task loadQuests: :environment do
    require "csv"
    csv_text = File.read(Rails.root.join("lib", "data", "quests.csv"))
    csv = CSV.parse(csv_text, :headers => true, :encoding => "UTF-8", )
    csv.each do |row|
      # # puts row.to_hash
      m = Quest.new
      m.id = row['id']
      m.name = row['name']
      m.description = row['description']
      m.is_main = row['is_main']
      m.next = row['next']
      m.goals = JSON.parse(row['goals'].gsub('\'', '"'))
      m.rewards = JSON.parse(row['rewards'].gsub('\'', '"'))
      m.save
    end
    puts "There are now #{Quest.count} rows in the Quest table"
  end

  task loadItems: :environment do
    require "csv"
    csv_text = File.read(Rails.root.join("lib", "data", "items.csv"))
    csv = CSV.parse(csv_text, :headers => true, :encoding => "UTF-8", )
    csv.each do |row|
      # puts row.to_hash
      m = Item.new
      m.id = row['id']
      m.name = row['name']
      m.is_unique = row['is_unique']
      m.item_type = row['item_type']
      m.info = JSON.parse(row['info'].gsub('\'', '"'))
      m.save
    end
    puts "There are now #{Item.count} rows in the Item table"
  end
end
