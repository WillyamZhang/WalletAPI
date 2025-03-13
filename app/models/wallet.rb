# app/models/wallet.rb
class Wallet < ApplicationRecord
  belongs_to :owner, polymorphic: true
  has_many :source_transactions, class_name: "Transaction", foreign_key: "source_wallet_id"
  has_many :target_transactions, class_name: "Transaction", foreign_key: "target_wallet_id"

  validates :balance, numericality: { greater_than_or_equal_to: 0 }

  # Calculate current balance
  def update_balance!
    credits = target_transactions.sum(:amount)   # Money received
    debits = source_transactions.sum(:amount)    # Money sent
    update(balance: credits - debits)            # Correct balance calculation
  end
end
