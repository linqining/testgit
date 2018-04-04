class CreateDevices < ActiveRecord::Migration[5.1]
  def change
    create_table "devices", id: :integer, force: :cascade, options: "ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci" do |t|
      t.string "youtu_id"
      t.text "ua"
      t.boolean "is_null_cookie"
      t.integer "count_login"
      t.datetime "created_at", null: false
      t.datetime "updated_at", null: false
      t.index ["ua"], name: "ua", length: { ua: 255 }
      t.index ["youtu_id", "ua"], name: "youtu_id_and_ua", length: { ua: 255 }
      t.index ["youtu_id"], name: "index_devices_on_youtu_id"
    end
  end
end
