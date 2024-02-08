class ApplicationController < ActionController::Base
    before_action :configure_permitted_parameters, if: :devise_controller?

    protected

    def configure_permitted_parameters
        devise_parameter_sanitizer.permit(:sign_up, keys: [:name, :avatar])
    end

    def after_sign_in_path_for(resource)
        flash[:notice] = "ログインに成功しました" 
        manage_index_path
    end

    def after_sign_out_path_for(resource)
        flash[:notice] = "ログアウトしました"
        new_user_session_path
    end
end
