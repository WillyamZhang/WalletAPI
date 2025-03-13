# app/controllers/api/v1/wallets_controller.rb
module Api::V1
  class WalletsController < ApplicationController
    def create
      wallet = Wallet.new(wallet_params)
      if wallet.save
        render json: { message: "Wallet created", wallet: wallet }, status: :created
      else
        render json: { error: wallet.errors.full_messages }, status: :unprocessable_entity
      end
    end

    def show
      wallet = Wallet.find(params[:id])
      render json: wallet
    rescue ActiveRecord::RecordNotFound
      render json: { error: "Wallet not found" }, status: :not_found
    end

    private

    def wallet_params
      params.require(:wallet).permit(:owner_id, :owner_type)
    end
  end
end
