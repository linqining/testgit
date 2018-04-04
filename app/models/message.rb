class Message < ApplicationRecord
  belongs_to :device
  belongs_to :admin_user

  sync :all

  sync_scope :by_device, ->(device){ where(device: device.id) }
  sync_scope :by_admin_user, ->(admin_user) { where(admin_user: admin_user.id) }
end
