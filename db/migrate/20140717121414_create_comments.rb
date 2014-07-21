class CreateComments < ActiveRecord::Migration
  def change
     create_table :comments do |t|
      t.references :commentable, polymorphic: true
      t.string :subject
      t.text :content
      t.string :author_name, :author_email
      t.integer :author_id
      t.boolean :viewed
      

      t.timestamps
    end
  end
end
