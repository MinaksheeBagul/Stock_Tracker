class Stock < ApplicationRecord
    # one stock has many users.
    has_many :user_stocks
    has_many :users, through: :user_stocks

    validates :name, :ticker, presence: true
    # defined a new_lookup method
    # self = not need to depend of instance var
    # directly call method from class
    def self.new_lookup(ticker_symbol)
        # will give us a client object, to return a stock price we can use price method.
        client = IEX::Api::Client.new(publishable_token: Rails.application.credentials.iex_client[:sandbox_api_key],
                                            secret_token: Rails.application.credentials.iex_client[:sandbox_secret_token],
                                            endpoint: 'https://sandbox.iexapis.com/v1') 
        # client object and params, method will receiving as an argument
        # client.price(ticker_symbol)   
        # this for wrong entry exception
        begin
        # instead of displaying a price only will create a custom object
            new(ticker: ticker_symbol,name: client.company(ticker_symbol), last_price: client.price(ticker_symbol))
        rescue => exception
            # if we enter wrong entry in search bar then will return nill 
            return nil    
        end
    end

    # if ticker is already present in db, this method is to cross verify (check user_stocks_controller.rb)
    def self.check_db(ticker_symbol)
        where(ticker: ticker_symbol).first
    end
end

