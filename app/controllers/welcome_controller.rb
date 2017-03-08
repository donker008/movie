class WelcomeController < ApplicationController

  def index
    flash[:notice] = "该吃药了！"
  end

end
