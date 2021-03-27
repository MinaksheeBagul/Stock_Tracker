class User < ApplicationRecord
  # one user has multiple stocks 
  has_many :user_stocks
  # user has many stocks
  has_many :stocks, through: :user_stocks
  # user has many friends
  has_many :friendships
  # tracking friends
  has_many :friends, through: :friendships

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

  # checking field in search 
  def self.search(param)
    # strip method, empty spaces it will read of that
    param.strip!
    # will get all unique values here
    to_send_back = (first_name_matches(param) + last_name_matches(param) + email_matches(param)).uniq
    # if no results back then return nill
    return nil unless to_send_back
    # if not nill then to-send-back
    to_send_back
  end

  def self.first_name_matches(param)
    matches('first_name', param)
  end

  def self.last_name_matches(param)
    matches('last_name', param)
  end

  def self.email_matches(param)
    matches('email', param)
  end
  # i.e self method bcz we are using same class ie. user
  # i.e method that can take field name and match with our string.
  def self.matches(field_name, param)
    # matches the string or whatever param
    where("#{field_name} like ?", "%#{param}%")
  end

  def except_current_user(users)
    # its gonna reject the current user who's logged in and return list
    users.reject { |user| user.id == self.id}
  end

  def not_friends_with?(id_of_friend)
    # method for not showing results, if u r already friends with current user
    # not exists the return true otherwise return false.
    !self.friends.where(id: id_of_friend).exists?
  end
end
