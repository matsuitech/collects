class User < ApplicationRecord
    mount_uploader :image, ImagesUploader
    
    before_save { self.email.downcase! }
    validates :name, presence: true, length: { maximum: 20 },
                        uniqueness: { case_sensitive: true },
                        format: { with: /\A[a-zA-Z0-9]+\z/ }
    validates :email, presence: true, length: { maximum: 255 },
                        format: { with: /\A[\w+\-.]+@[a-z\d\-.]+\.[a-z]+\z/i },
                        uniqueness: { case_sensitive: false }
    has_secure_password
    
    has_many :posts, dependent: :destroy
    
    has_many :relationships, dependent: :destroy
    has_many :followings, through: :relationships, source: :follow, dependent: :destroy
    has_many :reverses_of_relationship, class_name: 'Relationship', foreign_key: 'follow_id', dependent: :destroy
    has_many :followers, through: :reverses_of_relationship, source: :user, dependent: :destroy
    
    def follow(other_user)
        unless self == other_user
            self.relationships.find_or_create_by(follow_id: other_user.id)
        end
    end
    
    def unfollow(other_user)
        relationship = self.relationships.find_by(follow_id: other_user.id)
        relationship.destroy if relationship
    end
    
    def following?(other_user)
        self.followings.include?(other_user)
    end
    
    def feed_posts
        Post.where(user_id: self.following_ids + [self.id])
    end
    
    validates :self_introduction, presence: false, length: { maximum: 255 }
end
