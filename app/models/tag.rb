class Tag < ActiveRecord::Base

  has_many :taggings
  has_many :articles, through: :taggings

  #def name   tag.name if tag  end
end
