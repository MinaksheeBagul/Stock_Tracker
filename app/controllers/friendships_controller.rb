class FriendshipsController < ApplicationController
  def create
  end

  def destroy
    # need to destroy current user friends where passing id.//first ie for one friend in one row.
    friendship = current_user.friendships.where(friend_id: params[:id]).first
    friendship.destroy
    flash[:notice] = "stopped following"
    redirect_to my_friends_path
  end
end
