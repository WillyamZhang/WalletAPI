# app/controllers/api/v1/transactions/withdrawals_controller.rb
module Api::V1::Transactions
  class WithdrawalsController < ApplicationController
    def create
      ActiveRecord::Base.transaction do
        withdrawal = Withdrawal.create!(withdrawal_params)
        render json: { message: "Withdrawal successful", transaction: withdrawal }, status: :created
      end
    rescue StandardError => e
      render json: { error: e.message }, status: :unprocessable_entity
    end

    private

    def withdrawal_params
      params.permit(:amount).merge(source_wallet: current_owner.wallet)
    end
  end
end
