# app/controllers/api/v1/sessions_controller.rb
module Api::V1
  class SessionsController < ApplicationController
    include Api::V1::Concerns::Authenticatable
    before_action :authenticate_owner_from_session, except: :create

    def create
      owner = authenticate_owner(params[:identifier], params[:password])
      if owner
        session[:owner_id] = owner.id
        session[:owner_type] = owner.class.name
        render json: { message: "Login successful", owner_type: owner.class.name.downcase }
      else
        render json: { error: "Invalid credentials" }, status: :unauthorized
      end
    end

    def destroy
      reset_session
      render json: { message: "Logged out successfully" }
    end
  end
end

