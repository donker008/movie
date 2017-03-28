class ChangeFeatureCoverUrlToMovie < ActiveRecord::Migration[5.0]
  def change
      change_column :movies, :featurecoverurl, :text
  end
end
