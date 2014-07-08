class Profilepic < ActiveRecord::Base

  #attr_accessible :user_id, :original_file_name, :original_path, :crop_file_name, :crop_path
  belongs_to :users
  has_attached_file :profile_pic
 validates_attachment_content_type :profile_pic, :content_type => /^image\/(bmp|gif|jpg|jpeg|png)/

  # Validate the presence of the user id
  validates :user_id, :presence => true

 def user_id
      self.profilepic.user_id if profilepic
  end
# def original_file_name
 #     self.profilepic.original_file_name if profilepic
  #end
end
