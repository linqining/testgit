# This file is auto-generated from the current state of the database. Instead
# of editing this file, please use the migrations feature of Active Record to
# incrementally modify your database, and then regenerate this schema definition.
#
# Note that this schema.rb definition is the authoritative source for your
# database schema. If you need to create the application database on another
# system, you should be using db:schema:load, not running all the migrations
# from scratch. The latter is a flawed and unsustainable approach (the more migrations
# you'll amass, the slower it'll run and the greater likelihood for issues).
#
# It's strongly recommended that you check this file into your version control system.

ActiveRecord::Schema.define(version: 20180404072502) do

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

  create_table "admin_users", force: :cascade, options: "ENGINE=InnoDB DEFAULT CHARSET=utf8" do |t|
    t.string "email", default: "", null: false
    t.string "encrypted_password", default: "", null: false
    t.string "reset_password_token"
    t.datetime "reset_password_sent_at"
    t.datetime "remember_created_at"
    t.integer "sign_in_count", default: 0, null: false
    t.datetime "current_sign_in_at"
    t.datetime "last_sign_in_at"
    t.string "current_sign_in_ip"
    t.string "last_sign_in_ip"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.string "group", comment: "分组（权限）"
    t.string "nickname", comment: "昵称"
    t.integer "section_id", comment: "区域地"
    t.index ["email"], name: "index_admin_users_on_email", unique: true
    t.index ["reset_password_token"], name: "index_admin_users_on_reset_password_token", unique: true
    t.index ["section_id"], name: "index_admin_users_on_section_id"
  end

  create_table "chats", force: :cascade, options: "ENGINE=InnoDB DEFAULT CHARSET=utf8" do |t|
    t.string "name"
    t.string "description"
    t.integer "admin_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "demanders", id: :integer, force: :cascade, options: "ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci" do |t|
    t.string "company_name"
    t.string "name"
    t.string "email"
    t.string "phone"
    t.string "emergency_call"
    t.string "company_fax"
    t.string "company_address"
    t.boolean "if_verified", default: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.string "encrypted_password", default: "", null: false
    t.string "reset_password_token"
    t.datetime "reset_password_sent_at"
    t.datetime "remember_created_at"
    t.integer "sign_in_count", default: 0, null: false
    t.datetime "current_sign_in_at"
    t.datetime "last_sign_in_at"
    t.string "current_sign_in_ip"
    t.string "last_sign_in_ip"
    t.string "sex"
    t.string "weixin_id"
    t.string "qq_id"
    t.string "address"
    t.string "company_tel"
    t.string "nvocc"
    t.string "wca"
    t.string "cgln"
    t.datetime "last_accept_at"
    t.datetime "last_refuse_at"
    t.boolean "if_banned", default: false
    t.string "represent_phone"
    t.string "represent_email"
    t.string "business_license"
    t.string "latest_review_status", default: "pending"
    t.string "source_type"
    t.string "member_type"
    t.boolean "can_upload_shipping", default: false
    t.boolean "can_publish_sea_flights", default: false
    t.boolean "if_gps", default: false
    t.string "gps_account"
    t.string "gps_password"
    t.boolean "if_check_company", default: true
    t.string "type"
    t.boolean "is_audit_booking", default: true, comment: "订单是否需要后台审核"
    t.integer "city_id"
    t.boolean "is_internal", default: false, comment: "内部账号"
    t.integer "message_unread", comment: "未读邮件"
    t.index ["city_id"], name: "index_demanders_on_city_id"
    t.index ["email"], name: "index_demanders_on_email", unique: true
    t.index ["reset_password_token"], name: "index_demanders_on_reset_password_token", unique: true
    t.index ["type", "id"], name: "index_demanders_on_type_and_id"
    t.index ["type"], name: "index_demanders_on_type"
  end

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

  create_table "messages", force: :cascade, options: "ENGINE=InnoDB DEFAULT CHARSET=utf8" do |t|
    t.text "body"
    t.integer "from_whom", comment: "0为用户信息，1为客服信息"
    t.bigint "device_id"
    t.integer "whom_id", comment: "如form_whom为0，记录用户ID；如form_whom为1，记录客服ID"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["device_id"], name: "index_messages_on_device_id"
  end

  create_table "serving_lists", force: :cascade, options: "ENGINE=InnoDB DEFAULT CHARSET=utf8" do |t|
    t.integer "admin_user_id"
    t.integer "user_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "users", force: :cascade, options: "ENGINE=InnoDB DEFAULT CHARSET=utf8" do |t|
    t.string "name"
    t.string "email"
    t.integer "role"
    t.string "password_digest"
    t.string "remember_digest"
    t.string "sex"
    t.string "phonenumber"
    t.string "status"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["email"], name: "index_users_on_email"
    t.index ["name"], name: "index_users_on_name"
  end

  create_table "views", force: :cascade, options: "ENGINE=InnoDB DEFAULT CHARSET=utf8" do |t|
    t.string "email", default: "", null: false
    t.string "encrypted_password", default: "", null: false
    t.string "reset_password_token"
    t.datetime "reset_password_sent_at"
    t.datetime "remember_created_at"
    t.integer "sign_in_count", default: 0, null: false
    t.datetime "current_sign_in_at"
    t.datetime "last_sign_in_at"
    t.string "current_sign_in_ip"
    t.string "last_sign_in_ip"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["email"], name: "index_views_on_email", unique: true
    t.index ["reset_password_token"], name: "index_views_on_reset_password_token", unique: true
  end

end
