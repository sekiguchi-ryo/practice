class Manage::RegistrationsController < Devise::RegistrationsController
  before_action :authenticate_user!

  def edit
    @user = current_user
  end

  protected

  def after_update_path_for(resource)
    edit_user_registration_path
  end

end