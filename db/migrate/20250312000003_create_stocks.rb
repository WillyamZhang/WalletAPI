# db/migrate/20250312000003_create_stocks.rb
class CreateStocks < ActiveRecord::Migration[7.0]
  def change
    create_table :stocks do |t|
      t.string :symbol, null: false, index: { unique: true }
      t.string :password_digest, null: false
      t.timestamps
    end
  end
end
