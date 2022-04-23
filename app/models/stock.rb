class Stock < ApplicationRecord
  # To make a method a class method instead of an instance method, add "self"
  # in front. That means we do not need to instantiate the class first to be
  # able to use the method

  def self.new_lookup(ticker_symbol)
    # command: EDITOR="code --wait" rails credentials:edit to open up decrypted credentials
    # file with vscode as the text editor
    client = IEX::Api::Client.new(
      publishable_token: Rails.application.credentials.iex_client[:sandbox_api_key],
      endpoint: 'https://sandbox.iexapis.com/v1'
    )

    begin
      # will return an instantiation of the Stock class
      # don't need to write Stock.new since we are already inside the Stock class
      # Check the schema for all the properties needed to instantiate a model Class
      new(ticker: ticker_symbol, name: client.company(ticker_symbol).company_name,
          last_price: client.price(ticker_symbol))
    rescue StandardError => e
      nil
    end
  end
end
