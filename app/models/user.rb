class User < ApplicationRecord
  has_many :user_stocks
  has_many :stocks, through: :user_stocks

  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable

  def can_track_stock?(ticker_symbol)
    under_stock_limit? && !currently_tracking?(ticker_symbol)
  end

  def under_stock_limit?
    stocks.count < 10
  end

  def currently_tracking?(ticker_symbol)
    stock = Stock.check_db(ticker_symbol)
    return false unless stock

    stocks.where(id: stock.id).exists?
  end

  def full_name
    if first_name
      "#{first_name} #{last_name}"
    else
      'Anonymous'
    end
  end
end
