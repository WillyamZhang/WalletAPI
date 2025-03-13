# app/controllers/api/v1/transactions/transfers_controller.rb
module Api::V1::Transactions
  class TransfersController < ApplicationController
    include Api::V1::Concerns::TargetOwner

    def create
      ActiveRecord::Base.transaction do
        transfer = Transfer.create!(transfer_params)
        render json: { message: "Transfer successful", transaction: transfer }, status: :created
      end
    rescue StandardError => e
      render json: { error: e.message }, status: :unprocessable_entity
    end

    private

    def transfer_params
      params.permit(:amount, :target_wallet_id).merge(source_wallet: current_owner.wallet, target_wallet: find_target_wallet&.wallet)
    end

    def find_target_wallet
      find_target_owner(params[:identifier])
    end
  end
end
