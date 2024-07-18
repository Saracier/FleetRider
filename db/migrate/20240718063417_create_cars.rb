class CreateCars < ActiveRecord::Migration[7.1]
  def change
    create_table :cars do |t|
      t.string :brand
      t.string :model
      t.string :picture
      t.decimal :run
      t.decimal :fuel_consumption

      t.timestamps
    end
  end
end
