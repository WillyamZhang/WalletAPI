module Api::V1::Concerns::Authenticatable
  extend ActiveSupport::Concern

  AUTHENTICATABLE_MODELS = [User, Team, Stock].freeze

  def authenticate_owner(identifier, password)
    AUTHENTICATABLE_MODELS.each do |model|
      owner = model.find_by(lookup_column(model) => identifier)
      return owner if owner&.authenticate(password)
    end
    nil
  end

  private

  def lookup_column(model)
    case model.name
    when "User" then :email
    when "Team" then :name
    when "Stock" then :symbol
    else raise "Unknown model for authentication"
    end
  end
end
