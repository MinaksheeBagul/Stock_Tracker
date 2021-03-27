class UsersController < ApplicationController
  def my_portfolio
    # grabbing the user and seeing the stocks they are tracking
    # current user object who's logged in
    @tracked_stocks = current_user.stocks
  end

  def my_friends
    # will grabbing all users which current user grabbing.
    @friends = current_user.friends
  end
    # check view folder after this

    def search
      # render params that entered.
      # render json: params[:friend]
      if params[:friend].present?
        # friend instant variable
        # passing user.search from user.rb model
        @friends = User.search(params[:friend])
        # that will exclude your current user entry
        @friends = current_user.except_current_user(@friends)
        if @friends
          # responding to js with partial user-friend-result
          # check view-users-friend_result.js.erb
          # friend_result.js.erb rendering _friend_result.html.erb
          respond_to do |format|
            format.js { render partial: 'users/friend_result' }
          end
        else
          respond_to do |format|
            flash.now[:alert] = "Oops! User not found"
            format.js { render partial: 'users/friend_result' }
          end
        end    
      else
        respond_to do |format|
          flash.now[:alert] = "Please enter a friend name or email to search"
          format.js { render partial: 'users/friend_result' }
        end
      end
    end
end
