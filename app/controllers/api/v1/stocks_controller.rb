# app/controllers/api/v1/stocks_controller.rb
module Api::V1
  class StocksController < ApplicationController
    before_action :set_client

    def new
      if params[:symbol].present?
        symbols = params[:symbol].split(',')
        data = symbols.size > 1 ? @client.prices(symbols) : @client.price(symbols.first)
      else
        data = @client.price_all
      end

      render json: data
    end

    private

    def set_client
      @client = LatestStockPrice::Client.new
    end
  end
end
