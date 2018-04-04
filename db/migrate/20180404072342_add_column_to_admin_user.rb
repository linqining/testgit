class AddColumnToAdminUser < ActiveRecord::Migration[5.1]
  def change
    add_column :admin_users,:nickname,:string,comment: "昵称"
    add_column :admin_users,:section_id,:integer,comment: "区域地"
    add_index  :admin_users,:section_id
  end
end
