# app/models/deposit.rb
class Deposit < Transaction
  before_create :process_deposit

  private

  def process_deposit
    raise ActiveRecord::RecordInvalid.new(self), "Target wallet is required" if target_wallet.nil?

    target_wallet.increment!(:balance, amount)
  end
end