class User < ActiveRecord::Base
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  # Setup accessible (or protected) attributes for your model
  # attr_accessible :email, :password, :password_confirmation, :remember_me, :username
  
  devise :database_authenticatable, :registerable,:recoverable,
     :rememberable, :trackable, :validatable,:authentication_keys => [:username]
  has_many :profilepics
  has_many :articles
  has_many :comments, :as => :commentable
  
  validates :role,
    :inclusion  => { :in => [  'editor', 'moderator' ]}
    
  has_attached_file :avatar ,
		     #:storage => :database,
                     :processors => [ :cropper ],
		     :styles => { :medium => "300x300>", :small => "100x100#", :square => "200x200#", :large => "400x400>" },  
                     :default_url => "small.png"
                     
  validates_attachment_content_type :avatar, 
			:content_type => ["image/jpg", "image/jpeg", "image/png", "image/gif"]

  attr_accessor :crop_x, :crop_y, :crop_w, :crop_h
  after_update :reprocess_avatar, :if => :cropping? 

  def user_role
      self.user.role if self.user
  end
  def cropping?  
    !crop_x.blank? && !crop_y.blank? && !crop_w.blank? && !crop_h.blank?  
  end  

  def avatar_geometry(style = :original)  
    @geometry ||= {}  
    @geometry[style] ||= Paperclip::Geometry.from_file(avatar.path(style))  
  end  
  
  private  
  def reprocess_avatar  
    avatar.reprocess!  
  end
 
end
