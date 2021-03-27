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
      render json: params[:friend]
    end
end
