class CreateOrders < ActiveRecord::Migration[7.1]
  def change
    create_table :orders do |t|
      t.text :fullname
      t.string :phonenumber
      t.string :emailadress
      t.integer :weight
      t.integer :length
      t.integer :width
      t.integer :height
      t.integer :distance
      t.integer :price
      t.string :departurepoint
      t.string :destinationpoint

      t.timestamps
    end
  end
end
