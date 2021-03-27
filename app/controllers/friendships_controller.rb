class FriendshipsController < ApplicationController
  def create
    # find friend based on id
    friend = User.find(params[:friend])
    # friend object and key friend_id
    current_user.friendships.build(friend_id: friend.id)
    # follow friend button action i.e used to store in db
    if current_user.save 
      flash[:notice] ="Yaay! you started following"
    else
      flash[:alert] = "Ooops! Went wrong"
    end
    redirect_to my_friends_path
  end

  def destroy
    # need to destroy current user friends where passing id.//first ie for one friend in one row.
    friendship = current_user.friendships.where(friend_id: params[:id]).first
    friendship.destroy
    flash[:notice] = "stopped following"
    redirect_to my_friends_path
  end
end
