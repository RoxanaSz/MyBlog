class Category < ActiveRecord::Base

  validates :name, presence: true
  has_many :articles
 
  def category_name
      self.category.name if self.category
  end
 
end
