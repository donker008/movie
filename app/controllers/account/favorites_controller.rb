class Account::FavoritesController < ApplicationController
  before_action :authenticate_user! , only:[:index]

  def index
    
  end

  def favoriteIt

  end

end
