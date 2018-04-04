class CreateMessages < ActiveRecord::Migration[5.1]
  def change
    create_table :messages do |t|
      t.text :body
      t.references :device, index: true
      t.references :admin_user, index: true
      t.timestamps null: false
    end

  end
end
