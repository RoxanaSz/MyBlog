class RegistrationsController < Devise:: RegistrationsController 
 
  private
 
  def sign_up_params
    params.require(:user).permit(:email, :password, :password_confirmation, :username, :firstname, :lastname, :address)
  end
 
  def account_update_params
    params.require(:user).permit(:email, :password, :password_confirmation, :current_password, :firstname, :lastname, :address)
  end
end
