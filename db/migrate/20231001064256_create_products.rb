class CreateProducts < ActiveRecord::Migration[7.0]
  def change
    create_table :products do |t|
      t.string :product_name
      t.text :description
      t.float :actual_price
      t.float :current_price
      t.references :supplier, null: false, foreign_key: true

      t.timestamps
    end
  end
end
