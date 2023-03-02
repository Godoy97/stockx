class Product < ApplicationRecord
  belongs_to :user
  has_many :orders
  validates :name, :description, :price, :stock, :brand, :size, :color, presence: true #:photo
  has_one_attached :photo

  include PgSearch::Model
  pg_search_scope :search_by_name_and_brand,
    against: [ :name, :brand ],
    using: {
      tsearch: { prefix: true }
    }
end
