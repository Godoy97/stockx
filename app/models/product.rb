class Product < ApplicationRecord
  belongs_to :user
  has_many :orders
  validates :name, :description, :price, :stock, :brand, :size, :color, presence: true
end
