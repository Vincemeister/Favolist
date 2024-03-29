class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  has_one_attached :avatar
  has_many :lists, dependent: :destroy

  has_many :products, through: :lists
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable

  has_many :follower_relationships, foreign_key: :following_id, class_name: 'Follow'
  has_many :followers, through: :follower_relationships, source: :follower

  has_many :following_relationships, foreign_key: :follower_id, class_name: 'Follow'
  has_many :following, through: :following_relationships, source: :following

  has_many :bookmarks, dependent: :destroy
  has_many :bookmarked_products, through: :bookmarks, source: :product

  has_many :comments


  def follow(user_id)
    following_relationships.create(following_id: user_id)
  end

  def unfollow(user_id)
    following_relationships.find_by(following_id: user_id).destroy
  end

  def remove_follower(user_id)
    follower_relationships.find_by(follower_id: user_id).destroy
  end

  def is_following?(user_id)
    relationship = Follow.find_by(follower_id: id, following_id: user_id)
    relationship ? true : false
  end

  def follows
    @user = User.find(params[:id])
    @followers = @user.followers
    @following = @user.following
  end

end
