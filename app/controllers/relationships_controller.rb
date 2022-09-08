class RelationshipsController < ApplicationController
  def create
    # Relationship.create(follower_id: current_user.id, followed_id: params[:user_id])
    current_user.follow(params[:user_id])
    redirect_to request.referer
  end

  def destroy
    current_user.unfollow(params[:user_id])
    redirect_to request.referer
  end

  def followers #フォローしている人一覧
    @user = User.find(params[:id])
    @users = User.follower_user
  end

  def followings　#フォローされている人一覧
    @user = User.find(params[:id])
    @users = User.followed_user
  end
end
