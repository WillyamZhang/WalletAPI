# app/controllers/api/v1/transactions/deposits_controller.rb
module Api::V1::Transactions
  class DepositsController < ApplicationController
    def create
      ActiveRecord::Base.transaction do
        deposit = Deposit.create!(deposit_params)
        render json: { message: "Deposit successful", transaction: deposit }, status: :created
      end
    rescue StandardError => e
      render json: { error: e.message }, status: :unprocessable_entity
    end        

    private

    def deposit_params
      params.permit(:amount).merge(target_wallet: current_owner.wallet)
    end
  end
end
