class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :exception
 skip_before_action :authenticate_user!

 before_filter :configure_permitted_parameters, if: :devise_controller?

  

  rescue_from CanCan::AccessDenied do |exception|
  #flash[:error] = "Access denied."
  redirect_to root_url, :alert => 'Access denied. You are not sign up'
  end
  
  protected

  def configure_permitted_parameters
    devise_parameter_sanitizer.for(:sign_up) { |u| u.permit( :email, :password, :password_confirmation, :username, :firstname, :lastname, :address, :role)}

    devise_parameter_sanitizer.for(:sign_in) { |u| u.permit(:email, :password, :password_confirmation,:username, :avatar, :role)}
  end
 
end