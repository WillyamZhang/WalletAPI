class ApplicationController < ActionController::API
  include Api::V1::Concerns::Authenticatable  # Include the concern

  before_action :authenticate_owner_from_session

  private

  def authenticate_owner_from_session
    @current_owner = find_authenticated_owner
    render json: { error: "Unauthorized" }, status: :unauthorized unless @current_owner
  end

  def current_owner
    @current_owner
  end

  def find_authenticated_owner
    return nil unless session[:owner_id] && session[:owner_type]
  
    owner_type = session[:owner_type].safe_constantize
    return nil unless owner_type&.respond_to?(:find_by)
  
    owner_type.find_by(id: session[:owner_id])
  end  
end
