class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  has_many :lists
  # has_many :followers, class_name: "UserFollow", foreign_key: :following_id
  # has_many :followings, class_name: "UserFollow", foreign_key: :follower_id
  has_many :products, through: :lists
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable

  # def my_followings
  #   UserFollow.where(follower: self).map(&:following)
  # end

  # def my_followers
  #   UserFollow.where(following: self).map(&:follower)
  # end
end
