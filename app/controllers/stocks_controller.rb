class StocksController < ApplicationController
  def search
    if params[:stock].empty?
      flash.now[:alert] = 'Please enter a symbol to search'
      respond_to do |format|
        format.js { render partial: 'users/result' }
      end
    else
      # using the Stock model
      # also creating a instance variable so the view can have access to it
      @stock = Stock.new_lookup(params[:stock])
      if @stock
        # AJAX reponse - makes use of _result.js.erb
        respond_to do |format|
          format.js { render partial: 'users/result' }
        end
      else
        flash.now[:alert] = 'Please enter a valid symbol to search'
        respond_to do |format|
          format.js { render partial: 'users/result' }
        end
      end
    end
  end
end
