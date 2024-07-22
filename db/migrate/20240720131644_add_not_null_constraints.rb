class AddNotNullConstraints < ActiveRecord::Migration[7.1]
  def change
    def change
      change_column :trips, :distance, :integer, null: false
      change_column :trips, :from, :string, null: false
      change_column :trips, :to, :string, null: false
      change_column :trips, :date_beginning, :date, null: false
      change_column :trips, :date_end, :date, null: false
      change_column :cars, :brand, :string, null: false
      change_column :cars, :model, :string, null: false
      change_column :cars, :model, :string, null: false
    end
  end
end
