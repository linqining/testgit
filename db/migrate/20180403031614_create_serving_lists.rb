class CreateServingLists < ActiveRecord::Migration[5.1]
  def change
    create_table :serving_lists do |t|
      t.integer :admin_user_id
      t.integer :user_id
      t.timestamps
    end
  end
end
