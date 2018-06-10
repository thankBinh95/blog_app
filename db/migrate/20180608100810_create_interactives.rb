class CreateInteractives < ActiveRecord::Migration[5.2]
  def change
    create_table :interactives do |t|
      t.integer :follower_id
      t.integer :followed_id

      t.timestamps
    end
    add_index :interactives, :follower_id
    add_index :interactives, :followed_id
    add_index :interactives, [:follower_id, :followed_id], unique: true
  end
end
