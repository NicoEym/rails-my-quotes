class AddAssetTypeToAsset < ActiveRecord::Migration[5.2]
  def change
    add_reference :assets, :asset_type, foreign_key: true
  end
end
