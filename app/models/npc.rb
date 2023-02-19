class Npc < ApplicationRecord
    def die
        self.last_die_time = DateTime.now
        self.save
        ActionCable.server.broadcast("map_#{map}", {
            npc: id,
            action: 'npc_die'
            })
    end

    def isAlive 
        if last_die_time == nil
            return true
        end

        refereshTime = info['refresh_time'].to_i
        if last_die_time + refereshTime.seconds < DateTime.now
            return true
        end

        return false
    end
end
