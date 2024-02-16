class CreatePiyos < ActiveRecord::Migration[7.0]
  def change
    create_table :piyos do |t|

      t.timestamps
    end
  end
end
