class HomeController < ApplicationController
  def index
    @msg = params[:msg]
    @msg = 'App1' unless @msg
  end
end
