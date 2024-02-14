class ApplicationController < ActionController::Base
    before_action :render_maintenance_page_except_for_whilte_list_ips, if: :maintenance_mode?
    before_action :configure_permitted_parameters, if: :devise_controller?

    protected

    def configure_permitted_parameters
        devise_parameter_sanitizer.permit(:sign_up, keys: [:name, :avatar])
        devise_parameter_sanitizer.permit(:account_update, keys: [:name, :avatar])
    end

    def after_sign_in_path_for(resource)
        flash[:notice] = "ログインに成功しました" 
        manage_hoge_index_path
    end

    def after_sign_out_path_for(resource)
        flash[:notice] = "ログアウトしました"
        new_user_session_path
    end

    def maintenance_mode?
        Setting.find(1).mode
    end

    def render_maintenance_page_except_for_whilte_list_ips
        ips_in_whitelist = Setting.find(1).ip_white_list.split(",")
        return if ips_in_whitelist.include?(request.remote_ip)

        render(
            file: Rails.public_path.join("maintenance.html"),
            content_type: "text/html",
            layout: false,
            status: :service_unavailable,
        )
    end
end
