class Article < ActiveRecord::Base

  validates :title, presence: true
  validates :text, presence: true
  belongs_to :category
  has_many :taggings
  has_many :tags, through: :taggings

  def category_name
      self.category.name if self.category
  end
  def tag_list
    self.taggings
  end

end