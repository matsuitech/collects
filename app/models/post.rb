class Post < ApplicationRecord
  mount_uploader :post_image, ImagesUploader
  
  belongs_to :user
  
  validates :comment, presence: false, length: { maximum: 255 }
  validates :hash_tag, presence: true, length: { maximum: 255 }
  validates :post_image, presence: true
  
  has_many :hashtag_relations, dependent: :destroy
  has_many :hashtags, through: :hashtag_relations, dependent: :destroy
  
  #DBへのコミット直前に実施する
  after_create do
    post = Post.find_by(id: self.id)
    hashtags = self.hash_tag.scan(/[#＃][\w\p{Han}ぁ-ヶｦ-ﾟー]+/)
    post.hashtags = []
    hashtags.uniq.map do |hashtag|
      #ハッシュタグは先頭の'#'を外した上で保存
      tag = Hashtag.find_or_create_by(hash_name: hashtag.downcase.delete('#'))
      post.hashtags << tag
    end
  end
  
  before_update do
    post = Post.find_by(id: self.id)
    post.hashtags.clear
    hashtags = self.hash_tag.scan(/[#＃][\w\p{Han}ぁ-ヶｦ-ﾟー]+/)
    hashtags.uniq.map do |hashtag|
      tag = Hashtag.find_or_create_by(hash_name: hashtag.downcase.delete('#'))
      post.hashtags << tag
    end
  end
  
end
