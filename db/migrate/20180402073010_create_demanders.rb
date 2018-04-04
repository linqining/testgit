class CreateDemanders < ActiveRecord::Migration[5.1]
  def change
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
  end
end
