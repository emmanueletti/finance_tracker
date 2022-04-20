class ApplicationController < ActionController::Base
  # From the devise docs
  before_action :authenticate_user!
end
