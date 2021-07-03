class Post < ApplicationRecord
  mount_uploader :post_image, ImagesUploader
  
  belongs_to :user
  
  validates :comment, presence: false, length: { maximum: 255 }
  validates :hash_tag, presence: true, length: { maximum: 255 }
  validates :post_image, presence: true
end
