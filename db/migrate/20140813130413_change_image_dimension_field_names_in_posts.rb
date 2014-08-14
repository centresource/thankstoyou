class ChangeImageDimensionFieldNamesInPosts < ActiveRecord::Migration
  def change
    rename_column :posts, :width, :img_width
    rename_column :posts, :height, :img_height
  end
end
