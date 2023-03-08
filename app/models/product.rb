class Product < ApplicationRecord
  belongs_to :list
  has_many_attached :photos
end
