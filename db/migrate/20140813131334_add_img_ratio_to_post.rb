class AddImgRatioToPost < ActiveRecord::Migration
  def change
    add_column :posts, :img_ratio, :string
  end
end
