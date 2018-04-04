class CreateActlogs < ActiveRecord::Migration[5.1]
  def change
    create_table "actlogs", id: :integer, force: :cascade, options: "ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci" do |t|
      t.integer "device_status_id"
      t.text "original_fullpath"
      t.text "referer"
      t.string "path"
      t.string "action"
      t.integer "count_view"
      t.text "params"
      t.datetime "created_at", null: false
      t.datetime "updated_at", null: false
    end
  end
end
