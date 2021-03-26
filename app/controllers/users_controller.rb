class UsersController < ApplicationController
  def my_portfolio
    # grabbing the user and seeing the stocks they are tracking
    # current user object who's logged in
    @tracked_stocks = current_user.stocks
  end
end
