class User < ApplicationRecord
  # one user has multiple stocks 
  has_many :user_stocks
  has_many :stocks, through: :user_stocks
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
          :recoverable, :rememberable, :validatable

  # if stack already present in db or not
  def stock_already_tracked?(ticker_symbol)
    # check_db method we have already
    stock = Stock.check_db(ticker_symbol)
    return false unless stock
    stocks.where(id: stock.id).exists?
  end

  def under_stock_limit?
    # we are already in user model so no need to mention userstock class
    stocks.count < 10
  end

          # we are checking the stock under limit or not
  def can_track_stock?(ticker_symbol)
            # if under_stock_limit is true then will check limit
            # true or false => true->under_stock_limit and false -> stack_already_present
            under_stock_limit? && !stock_already_tracked?(ticker_symbol)
  end

  def full_name
    return "#{first_name} #{last_name}" if first_name || last_name
    "Anonymous"
  end
end
