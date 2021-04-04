class ApplicationController < ActionController::Base
  #before_action :authenticate_user!
  before_action :configure_permitted_parameters, if: :devise_controller?
  before_action :basic_auth if Rails.env.production?

  private
  def basic_auth
    authenticate_or_request_with_http_basic do |username, password|
      username ==ENV["BASIC_AUTH_USER"] && password == ENV["BASIC_AUTH_PASSWORD"]
    end
  end


  def configure_permitted_parameters
    devise_parameter_sanitizer.permit(:sign_up, keys:[:nickname,:email,:password,:name,:name_kana,:family_name,:family_name_kana,:birthday])
    devise_parameter_sanitizer.permit(:sign_in, keys:[:email,:password])
  end

end
