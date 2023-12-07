class ApiController < ApplicationController 

    def get_npc_related
        # npc_id = params[:id]

        # npc = Npc.includes(:start_quests).includes(:end_quests).find(npc_id)
        # if npc == nil
        #     render json: { errors: 'No such npc.' }, status: :unprocessable_entity
        #     return
        # end
        # skills = Skill.where(id: npc.info['skills'])
        # startQuests = Quest.where(start_npc: npc_id)
    
        # render json: {
        #     skills: skills,
        #     startQuests: npc.start_quests,
        #     endQuests: npc.end_quests
        #   }
        npcs = Npc.includes(:start_quests).includes(:end_quests).where(map: 5).select{|n| n.isAlive }
        npcs_with_related_quests = npcs.map do |npc|
            {
              npc: npc,
              start_quests: npc.start_quests,
              end_quests: npc.start_quests,
              skills: Skill.where(id: npc.info['skills'])
            }
          end

        render json: {
        npcs_with_related = npcs.map do |npc|

        }
    end
end