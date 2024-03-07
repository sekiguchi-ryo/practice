class Manage::MessagesController < Manage::ManageController
  before_action :set_message, only: %i[show]

  def index
    @messages = Message.all
  end

  def new
    @message = Message.new
  end

  def show
  end

  def create
    @message = Message.new(message_params)
    @message.user_id = current_user.id
    if @message.save
      redirect_to manage_messages_path
    else
      redirect_to manage_messages_path
    end
  end

  private
  
    def message_params
      params.require(:message).permit(:content)
    end

    def set_message
      @message = Message.find(params[:id])
    end
end