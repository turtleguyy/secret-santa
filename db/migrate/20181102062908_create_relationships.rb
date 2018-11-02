class CreateRelationships < ActiveRecord::Migration[5.2]
  def change
    create_table :relationships do |t|
      t.integer :user_id
      t.integer :family_id

      t.timestamps
    end

    add_index :relationships, [:user_id, :family_id]
  end
end
