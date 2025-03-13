# db/migrate/20250312000004_create_wallets.rb
class CreateWallets < ActiveRecord::Migration[7.0]
  def change
    create_table :wallets do |t|
      t.references :owner, polymorphic: true, null: false
      t.decimal :balance, precision: 15, scale: 2, default: 0, null: false
      t.timestamps
    end
  end
end
