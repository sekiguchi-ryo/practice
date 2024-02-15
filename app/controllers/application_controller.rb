class ApplicationController < ActionController::Base
    before_action :render_maintenance_page_except_for_whilte_list_ips, if: :maintenance_mode?
    before_action :configure_permitted_parameters, if: :devise_controller?
    before_action :set_search

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

    def set_search
        @q = User.ransack(params[:q])
        @users = @q.result(distinct: true)
    end

    protect_from_forgery with: :null_session

    def create_token(user_id)
        payload = {user_id: user_id}
        secret_key = Rails.application.credentials.secret_key_base
        token = JWT.encode(payload, secret_key)
        return token
    end

    def authenticate
        authorization_header = request.headers[:authorization]
        if !authorization_header
          render_unauthorized
        else
          token = authorization_header.split(" ")[1]
          secret_key = Rails.application.credentials.secret_key_base
    
          begin
            decoded_token = JWT.decode(token, secret_key)
            @current_user = User.find(decoded_token[0]["user_id"])
          rescue ActiveRecord::RecordNotFound
            render_unauthorized
          rescue JWT::DecodeError
            render_unauthorized
          end
        end
      end
    
      def render_unauthorized
        render json: { errors: 'Unauthorized' }, status: :unauthorized
      end
end
