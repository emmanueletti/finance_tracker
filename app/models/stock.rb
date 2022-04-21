class Stock < ApplicationRecord
  # To make a method a class method instead of an instance method, add "self"
  # in front. That means we do not need to instantiate the class first to be
  # able to use the method

  def self.new_lookup(ticker_symbol)
    return if ticker_symbol.empty?
    return unless ticker_symbol.is_a? String

    Stock.initialize_client

    begin
      # will return an instantiation of the Stock class
      # don't need to write Stock.new since we are already inside the Stock class
      # Check the schema for all the properties needed to instantiate a model Class
      company = client.company(ticker_symbol)
    rescue StandardError
      nil
    else
      new(ticker: ticker_symbol, name: company.company_name, last_price: client.price(ticker_symbol))
    end
  end

  def make_api_call
    # command: EDITOR="code --wait" rails credentials:edit to open up decrypted credentials
    # file with vscode as the text editor
    client = IEX::Api::Client.new(
      publishable_token: Rails.application.credentials.iex_client[:sandbox_api_key],
      endpoint: 'https://sandbox.iexapis.com/v1'
    )

    { "name": client.company(ticker_symbol) }
  end

  def self.initialize_client; end
end
