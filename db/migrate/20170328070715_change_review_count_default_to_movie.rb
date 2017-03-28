class ChangeReviewCountDefaultToMovie < ActiveRecord::Migration[5.0]
  def change
    change_column :movies, :review_count, :integer, default:0
  end
end
