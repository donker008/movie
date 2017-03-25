class Movie < ApplicationRecord
  validates :title , :brief, :category, :cover_url, presence: true

belongs_to :user
belongs_to :category
end
