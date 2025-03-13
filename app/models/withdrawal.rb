# app/models/withdrawal.rb
class Withdrawal < Transaction
  before_create :process_withdrawal

  private

  def process_withdrawal
    raise ActiveRecord::RecordInvalid.new(self), "Source wallet is required" if source_wallet.nil?
    raise ActiveRecord::RecordInvalid.new(self), "Insufficient funds" if source_wallet.balance < amount

    source_wallet.decrement!(:balance, amount)
  end
end
