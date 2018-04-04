class AddGroupToAdminUser < ActiveRecord::Migration[5.1]
  def change
    add_column :admin_users, :group, :string,comment: "分组（权限）"
  end
end
