class CreateLogs < ActiveRecord::Migration[7.0]
  def change
    create_table :logs do |t|
      t.integer :user_id
      t.string :user_name
      t.string :controller
      t.string :action
      t.string :method

      t.timestamps
    end
  end
end
