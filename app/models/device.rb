class Device < ApplicationRecord
  has_and_belongs_to_many :messages
  attr_accessor :is_new
end
