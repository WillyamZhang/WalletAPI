require 'net/http'
require 'json'

module LatestStockPrice
  class Client
  
    def initialize
      @api_url = ENV["API_URL"]
      raise "Missing API URL. Set API_URL in ENV." unless @api_url

      @api_key = ENV["RAPIDAPI_KEY"]
      raise "Missing API Key. Set RAPIDAPI_KEY in ENV." unless @api_key
    end

    def price(symbol)
      fetch({ Identifier: symbol }) # Pass as hash, so it gets encoded
    end
    
    def prices(symbols)
      fetch({ Identifier: symbols.join(',') }) # Pass as hash, properly encoded
    end    

    def price_all
      fetch
    end

    private

    def fetch(params = {})
      uri = URI(@api_url)
      uri.query = URI.encode_www_form(params) unless params.empty? # Encode params

      req = Net::HTTP::Get.new(uri)
      req["X-RapidAPI-Key"] = @api_key
      req["X-RapidAPI-Host"] = "latest-stock-price.p.rapidapi.com"

      response = Net::HTTP.start(uri.hostname, uri.port, use_ssl: true) { |http| http.request(req) }

      case response
      when Net::HTTPSuccess
        JSON.parse(response.body)
      else
        { error: "Request failed", status: response.code, message: response.message }
      end
    end

  end
end
