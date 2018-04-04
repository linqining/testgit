class Createmessage1 < ActiveRecord::Migration[5.1]
  create_table :messages do |t|
    t.text :body
    t.integer :from_whom, comment: "0为用户信息，1为客服信息"
    t.references :device, index:true
    t.integer  :whom_id, comment:"如form_whom为0，记录用户ID；如form_whom为1，记录客服ID"
    t.timestamps null: false
  end
end
