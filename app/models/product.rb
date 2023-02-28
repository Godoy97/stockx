class Product < ApplicationRecord
  belongs_to :user
  validates :name, :description, :price, :stock, :brand, :size, :color, presence: true
end
