class Friendship < ApplicationRecord
  belongs_to :user
  # that will again belongs to friend but class name is User not friend
  belongs_to :friend, class_name: 'User'
end
