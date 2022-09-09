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

  
end
