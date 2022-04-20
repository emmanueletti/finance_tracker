class Stock < ApplicationRecord
  # To make a method a class method instead of an instance method, add "self"
  # in front. That means we do not need to instantiate the class first to be
  # able to use the method
  def self.new_lookup(ticker_symbol)
    return unless ticker_symbol.is_a? String

    client = IEX::Api::Client.new(
      publishable_token: '',
      endpoint: 'https://sandbox.iexapis.com/v1'
    )

    client.price(ticker_symbol)
  end
end
