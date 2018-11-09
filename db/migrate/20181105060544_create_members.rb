class CreateMembers < ActiveRecord::Migration[5.2]
  def change
    create_table :members do |t|
      t.string :name
      t.integer :user_id
      t.integer :family_id
      t.integer :member_id
    end
  end
end
