class ChangeEditorToText < ActiveRecord::Migration[7.0]
  def up
    change_column :editors, :content, :text, default: nil
  end

  def down
    change_column :editors, :content, :string
  end
end
