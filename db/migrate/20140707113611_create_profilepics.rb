class CreateProfilepics < ActiveRecord::Migration
  def change
    create_table :profilepics do |t|
      t.references :user
      t.string :original_file_name
      t.string :original_path
      t.string :crop_file_name
      t.string :crop_path

      t.timestamps
    end
  end
end
