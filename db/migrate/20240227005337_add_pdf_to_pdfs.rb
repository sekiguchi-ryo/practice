class AddPdfToPdfs < ActiveRecord::Migration[7.0]
  def change
    add_column :pdfs, :pdf, :string
  end
end
