# app/models/owner.rb
class Owner < ApplicationRecord
  self.abstract_class = true  # Prevents Rails from treating this as a database table

  require 'digest'

  has_one :wallet, as: :owner, dependent: :destroy

  after_create :create_wallet

  def password=(new_password)
    self.password_digest = Digest::SHA256.hexdigest(new_password)
  end

  def authenticate(given_password)
    Digest::SHA256.hexdigest(given_password) == self.password_digest
  end

  private

  def create_wallet
    Wallet.create!(owner: self)
  end
end
