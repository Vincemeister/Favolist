class Product < ApplicationRecord
  include PgSearch::Model

  belongs_to :list
  has_many_attached :photos
  has_one_attached :logo
  belongs_to :user

  pg_search_scope :search_by_title_and_description_and_list_title_and_user_email,
    against: [:title, :description],
    associated_against: {
      list: [:title],
      user: [:email]
    },
    using: {
      tsearch: { prefix: true }
    }
end
