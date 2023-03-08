class Product < ApplicationRecord
  belongs_to :list
  has_many_attached :photos
  has_one_attached :logo
end
