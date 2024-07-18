class CreateTrips < ActiveRecord::Migration[7.1]
  def change
    create_table :trips do |t|
      t.string :from
      t.string :to
      t.string :pitstop
      t.integer :distance
      t.date :date_beginning
      t.date :date_end
      t.references :user, null: false, foreign_key: true
      t.references :car, null: false, foreign_key: true

      t.timestamps
    end
  end
end
