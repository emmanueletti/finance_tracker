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

  def destroy
    stock_id = params[:id]
    stock = Stock.find(stock_id)
    user_stock = UserStock.where(user_id: current_user.id, stock_id: stock_id).first
    user_stock.destroy
    flash[:notice] = "Stock #{stock.ticker} was successfully untracked"
    # Issue with redirecting is that we are adding to the browsers history a bunch
    # of repetive pages - better is to have this functionality be an ajax request
    redirect_to my_portfolio_path
  end
end
