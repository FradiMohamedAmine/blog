class AddDislikesToComments < ActiveRecord::Migration[7.2]
  def change
    add_column :comments, :dislikes, :integer
  end
end
