class CreateContacts < ActiveRecord::Migration
  def change
    create_table :contacts do |t|
      t.string :name
      t.string :number
      t.string :user_id

      t.timestamps
    end
  end
end

