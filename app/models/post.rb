class Post < ActiveRecord::Base

  belongs_to :user
  attr_accessor :confirmation
  mount_uploader :image, ImageUploader
  after_save :update_dimensions

  validates_acceptance_of :confirmation, :on => :create

  default_scope { order('created_at DESC') }

  def update_dimensions
    if self.image.present? && self.image.file.public_id.present?
      metadata = Cloudinary::Api.resource(self.image.file.public_id)
      img_ratio = metadata["width"] > metadata["height"] ? 'horz' : 'vert'
      self.update_columns(:img_width => metadata["width"], :img_height => metadata["height"], :img_ratio => img_ratio)
    end
  end
end
