class CreateDeviceStatuses < ActiveRecord::Migration[5.1]
  def change
    create_table "device_statuses", id: :integer, force: :cascade, options: "ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci" do |t|
      t.string "user_type"
      t.string "user_id"
      t.string "ip"
      t.integer "session_id"
      t.integer "device_id"
      t.boolean "is_new_device"
      t.datetime "created_at", null: false
      t.datetime "updated_at", null: false
      t.text "session"
      t.index ["device_id"], name: "device_id"
      t.index ["ip"], name: "ip"
      t.index ["session"], name: "session", length: { session: 255 }
      t.index ["user_id"], name: "user_id"
      t.index ["user_type", "user_id", "ip", "device_id", "session"], name: "user_type_2", length: { session: 255 }
      t.index ["user_type"], name: "user_type"
    end
  end
end
