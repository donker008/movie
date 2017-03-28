class ChangeMovieDefaultValueToMovie < ActiveRecord::Migration[5.0]
  def change
      change_column :movies, :view_count,:integer, default:0
  end
end
