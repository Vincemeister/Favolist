class UsersController < ApplicationController
  before_action :set_user, only: [:show, :follow, :unfollow, :follows, :remove_follower]

  def index
    @users = User.where.not(id: current_user.id)
  end

  def follow
    if current_user.follow(@user.id)
      respond_to do |format|
        format.html { redirect_back(fallback_location: root_path) }
        format.js
      end
    end
  end

  def unfollow
    if current_user.unfollow(@user.id)
      respond_to do |format|
        format.html { redirect_back(fallback_location: root_path) }
        format.js { render action: :follow }
      end
    end
  end

  def remove_follower
    if current_user.remove_follower(@user.id)
      respond_to do |format|
        format.html { redirect_back(fallback_location: root_path) }
        format.js
      end
    end
  end

  def show
    @lists = @user.lists
  end

  def follows
    @followers = @user.followers
    @following = @user.following
  end



  private

  def set_user
    @user = User.find(params[:id])
  end
end
