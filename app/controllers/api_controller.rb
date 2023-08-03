class ApiController < ApplicationController 

    def get_npc_skills
        npc = Npc.find(params[:id])
        if npc == nil
            render json: { errors: 'No such npc.' }, status: :unprocessable_entity
            return
        end
        skills = []
        if (npc.info['skills'] != nil)
            npc.info['skills'].each do |i|
            skill = Skill.find_by_id(i)
            skills.push(skill)
            end
        end
    
        render json: skills
    end
end