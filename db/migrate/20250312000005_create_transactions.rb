# db/migrate/20250312000005_create_transactions.rb
class CreateTransactions < ActiveRecord::Migration[7.0]
  def change
    create_table :transactions do |t|
      t.string :type, null: false
      t.decimal :amount, precision: 15, scale: 2, null: false
      t.references :source_wallet, foreign_key: { to_table: :wallets }, null: true
      t.references :target_wallet, foreign_key: { to_table: :wallets }, null: true
      t.timestamps
    end
  end
end
