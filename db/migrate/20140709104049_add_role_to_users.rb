class AddRoleToUsers < ActiveRecord::Migration
  def change
    add_column :users, :role, :string, :limit => [:admin,:editor,:moderator], :default => :editor 
     end
end
