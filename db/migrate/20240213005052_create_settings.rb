class CreateSettings < ActiveRecord::Migration[7.0]
  def change
    create_table :settings do |t|
      t.boolean :mode
      t.integer :api
      t.text :ip_black_list
      t.text :ip_white_list
      t.string :contact_email_address

      t.timestamps
    end
  end
end
