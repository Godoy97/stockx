class CreateProducts < ActiveRecord::Migration[7.0]
  def change
    create_table :products do |t|
      t.string :name
      t.string :description
      t.float :price
      t.integer :stock
      t.string :brand
      t.string :size
      t.string :color
      t.references :user, null: false, foreign_key: true

      t.timestamps
    end
  end
end
