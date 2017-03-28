class AddFeatureCoverUrlToMovie < ActiveRecord::Migration[5.0]
  def change
    add_column :movies, :featurecoverurl, :string
  end
end
