class CreateReactions < ActiveRecord::Migration[7.2]
  def change
    create_table :reactions do |t|
      t.string :reaction_type
      t.references :liker, null: false, foreign_key: { to_table: :users }
      t.references :likeable, polymorphic: true, null: false

      t.timestamps
    end
  end
end
