class CreateMovies < ActiveRecord::Migration[5.0]
  def change
    create_table :movies do |t|
      t.string :title
      t.text :brief
      t.integer :user_id
      t.integer :view_count
      t.integer :review_count
      t.string :cover_url
      t.integer :category_id

      t.timestamps
    end
  end
end
