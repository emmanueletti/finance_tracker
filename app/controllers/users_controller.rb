class UsersController < ApplicationController
  def my_portfolio
    # Devise gives a method to return the user object of the currently signed in user
    # check documentation for helper methods
    @tracked_stocks = current_user.stocks
  end
end
