class AddParentIdToOrganization < ActiveRecord::Migration[7.0]
  def change
    add_column :piyos, :parent_id, :integer
  end
end
