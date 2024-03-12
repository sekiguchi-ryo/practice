class Manage::EditorsController < Manage::ManageController
  before_action :set_editor, only: %i[show]

  def index
    @editors = Editor.all
  end

  def new
    @editor = Editor.new
  end

  def show
  end

  def create
    @editor = Editor.new(editor_params)
    @editor.user_id = current_user.id
    if @editor.save
      redirect_to manage_editors_path
    else
      redirect_to manage_editors_path
    end
  end

  private
    
    def editor_params
      params.require(:editor).permit(:content)
    end

    def set_editor
      @editor = Editor.find(params[:id])
    end
end