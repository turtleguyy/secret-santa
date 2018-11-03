class CreateFamilies < ActiveRecord::Migration[5.2]
  def change
    create_table :families do |t|
      t.string :name
      t.string :code
      t.date :event_date
      t.integer :user_id

      t.timestamps
    end
  end
end
