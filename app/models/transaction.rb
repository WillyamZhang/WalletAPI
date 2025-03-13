# app/models/transaction.rb
class Transaction < ApplicationRecord
  self.inheritance_column = :type

  belongs_to :source_wallet, class_name: 'Wallet', optional: true
  belongs_to :target_wallet, class_name: 'Wallet', optional: true

  validates :amount, numericality: { greater_than: 0 }
  validates :target_wallet, presence: true, if: -> { type == 'Deposit' || type == 'Transfer' }
  validates :source_wallet, presence: true, if: -> { type == 'Withdrawal' || type == 'Transfer' }

  after_create :update_wallets

  private

  def update_wallets
    Wallet.transaction do
      source_wallet&.update_balance!
      target_wallet&.update_balance!
    end
  end
end
