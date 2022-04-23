class UserStocksController < ApplicationController
  def create
    # stock = Stock.new_lookup(params[:ticker])
    stock = Stock.check_db(params[:ticker])
    if stock.blank?
      stock = Stock.new_lookup(params[:ticker])
      # We designed the new_lookup method to return a stock object which will have
      # the save method
      stock.save
    end
    @user_stock = UserStock.create(user: current_user, stock: stock)
    flash[:notice] = "Stock #{stock.name} was successfully added to your portfolio"
    redirect_to my_portfolio_path
  end
end
