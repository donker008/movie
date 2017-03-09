class Group < ApplicationRecord
  validates :title , presence: true

  belongs_to :user
  has_many :posts
  has_many :memebers, through: :group_relationships, sourece: :user
end
