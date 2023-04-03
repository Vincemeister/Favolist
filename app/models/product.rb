class Product < ApplicationRecord
  include PgSearch::Model

  belongs_to :list
  has_many_attached :photos
  has_one_attached :logo
  has_one :user, through: :list

  has_many :bookmarks, dependent: :destroy
  has_many :bookmarked_by, through: :bookmarks, source: :user

  has_many :comments, dependent: :destroy


  pg_search_scope :search_by_title_and_description_and_list_title_and_user_username,
    against: [:title, :description],
    associated_against: {
      list: [:title],
      user: [:username]
    },
    using: {
      tsearch: { prefix: true }
    }


    def bookmarked_by?(user)
      bookmarks.where(user_id: user.id).exists?
    end
end
