class Manage::ImagesController < Manage::ManageController

  def new
    @image = Image.new
    @images = Image.all
  end

  def create
    @image = Image.new(image_params)
    if @image.save
      # 成功
    else
      # 失敗
    end
    redirect_to new_manage_image_path
  end

  private

    def image_params
      params.require(:image).permit(:img)
    end
end