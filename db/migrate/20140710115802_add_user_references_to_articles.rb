class AddUserReferencesToArticles < ActiveRecord::Migration
  def change
    add_column :articles, :username, :string, references: :users
  end
end
