class AddFamilyToUsers < ActiveRecord::Migration[5.2]
  def change
    add_column :users, :family_id, :integer
  end
end
