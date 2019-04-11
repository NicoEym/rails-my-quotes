class CreateAssets < ActiveRecord::Migration[5.2]
  def change
    create_table :assets do |t|
      t.float :last_price
      t.float :daily_variation

      t.timestamps
    end
  end
end
