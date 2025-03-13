# app/models/transfer.rb
class Transfer < Transaction
  before_create :process_transfer

  private

  def process_transfer
    raise ActiveRecord::RecordInvalid.new(self), "Source and target wallets are required" if source_wallet.nil? || target_wallet.nil?
    raise ActiveRecord::RecordInvalid.new(self), "Insufficient funds" if source_wallet.balance < amount

    source_wallet.decrement!(:balance, amount)
    target_wallet.increment!(:balance, amount)
  end
end