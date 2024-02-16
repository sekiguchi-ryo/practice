class CreatePiyoHierarchies < ActiveRecord::Migration[7.0]
  def change
    create_table :piyo_hierarchies, id: false do |t|
      t.integer :ancestor_id, null: false
      t.integer :descendant_id, null: false
      t.integer :generations, null: false
    end

    add_index :piyo_hierarchies, [:ancestor_id, :descendant_id, :generations],
      unique: true,
      name: "piyo_anc_desc_idx"

    add_index :piyo_hierarchies, [:descendant_id],
      name: "piyo_desc_idx"
  end
end
