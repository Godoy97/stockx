class AddFieldsToUsers < ActiveRecord::Migration[7.0]
  def change
    add_column :users, :address, :string
    add_column :users, :full_name, :string
    add_column :users, :seller, :boolean, default: false
  end
end
