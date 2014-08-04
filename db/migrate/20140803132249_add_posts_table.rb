class AddPostsTable < ActiveRecord::Migration
  def change
    create_table :posts do |t|
      t.text :body
      t.string :image

      t.timestamps
    end
  end

  def self.down
    drop_table :posts
  end
end
