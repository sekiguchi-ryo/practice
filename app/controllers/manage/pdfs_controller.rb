class Manage::PdfsController < Manage::ManageController

  def new
    @pdf = Pdf.new
    @pdfs = Pdf.all
  end

  def create
    @pdf = Pdf.new(pdf_params)
    if @pdf.save
      # 成功
    else
      # 失敗
    end
    render 'new'
  end

  private

    def pdf_params
      params.require(:pdf).permit(:pdf)
    end
end