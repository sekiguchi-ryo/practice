class Manage::SettingController < Manage::ManageController
    def index
        @setting = Setting.find(1)
    end

    def edit
        @setting = Setting.find(1)
        @setting.update(setting_params)
        redirect_to manage_setting_index_path
    end

    private

    def setting_params
      params.require(:setting).permit(:mode, :api, :ip_black_list,
                                   :ip_white_list, :contact_email_address)
    end
end