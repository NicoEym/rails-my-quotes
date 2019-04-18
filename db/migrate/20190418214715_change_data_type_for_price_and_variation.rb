class ChangeDataTypeForPriceAndVariation < ActiveRecord::Migration[5.2]
  def change
    change_column :assets, :last_price, :string
    change_column :assets, :daily_variation, :string
  end
end
