class Manage::UsersController < Manage::ManageController

  def index
    @q = User.ransack(params[:q])
    @users = @q.result.order("id ASC").page(params[:page]).per(10)
  end

  def show
    @user = User.find(params[:id])
  end

  def new
    @user = User.new
  end

  def create
    @user = User.new(user_params)
    if @user.save
      redirect_to @user
    else
      render 'new', status: :unprocessable_entity
    end
  end

  def import
    User.import(params[:file])
    redirect_to manage_users_path
  end

  private

    def user_params
      params.require(:user).permit(:name, :email, :password, :password_confirmation)
    end
end
