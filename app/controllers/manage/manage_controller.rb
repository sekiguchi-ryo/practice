class Manage::ManageController < ApplicationController
    before_action :authenticate_user!
    before_action :logging
    
    layout 'manage'

    def logging
        Log.create!(user_id: current_user.id,
                    user_name: current_user.name,
                    controller: controller_name,
                    action: action_name,
                    method: request.method)
    end
end