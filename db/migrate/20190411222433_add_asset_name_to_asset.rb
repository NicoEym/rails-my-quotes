class AddAssetNameToAsset < ActiveRecord::Migration[5.2]
  def change
    add_column :assets, :asset_name, :string
  end
end
