class CreateMessage < ActiveRecord::Migration[5.1]
  def change
    create_table :messages do |t|
      t.text :body
      t.integer :from_whom, comment: "0为用户信息，1为客服信息"
      t.references :device, index:true
      t.references :admin_user, index: true
      t.integer  :user_id
      t.timestamps null: false
    end
  end
end
