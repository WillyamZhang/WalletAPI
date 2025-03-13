# app/controllers/concerns/target_owner.rb
module Api::V1::Concerns::TargetOwner
  extend ActiveSupport::Concern

  private

  def find_target_owner(identifier)
    [User, Team, Stock].each do |model|
      owner = case model.name
              when "User" then model.find_by(email: identifier)
              when "Team" then model.find_by(name: identifier)
              when "Stock" then model.find_by(symbol: identifier)
              end
      return owner if owner.present?
    end

    nil
  end
end
