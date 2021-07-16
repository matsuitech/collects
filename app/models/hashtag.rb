class Hashtag < ApplicationRecord
    validates :hash_name, presence: true, length: { maximum: 99 }
    has_many :hashtag_relations, dependent: :destroy
    has_many :posts, through: :hashtag_relations, dependent: :destroy
end