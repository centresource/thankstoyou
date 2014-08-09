class Post < ActiveRecord::Base

  belongs_to :user
  attr_accessor :confirmation
  mount_uploader :image, ImageUploader

  validates_acceptance_of :confirmation, :on => :create

  default_scope { order('created_at DESC') }


end
