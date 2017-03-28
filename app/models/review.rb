class Review < ApplicationRecord
  belongs_to :movie
  belongs_to :user
  scope :recent, ->{ order("created_at desc") }
end
