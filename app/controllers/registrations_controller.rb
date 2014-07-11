class RegistrationsController < Devise:: RegistrationsController 


   #before_filter :check_permissions, :only => [:new, :create, :cancel]
  #skip_before_filter :require_no_authentication
 skip_before_action :authenticate_user!
  def check_permissions
    authorize! :create, resource
  end
  
  private
 
  def user_params
    params.require(:user).permit(:email, :password, :password_confirmation, :firstname, :lastname, :address, :avatar, :role)
  end

  def sign_up_params
    params.require(:user).permit(:email, :password, :password_confirmation, :username, :firstname, :lastname, :address,:role )
  end
 
  def account_update_params
    params.require(:user).permit(:email, :password, :password_confirmation, :current_password, :firstname, :lastname, :address, :avatar, :role )
  end
end
