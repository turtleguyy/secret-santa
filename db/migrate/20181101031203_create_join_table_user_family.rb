class CreateJoinTableUserFamily < ActiveRecord::Migration[5.2]
  def change
    create_join_table :users, :families do |t|
      t.index [:user_id, :family_id]
    end
  end
end
