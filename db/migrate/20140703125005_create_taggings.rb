class CreateTaggings < ActiveRecord::Migration
  def change
    create_table :taggings do |t|
      t.references :article
      t.references :tag
      
      t.timestamps
    end
  end
end
