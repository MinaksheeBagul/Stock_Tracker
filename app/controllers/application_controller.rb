class ApplicationController < ActionController::Base
  # this line added to give an authentiction for user. (devise gem)
  before_action :authenticate_user!
end
