class AddLikesToComments < ActiveRecord::Migration[7.2]
  def change
    add_column :comments, :likes, :integer
  end
end
