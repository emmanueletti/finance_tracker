class Stock < ApplicationRecord
  # To make a method a class method instead of an instance method, add "self"
  # in front. That means we do not need to instantiate the class first to be
  # able to use the method
  def self.new_lookup(ticker_symbol)
    return unless ticker_symbol.is_a? String

    # command: EDITOR="code --wait" rails credentials:edit to open up decrypted credentials
    # file with vscode as the text editor
    client = IEX::Api::Client.new(
      publishable_token: Rails.application.credentials.iex_client[:sandbox_api_key],
      endpoint: 'https://sandbox.iexapis.com/v1'
    )

    client.price(ticker_symbol)
  end
end
