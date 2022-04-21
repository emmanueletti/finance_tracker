class StocksController < ApplicationController
  def search
    if params[:stock].empty?
      flash[:alert] = 'Please enter a symbol to search'
      redirect_to my_portfolio_path
    else
      # using the Stock model
      # also creating a instance variable so the view can have access to it
      @stock = Stock.new_lookup(params[:stock])
      render 'users/my_portfolio'
    end
  end
end
