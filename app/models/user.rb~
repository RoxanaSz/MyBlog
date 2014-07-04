class User < ActiveRecord::Base
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  # Setup accessible (or protected) attributes for your model
  # attr_accessible :email, :password, :password_confirmation, :remember_me, :username
  devise :database_authenticatable, :registerable,:recoverable,
     :rememberable, :trackable, :validatable,:authentication_keys => [:username]
 # attr_accessor :username
end
