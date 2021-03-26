class ApplicationController < ActionController::Base
  # this line added to give an authentiction for user. (devise gem)
  before_action :authenticate_user!
  # this is use for update edit user and refer doc of gem devise
  before_action :configure_permitted_parameters, if: :devise_controller?

  protected

  # account update is for edit user
  def configure_permitted_parameters
    devise_parameter_sanitizer.permit(:account_update, keys: [:first_name, :last_name])
  end

  before_action :configure_permitted_parameters, if: :devise_controller?

  protected
  # for sign up and permisson for first name and last name user
  def configure_permitted_parameters
    devise_parameter_sanitizer.permit(:sign_up, keys: [:first_name, :last_name])
  end
end
