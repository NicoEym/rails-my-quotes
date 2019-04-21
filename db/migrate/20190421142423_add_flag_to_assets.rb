class AddFlagToAssets < ActiveRecord::Migration[5.2]
  def change
    add_column :assets, :flag, :string
  end
end
