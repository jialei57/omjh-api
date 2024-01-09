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
      m.quest_type = row['quest_type']
      m.level_required = row['level_required']
      m.pre_required = row['pre_required']
      m.start_npc = row['start_npc']
      m.end_npc = row['end_npc']
      m.start_line = row['start_line']
      m.mid_line = row['mid_line']
      m.end_line = row['end_line']
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
      m.item_type = row['item_type']
      m.description = row['description']
      m.price = row['price']
      m.properties = JSON.parse(row['properties'].gsub('\'', '"'))
      m.save
    end
    puts "There are now #{Item.count} rows in the Item table"
  end

  task loadSkills: :environment do
    require "csv"
    csv_text = File.read(Rails.root.join("lib", "data", "skills.csv"))
    csv = CSV.parse(csv_text, :headers => true, :encoding => "UTF-8", )
    csv.each do |row|
      # puts row.to_hash
      m = Skill.new
      m.id = row['id']
      m.name = row['name']
      m.description = row['description']
      m.action_desc = row['action_desc']
      m.save
    end
    puts "There are now #{Skill.count} rows in the Skill table"
  end
end
