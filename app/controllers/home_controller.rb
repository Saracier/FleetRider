class HomeController < ApplicationController
  def index
    flash[:notice] = "aaa"
  end
end
