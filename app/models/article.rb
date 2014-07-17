class Article < ActiveRecord::Base
  
  validates :title, presence: true
  validates :text, presence: true
  belongs_to :category
  belongs_to :user
  has_many :taggings
  has_many :tags, through: :taggings
   
  def category_name
    self.category.name if self.category
  end
  def user_avatar
    self.user.avatar_file_name if self.user_id
  end
  def category_id
    self.category.id if self.category
  end
  def avatar_file_name
   self.user.avatar_file_name if self.user
  end
 
  #def self.tagged_with(name)
   # Tag.find_by_name(name).articles
  #end
  def tag_list
    self.tags.collect do |tag|
      tag.name
    end.join(", ")
  end
  
  def tag_list=(tags_string)
    tag_names = tags_string.split(",").collect{|s| s.strip.downcase}.uniq
    new_or_found_tags = tag_names.collect { |name| Tag.find_or_create_by(name: name) }
    self.tags = new_or_found_tags
  end

  private
  
  def article_params
    params.require(:article).permit(:title, :text, :tag_list)
  end

end
